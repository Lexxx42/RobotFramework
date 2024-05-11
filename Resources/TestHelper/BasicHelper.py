from pydantic import BaseModel
from robot.api.deco import keyword

from Resources.Api.reqres_api import ReqresApi
from Resources.Utility.custom_response import CustomResponse
from Resources.Utility.model import Model

AVAILABLE_REQUESTS = {
    'get single user': ReqresApi().get_single_user
}


class BasicHelper:
    response: CustomResponse | None = None

    @keyword
    def send_request(self, reqres_method: str, **kwargs):
        available_methods = AVAILABLE_REQUESTS.keys()

        if reqres_method not in available_methods:
            raise NotImplementedError(f'No method {reqres_method}! Use one of the following: {available_methods}')

        self.response = AVAILABLE_REQUESTS[reqres_method](**kwargs)

    @keyword
    def check_status_code(self, exp_code: int):
        if self.response is None:
            raise ValueError('You have to send request first!')

        self.response.assert_status_code(expected_code=exp_code)

    @keyword
    def check_response_model_is_valid(self, validation_model: type[Model] | None = None):
        if self.response is None:
            raise ValueError('You have to send request first!')

        if validation_model is not None and str(validation_model) != 'None':
            self.response.assert_model_valid(expected_model=validation_model)

        else:
            self.response.assert_model_valid()
