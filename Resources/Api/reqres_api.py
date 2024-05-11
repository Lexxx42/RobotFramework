""" Hello world! """
from Resources.Dto.error_model_reqres import ErrorModelDto
from Resources.Dto.get_single_user_dto import GetSingleUserDto
from Resources.Utility.custom_request import Request
from Resources.Utility.custom_response import CustomResponse


class ReqresApi(Request):
    """ DOC: https://reqres.in/ """

    def __init__(self):
        super().__init__()
        self.headers.update({"Content-Type": "application/json"})
        self.url = 'https://reqres.in/api/users'

    def get_single_user(self, user_id: int) -> CustomResponse:
        """ Get single user data.

        Args:
            user_id: user ID.
        """
        return self.request(
            method="GET",
            url=f"{self.url}/{user_id}",
            response_model=GetSingleUserDto,
            response_error_model=ErrorModelDto
        )
