Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbeDLMYo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:24:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35237 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752700AbeDLMYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:24:43 -0400
Subject: Re: [PATCH 0/2] sched: pick and check task if double_lock_balance()
 unlock the rq
To: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>
References: <1523530735-20011-1-git-send-email-huawei.libin@huawei.com>
 <20180412121145.GA4082@hirez.programming.kicks-ass.net>
 <20180412082010.3f088370@gandalf.local.home>
From: "Libin (Huawei)" <huawei.libin@huawei.com>
Message-ID: <cf6c700d-080f-05f8-373b-62f543fa3cd7@huawei.com>
Date: Thu, 12 Apr 2018 20:24:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180412082010.3f088370@gandalf.local.home>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.31.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2018/4/12 20:20, Steven Rostedt Ð´µÀ:
> On Thu, 12 Apr 2018 14:11:45 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Thu, Apr 12, 2018 at 06:58:53PM +0800, Li Bin wrote:
>>> Li Bin (1):
>>>    sched/deadline.c: pick and check task if double_lock_balance() unlock
>>>      the rq
>>>
>>> Zhou Chengming (1):
>>>    sched/rt.c: pick and check task if double_lock_balance() unlock the
>>>      rq
>>>    
>>
>> Much thanks!
>>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> Ingo, please apply.
> 
> You can add my:
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> but I would still like to see the declaration of next_task before the
> comment, just for style concerns.

Ok, I will resend the patchset v2.

Thanks,
Li Bin

> 
> -- Steve
> 
> .
> 
