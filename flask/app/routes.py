import logging
logger = logging.getLogger('testlogger')
import sys

from flask import current_app as app

@app.route('/')
def hello_world():
	print('print')
	print('print stderr',file=sys.stderr)
	app.logger.critical('app.logger.critical')
	app.logger.error('app.logger.error')
	app.logger.warning('app.logger.warning')
	app.logger.info('app.logger.info')
	app.logger.debug('app.logger.debug')
	logger.critical('logger.critical')
	logger.error('logger.error')
	logger.warning('logger.warning')
	logger.info('logger.info')
	logger.debug('logger.debug')
	return app.config["MYAPPMESSAGE"]
