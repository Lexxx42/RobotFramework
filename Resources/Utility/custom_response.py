from typing import Any, Generic, Self, Sequence

from pydantic import BaseModel
from requests import Response

from Resources.Utility.logger import logger
from Resources.Utility.model import Model


ERROR_STATUS_CUSTOM_MSG = 'Response status code {code} not match with expected: {exp}'


class CustomResponse(Generic[Model]):
    __slots__ = ['response', 'response_model', 'response_error_model', '_response_body', '_dto', '_neg_dto']

    def __init__(
            self,
            response: Response,
            response_model: type[Model] | None = None,
            response_error_model: type[Model] | None = None
    ):
        self.response = response
        self._response_body: dict[str, Any] | None = None
        self.response_model = response_model
        self.response_error_model = response_error_model
        self._dto: Model | None = None
        self._neg_dto: Model | None = None

    @property
    def status_code(self) -> int:
        logger.debug('Call status_code from Response')

        return self.response.status_code

    @property
    def headers(self) -> dict[str, Any]:
        """Вернуть заголовки ответов"""
        logger.debug('Call headers from Response')

        return self.response.headers

    @property
    def text(self) -> str:
        """Вернуть тело в юникод строке"""
        logger.debug('Call text from Response')

        return self.response.text

    def json(self, **kwargs) -> dict[str, Any] | list[dict[str, Any]]:
        """ Get dict/list.

        Args:
            **kwargs: kwargs for json parse.
        """
        logger.debug('Get python obj')

        if self._response_body is None:
            self._response_body = self.response.json(**kwargs)
            logger.debug('Res: {}', self._response_body)

        else:
            logger.debug('Get body from instance')

        return self._response_body

    def dto(self, is_error_model: bool = False) -> Model:
        """ Get body as data transfer object.

        Args:
            is_error_model: for pos or neg dto model.
        """
        model_ = self.response_error_model if is_error_model else self.response_model

        dto = self._neg_dto if is_error_model else self._dto

        if not model_:
            raise AttributeError(f'{"Negative " if is_error_model else ""}No model!')

        if dto is None:
            if issubclass(model_, BaseModel):
                result = model_.model_validate(self.json())

            else:
                raise AttributeError(f"Not valid model {model_} - not subclass of BaseModel. type - {type(model_)}")

            logger.success('Successful conversation to dto. Res: {}', result)
            setattr(self, f"{'_neg_dto' if is_error_model else '_dto'}", result)

        logger.info('dto already written in instance. Get dto from instance.')

        return self._neg_dto if is_error_model else self._dto

    def __base_check_expected_status_code(
            self,
            expected_code: int | Sequence[int],
            exception: type[Exception] | None = None,
    ):
        """ Check status code.

        Args:
            expected_code: expected code or sequence of codes.
            exception: raise of exception instead of assert.
        """

        msg = ERROR_STATUS_CUSTOM_MSG.format(code=self.status_code, exp=expected_code)

        if exception:
            logger.debug('Checking with raise')
            expected_codes = (expected_code,) if isinstance(expected_code, int) else expected_code

            if self.status_code not in expected_codes:
                raise exception(msg)

        else:
            logger.debug('Checking with assert')

            assert self.status_code == expected_code, msg

        logger.success('Check of status code successful!')

    def assert_status_code(self, expected_code: int = 200) -> Self:
        """ Check status code with assert.

        Args:
            expected_code: expected status code.
        """
        self.__base_check_expected_status_code(expected_code=expected_code)

        return self

    def check_status_code(
            self,
            expected_code: int | Sequence[int] = 200,
            exception: type[Exception] = ValueError
    ) -> Self:
        """ Check status code with exception.

        Args:
            expected_code: expected status code of sequence of codes.
            exception: exception.
        """
        self.__base_check_expected_status_code(expected_code=expected_code, exception=exception)

        return self

    def assert_model_valid(self, expected_model: type[Model] | None = None, is_error_model: bool = False):
        """ Validate response against pidantic model.

        Args:
            expected_model: expected model
            is_error_model: type of check
        """
        logger.debug('begin of validation check of response body')

        inst_model = self.response_error_model if is_error_model else self.response_model

        model_ = expected_model if expected_model else inst_model

        if model_ is None:
            raise AttributeError(f'No {"negative " if is_error_model else ""}model for validation!')

        model_.model_validate(self.json())

        logger.success('Successful check of response body by validation model!')
