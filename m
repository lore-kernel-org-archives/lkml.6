Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161598AbeBNSAN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:00:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44428 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161494AbeBNSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:00:11 -0500
Subject: Re: KASAN: use-after-free Read in rds_find_bound
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+93a5839deb355537440f@syzkaller.appspotmail.com>,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        rds-devel@oss.oracle.com
References: <089e08231920353a4805618b365c@google.com>
 <d91da249-5a0f-7a1f-cfd5-68f10f0a2fc1@oracle.com>
 <CACT4Y+bd6Tyq672JC3GNSHPX2CEHacVKkcbKOAgpi8o-=T8DRg@mail.gmail.com>
 <491a26b8-7abb-0d36-0a2e-e1c7bfcde79d@oracle.com>
 <CACT4Y+YxrNiP==ty-KBjkDewnuS378GmG314-=ytWskZXQx3zw@mail.gmail.com>
 <52478830-f0b5-e400-8101-b329ba35bcef@oracle.com>
 <CACT4Y+aWVFEvVMihw2MBiMgYKMzup4O78c_HrByhRyF8-zfzpw@mail.gmail.com>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <1088199a-9e37-e879-5b9d-31ab99f552d4@oracle.com>
Date: Wed, 14 Feb 2018 09:58:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aWVFEvVMihw2MBiMgYKMzup4O78c_HrByhRyF8-zfzpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8805 signatures=668671
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=741
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140212
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/2018 9:52 AM, Dmitry Vyukov wrote:
> On Wed, Feb 14, 2018 at 6:35 PM, Santosh Shilimkar
> <santosh.shilimkar@oracle.com> wrote:
>>>>> Hi Santosh,
>>>>>
>>>>> What is that fix? You forgot to provide any link/reference. I also
>>>>> don't see any patches from you at around that date...
>>>>>
>>>> Fix [1] was later not added since there was a still a race. Wanted to
>>>> see if the issue re-appears after recent netns fix [2].
>>>
>>>
>>>
>>> We will not see if the bug re-appears or not until this bug is closed.
>>> Please see this recent discussion about another rds bug:
>>> https://groups.google.com/d/msg/syzkaller-bugs/3XjmOzr5jRU/g7pXIsY1BgAJ
>>> In the current state syzbot will never report bugs in these functions
>>> again.
>>>
>> OK. Can you close that one then in that case ?
> 
> Anybody can do this:
>
I see.

> #syz fix: rds: tcp: use rds_destroy_pending() to synchronize
> netns/module teardown and rds connection/workq management
> 
> syzbot provides full self-service, see first email and in particular this:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#communication-with-syzbot
> 
ok will have a look.

Regards,
Santosh
