Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbeFADHx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 23:07:53 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:38819 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeFADHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 23:07:51 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.220.135
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [RESEND PATCH v3 1/2] sched/deadline: Add cpudl_maximum_dl() for
 clean-up
From: Byungchul Park <byungchul.park@lge.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        raistlin@linux.it, linux-kernel@vger.kernel.org, juri.lelli@gmail.com,
        bristot@redhat.com, kernel-team@lge.com
References: <1515392081-32320-1-git-send-email-byungchul.park@lge.com>
 <20180111090716.GV6176@hirez.programming.kicks-ass.net>
 <20180509063322.GA29160@X58A-UD3R>
 <536cd801-03e5-a1de-605b-a6ed0f95b4a9@lge.com>
Message-ID: <6617f569-6c2f-509c-328e-fad3db73f5df@lge.com>
Date: Fri, 1 Jun 2018 12:07:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <536cd801-03e5-a1de-605b-a6ed0f95b4a9@lge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-05-25 14:13, Byungchul Park wrote:
> 
> 
> On 2018-05-09 15:33, Byungchul Park wrote:
>> On Thu, Jan 11, 2018 at 10:07:16AM +0100, Peter Zijlstra wrote:
>>>
>>>
>>> Sorry for the huge delay on this, but I'll have to postpone further.
>>> Still busy with meltdown/spectre stuff.
>>
>> Please consider this. Even though it's not a big bug, anyway leading
>> mis-behavior in certain situaions.
> 
> Could you see this patches, it's been too long since the start tho?

Please, any opinion.

-- 
Thanks,
Byungchul
