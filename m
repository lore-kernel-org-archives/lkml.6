Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbeFABmO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:42:14 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:57120 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeFABmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:42:13 -0400
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.220.135
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [RFC] rcu: Check the range of jiffies_till_xxx_fqs on setting
 them
To: paulmck@linux.vnet.ibm.com
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, joel@joelfernandes.org
References: <1527578616-5595-1-git-send-email-byungchul.park@lge.com>
 <20180529120155.GC3803@linux.vnet.ibm.com>
 <07271222-2e1d-2dc8-1648-4c53d710a092@lge.com>
 <3d2d8dec-445a-da31-dbe0-34b2331523ed@lge.com>
 <20180531111742.GQ7063@linux.vnet.ibm.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <7054f182-2648-983d-3602-e69ea36f90f6@lge.com>
Date: Fri, 1 Jun 2018 10:42:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531111742.GQ7063@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-05-31 20:17, Paul E. McKenney wrote:
> On Thu, May 31, 2018 at 11:51:40AM +0900, Byungchul Park wrote:
>> On 2018-05-31 11:18, Byungchul Park wrote:
>>> On 2018-05-29 21:01, Paul E. McKenney wrote:
>>>
>>>> One approach would be to embed the kernel_params_ops structure inside
>>>> another structure containing the limits, then just have two structures.
>>>> Perhaps something like this already exists?  I don't see it right off,
>>>> but then again, I am not exactly an expert on module_param.
>>>>
>>>> Thoughts?
>>>
>>> Unfortunately, I couldn't find it. There might be no way to verify
>>> range of a variable except the way I did. Could you give your opinion
>>> about whether I should go on it?
>>
>> Like..
> 
> This looks reasonable to me.  Although you could make something that took
> ranges, that would be more code than what you have below, so what you

Exactly.

> have below is good.  Could you please resend as a patch with Signed-off-by
> and commit log?

Sure, I will. Thanks a lot Paul.

-- 
Thanks,
Byungchul
