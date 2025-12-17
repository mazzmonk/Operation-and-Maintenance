import base64
import urllib2
import json
import logging
import sys


def activemq_mointer(userinfo_encode):
    # 总的消息阻塞数
    pending_queue_sum = 0
    # 阻塞消息的队列名称
    pending_queue_lists = ''
    # 总的消息数
    mq_sum = 0
    headers = {
        'Authorization': 'Basic {}'.format(userinfo_encode),
        'ua': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.125 Safari/537.36'
    }
    url = 'http://' + ip + ':' + port + \
          '/api/jolokia/read/org.apache.activemq:type=Broker,brokerName=localhost/Queues/'
    request = urllib2.Request(url=url, headers=headers)
    try:
        response = urllib2.urlopen(request)
    except Exception as e:
        logging.error(e)
        return {'pending_queue_sum': 110, 'pending_queue_lists': '110', 'mq_sum': 0}  # 当服务不可用时，返回预警数字，用于预警。
    activemq_info = response.read()
    activemq_info_json = json.loads(activemq_info)
    activemq_queues = activemq_info_json['value']
    for i in activemq_queues:
        queue_url = 'http://' + ip + ':' + port + \
            '/api/jolokia/read/' + i['objectName']
        queue_request = urllib2.Request(url=queue_url, headers=headers)
        try:
            queue_response = urllib2.urlopen(queue_request)
        except Exception as e:
            logging.error(e)
            return {'pending_queue_sum': 110, 'pending_queue_lists': '110', 'mq_sum': 0}
        queue_info = queue_response.read()
        info_dict = json.loads(queue_info)
        mq_sum += info_dict['value']['EnqueueCount']
        if int(info_dict['value']['QueueSize']
               ) > 0:  # 取值 QueueSize ，就是未消费的消息数量
            pending_queue_sum += info_dict['value']['QueueSize']
            pending_queue_lists += info_dict['value']['Name']
            pending_queue_lists += ' and '
            logging.info(
                "消息队列--{}--有阻塞消息--{} 条".format(
                    info_dict['value']['Name'],
                    info_dict['value']['QueueSize']))
    return {'pending_queue_sum': pending_queue_sum, 'pending_queue_lists': pending_queue_lists, 'mq_sum': mq_sum}


if __name__ == '__main__':
    # ActiveMQ 服务器信息
    username = 'admin'
    password = 'admin'
    ip = '127.0.0.1'
    port = '8161'
    userinfo = username + ':' + password
    userinfo_encode = base64.b64encode(userinfo.encode('utf8'))
    # 日志配置,注意下面日志文件的路径是采用绝对路径的。
    logging.basicConfig(
        filename="/var/log/activemq_mointer.log",
        filemode="a",
        format="%(asctime)s %(name)s:%(levelname)s:%(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
        level=logging.DEBUG)
    if len(sys.argv) == 2:
        mointer_argv = sys.argv[1]
        if mointer_argv in ('pending', 'pending_lists', 'queue_sum'):
            mq_re = activemq_mointer(userinfo_encode)
            if mointer_argv == 'pending':
                print(mq_re['pending_queue_sum'])
            elif mointer_argv == 'pending_lists':
                print(mq_re['pending_queue_lists'])
            else:
                print(mq_re['mq_sum'])
        else:
            # 错误提示
            print("Please enter the correct parameters pending|pending_lists|queue_sum")
    else:
        # 错误提示
        print("Please enter the correct parameters pending|pending_lists|queue_sum")