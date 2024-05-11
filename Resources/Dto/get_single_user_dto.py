from pydantic import StrictInt, StrictStr, EmailStr

from Resources.Dto.generic_reqres import ReqResDto


class Data(ReqResDto):
    id: StrictInt
    email: EmailStr
    first_name: StrictStr
    last_name: StrictStr
    avatar: StrictStr


class Support(ReqResDto):
    url: StrictStr
    text: StrictStr


class GetSingleUserDto(ReqResDto):
    """ Dto model for get single user data request. """
    data: Data
    support: Support
