Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeDLI4A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 04:56:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751589AbeDLIz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 04:55:59 -0400
Subject: Re: [PATCH] sched/rt.c: pick and check task if double_lock_balance()
 unlock the rq
To: Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC: Zhou Chengming <zhouchengming1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <guohanjun@huawei.com>
References: <1505112709-102019-1-git-send-email-zhouchengming1@huawei.com>
 <20180410180546.4159134c@gandalf.local.home>
 <20180411102622.GK4082@hirez.programming.kicks-ass.net>
From: "Libin (Huawei)" <huawei.libin@huawei.com>
Message-ID: <c8240950-2deb-954a-bb0f-c4d4551734b0@huawei.com>
Date: Thu, 12 Apr 2018 16:54:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180411102622.GK4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.31.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2018/4/11 18:26, Peter Zijlstra Ð´µÀ:
> On Tue, Apr 10, 2018 at 06:05:46PM -0400, Steven Rostedt wrote:
>>
>> Peter,
>>
>> Going through my inbox, I stumbled across this one. And it doesn't
>> appear to be addressed.
>>
>> I think this patch is a reasonable solution.
> 
> Urgh, yeah, also seem to have forgotten about it. The proposed solution
> is in fact simpler than the existing code. Also, I think deadline.c has
> the exact same problem.
> 
> Zhou, could you respin and fix both?

Thanks for your reply, and I will fix the deadline.c and resend the two 
patches together.

Thanks,
Li Bin

> 
> 
