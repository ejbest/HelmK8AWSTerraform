import logging

logging.basicConfig(filename='errrorlog.txt', level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
logging.debug('Start of program')

def factorial(n):
    logging.debug('Start of factorial')
    total = 1
    for i in range(n+1):
        total *= i
        logging.debug('i is %s, total is %s' % (i, total))
    
    logging.debug('Return value is %s' % (total))
    return(factorial(5))

print(factorial(5))

logging.debug('end of program')
