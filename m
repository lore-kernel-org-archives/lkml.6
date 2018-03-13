Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeCMFwI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 01:52:08 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:59980 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeCMFwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 01:52:07 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.184
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [RESEND PATCH v3 1/2] sched/deadline: Add cpudl_maximum_dl() for
 clean-up
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        raistlin@linux.it, linux-kernel@vger.kernel.org, juri.lelli@gmail.com,
        bristot@redhat.com, kernel-team@lge.com
References: <1515392081-32320-1-git-send-email-byungchul.park@lge.com>
 <20180111090716.GV6176@hirez.programming.kicks-ass.net>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <e29fd9da-d946-96cc-35fc-2aaef60f8451@lge.com>
Date: Tue, 13 Mar 2018 14:52:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180111090716.GV6176@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2018 6:07 PM, Peter Zijlstra wrote:
> 
> 
> Sorry for the huge delay on this, but I'll have to postpone further.
> Still busy with meltdown/spectre stuff.

Could you review the patch?

-- 
Thanks,
Byungchul
