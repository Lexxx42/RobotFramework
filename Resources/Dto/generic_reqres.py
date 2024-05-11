from pydantic import BaseModel, ConfigDict


class ReqResDto(BaseModel):
    model_config = ConfigDict(extra='forbid')
