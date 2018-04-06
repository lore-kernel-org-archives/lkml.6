Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeDFWT6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:19:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46452 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeDFWT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:19:57 -0400
Subject: Re: [PATCH v3 1/4] Ktest: add email support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com
References: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
 <1522094884-22718-2-git-send-email-tianyang.chen@oracle.com>
 <20180406142409.6d98254b@gandalf.local.home>
From: Tim Tianyang Chen <tianyang.chen@oracle.com>
Organization: Oracle Corporation
Message-ID: <e0646238-e991-61c6-c32f-eee07742073c@oracle.com>
Date: Fri, 6 Apr 2018 15:19:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180406142409.6d98254b@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8855 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804060222
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/06/2018 11:24 AM, Steven Rostedt wrote:
> On Mon, 26 Mar 2018 13:08:01 -0700
> Tim Tianyang Chen <tianyang.chen@oracle.com> wrote:
>
>> Users can define optional variables to get email notifications.
>> Ktest can send emails when the script:
>>   * was started
>>   * failed with fatal errors and called dodie()
>>   * completed all testing
>>
>> Users have to setup the mailer provided in config prior to using this script.
>> Supported mailers: mailx, mail, sendmail
>> mailer specific routines are _sendmail_send(), _mailx_send()
>>
>> Suggested-by: Dhaval Giani <dhaval.giani@oracle.com>
>> Signed-off-by: Tim Tianyang Chen <tianyang.chen@oracle.com>
>>
>> ---
>>      changes since v2:
>>      coding style fix for option maps and if statements
>> 	moved sig int handeling to another patch
>>      changes since v1:
>>      added options for when to send emails to option_map
>> ---
>>   ktest.pl | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 58 insertions(+), 3 deletions(-)
>>
>> diff --git a/ktest.pl b/ktest.pl
>> index 0c8b61f8398e..9469783bc6c1 100755
>> --- a/ktest.pl
>> +++ b/ktest.pl
> If you can, please use git to make your diffs.
>
> The full path name needs to be here.
>
>   tools/testing/ktest/ktest.pl
>
Sorry I was working on my private folder, version tracked with other 
stuff. Just re-sent them.

Tim
