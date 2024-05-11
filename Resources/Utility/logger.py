import sys
from argparse import Namespace

from loguru import logger
from requests import PreparedRequest, Response


class InvalidLogLevel(Exception):
    def __init__(self, log_level: str, available_log_levels: str):
        self.log_level, self.available_log_levels = log_level, available_log_levels

    def __str__(self):
        return (
            f'Invalid logging level: "{self.log_level}". '
            f'Please use following levels of logging: {self.available_log_levels}'
        )


@logger.catch
def get_curl(request: PreparedRequest, is_compressed: bool = False, is_insecure: bool = False) -> str:
    """ Get curl of request.

    Args:
        request: request
        is_compressed: curl for compressed req
        is_insecure: for insecure req
    """
    body = request.body

    args = [
        f'curl -X {request.method} ',
        ' '.join([f'-H "{k}: {v}"' for k, v in request.headers.items()]),
        f" -d '{body.decode('latin-1') if isinstance(body, bytes) else body}'" if body else '',
        ' --compressed' if is_compressed else '',
        ' --insecure' if is_insecure else '',
        f' {request.url}'
    ]

    return ''.join(args)


def create_logger(log_level: str, params: Namespace) -> None:
    """ create logger and set logging level.

    Args:
        log_level: log level
        params: params of a project
    """

    try:
        logger.remove()

        if getattr(params, 'xmlpath', None):
            logger.add(
                sink=sys.stdout,
                level=log_level,
                format='\n{time:HH:mm:ss.SSS} | <level>{level}</level> | <level>{message}</level>'
            )

        else:
            logger.add(
                sink=sys.stdout,
                format='\n<fg #ff7e00>{time:HH:mm:ss.SSS}</fg #ff7e00> | '
                       '<level>{level}</level> | '
                       '<cyan>{name}</cyan>:<cyan>{function}</cyan>:<cyan>{line}</cyan> | '
                       '<level>{message}</level>',
                level=log_level,
                colorize=True
            )

    except ValueError:
        logger.error(f'Logging level set error {log_level=}')
        raise InvalidLogLevel(log_level=log_level, available_log_levels=logger._core.levels.keys()) from None  # noqa


def log_request(
        request: PreparedRequest,
        is_compressed: bool = False,
        is_insecure: bool = False
) -> None:
    """ log request
    Args:
        request: req
        is_compressed: curl for compressed req
        is_insecure: for insecure req
    """
    curl = None
    color = "blue"
    msg = (
        f'HTTP-Method: <{color}><n>{request.method}</n></{color}>\n'
        f'\t URL:     <{color}><n>{request.url}</n></{color}>\n'
        f'\t Headers: <{color}><n>{request.headers}</n></{color}>\n'
    )

    if 'boundary' not in request.headers and request.method != 'GET':
        msg += f'\t Body:    <{color}><n>{request.body}</n></{color}>\n'
    if 'boundary' not in request.headers:
        curl = get_curl(request=request, is_compressed=is_compressed, is_insecure=is_insecure)
        msg += f'\t CURL:    <{color}><n>{curl}</n></{color}>'
    try:
        logger.opt(colors=True).info(msg)

    except ValueError:
        logger.debug(f'Error of logging req:\n\tCURL: {curl if curl else "None"}')
        logger.opt(colors=False).info(msg.replace('<{color}><n>', '').replace('</n></{color}>', ''))


def log_response(response: Response) -> None:
    """ Log response.
    Args:
        response: resp
    """
    color = {1: 'light-blue', 2: 'green', 3: 'yellow', 4: 'red', 5: 'red'}.get(response.status_code // 100, 'y')

    try:
        logger.opt(colors=True).info(
            f'Code: <{color}><n>{response.status_code}</n></{color}>\n'
            f'\t Headers: <{color}><n>{response.headers}</n></{color}>\n'
            f'\t Body:    <{color}><n>{response.text}</n></{color}>'
        )

    except ValueError:
        logger.opt(colors=True).info(
            f'Code: <{color}><n>{response.status_code}</n></{color}>\n'
            f'\t Headers: <{color}><n>{response.headers}</n></{color}>\n'
        )
        logger.info(f'Body: {response.text}')
