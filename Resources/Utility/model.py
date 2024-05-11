from typing import TypeVar, Collection

from pydantic import BaseModel

from Resources.Utility.logger import logger

Model = TypeVar('Model', bound=BaseModel)


def convert_model(model: BaseModel, is_json: bool = False, **kwargs) -> Collection[str]:
    """ Convert pydantic model to obj for request: str, dict, data

    Args:
        model: model obj
        is_json: True - for json
                 False -  for dict/list
        **kwargs: kwargs for convertation
    """
    match model:
        case BaseModel():
            is_list = True if hasattr(model, 'root') else False
            result = model.model_dump_json(**kwargs) if is_json else model.model_dump(**kwargs)

        case _:
            raise AttributeError("Wrong model - not subclass of BaseModel")

    logger.debug(
        'Convert:\n'
        f'\tModel: {model}\n'
        f'\tConv to: {"json" if is_json else "list" if is_list else "dict"}\n'
        f'\tResult: {result}'
    )

    return result


def convert_models_to_request(
        json: dict | BaseModel | list | None,
        data: dict | list | str | bytes | BaseModel | None,
        params: dict | BaseModel | None,
        **kwargs
) -> tuple:
    """Convert request attributes json, data, params for pydantic model to python objs.

    Args:
        json: req body json;
        data: req body if present;
        params: req params if present.
        **kwargs: kwargs for convertation
    """
    is_model_obj = lambda obj: isinstance(obj, BaseModel)

    if is_model_obj(data):
        data = convert_model(model=data, is_json=True, **kwargs)

    if is_model_obj(json):
        json = convert_model(model=json, **kwargs)

    if is_model_obj(params):
        params = convert_model(model=params, **kwargs)

    return json, data, params
