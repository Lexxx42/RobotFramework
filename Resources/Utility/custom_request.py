""" Module contains class for sending requests and it's methods. """

from datetime import datetime
from http.cookiejar import CookieJar

import requests
from pydantic import BaseModel

from Resources.Utility.custom_response import CustomResponse
from Resources.Utility.logger import log_request, log_response
from Resources.Utility.model import convert_models_to_request


class Request:
    """ Class for api requests. """
    data: dict
    files: dict
    json: dict
    params: dict
    url: str

    headers: dict = {}
    token_cache: dict[str, tuple[str, datetime]] = {}

    def __init__(self, *args, **kwargs):
        self.url = ''

    def __new__(cls, *args, **kwargs):
        obj = super().__new__(cls)

        for attr in ('data', 'json', 'params', 'files'):
            obj.__setattr__(attr, {})

        obj.__init__(*args, **kwargs)

        return obj

    def request(
            self,
            url: str,
            method: str = 'GET',
            headers: dict | None = None,
            data: dict | list | str | bytes | BaseModel | None = None,
            params: dict | BaseModel | None = None,
            timeout: int | float = 10,
            files: dict | list | None = None,
            json: dict | BaseModel | list | None = None,
            cookies: dict | CookieJar | None = None,
            needs_log: bool = True,
            response_model: type[BaseModel] | None = None,
            response_error_model: type[BaseModel] | None = None,
            **kwargs,
    ) -> CustomResponse:
        json, data, params = convert_models_to_request(
            json=json if json else self.json,
            data=data if data else self.data,
            params=params if params else self.params,
            **kwargs
        )

        if needs_log:
            log_request(
                request=requests.Request(
                    url=url,
                    method=method,
                    headers=headers if headers else self.headers,
                    params=params,
                    data=data,
                    json=json,
                    cookies=cookies
                ).prepare(),
                is_insecure=True
            )

        response = requests.request(
            url=url,
            method=method,
            headers=headers if headers else self.headers,
            params=params,
            data=data,
            files=files if files else self.files,
            json=json,
            verify=False,
            timeout=timeout,
            cookies=cookies
        )

        log_response(response=response)
        for attr in [self.data, self.json, self.files, self.params]:
            attr.clear()

        return CustomResponse(
            response=response,
            response_model=response_model,
            response_error_model=response_error_model
        )
