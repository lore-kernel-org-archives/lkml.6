Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbeC1NFp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:05:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753187AbeC1NFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:05:43 -0400
Subject: Re: [PATCH v3 2/2] locking/debug: Add a master lock debugging switch
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <1522186690-10526-1-git-send-email-longman@redhat.com>
 <1522186690-10526-3-git-send-email-longman@redhat.com>
 <20180327231321.4on2kczby5ejqglt@linux-n805>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <45ebe079-e585-634d-2f40-f7ff781faa0c@redhat.com>
Date: Wed, 28 Mar 2018 09:05:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180327231321.4on2kczby5ejqglt@linux-n805>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 07:13 PM, Davidlohr Bueso wrote:
> On Tue, 27 Mar 2018, Waiman Long wrote:
>
>> Add a new master LOCK_DEBUGGING Kconfig option to turn on all the lock
>> debugging options except the selftests and the torture tests.
>
> For what purpose?
>
> I'm not sure we want yet another config debug option. These are all
> expert
> level configuration and honestly I would rather such users _think_ about
> what options they are enabling instead of giving them a large hammer.
>
> If enough load, this can also make boxes completely locked up for any
> sort of
> testing/debugging. I vote no.
>
> Also, CI efforts such 0-day already have the necessary scripting to
> cover the
> debug options that make sense.
>
> Thanks,
> Davidlohr

I think I misunderstood what the expectation is. I will send out an
updated patch to correct that.

Thanks,
Longman
