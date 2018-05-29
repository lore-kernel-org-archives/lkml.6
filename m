Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965202AbeE2ROx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:14:53 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46737 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936622AbeE2ROv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:14:51 -0400
X-Google-Smtp-Source: ADUXVKIG2Pe1DCtkd7Q8GmbAG8cAsL80SMyOfilNFQEwysf140QMfNWprWOnbTcrjeBKxJ7kCRMeqtBo0e/wRUgkglg=
MIME-Version: 1.0
In-Reply-To: <20180529120443.GE3803@linux.vnet.ibm.com>
References: <20180525101958.13277-1-bigeasy@linutronix.de> <20180525101958.13277-2-bigeasy@linutronix.de>
 <CAJZ5v0jEUR7YxzujvZn8WVK+dMxmOxoHNiLKcmgCq9awHR=vYg@mail.gmail.com> <20180529120443.GE3803@linux.vnet.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 May 2018 19:14:49 +0200
X-Google-Sender-Auth: AAnAtj6ET3lwPpjRdaNYFGfVG5k
Message-ID: <CAJZ5v0j_O=nL6Eym5GqGGDC8LPB5vu-YAp9DFfZSJsHd-TMEmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel/SRCU: provide a static initializer
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 2:04 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Tue, May 29, 2018 at 10:09:51AM +0200, Rafael J. Wysocki wrote:
>> On Fri, May 25, 2018 at 12:19 PM, Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de> wrote:
>> > There are macros for static initializer for the three out of four
>> > possible notifier types, that are:
>> >         ATOMIC_NOTIFIER_HEAD()
>> >         BLOCKING_NOTIFIER_HEAD()
>> >         RAW_NOTIFIER_HEAD()
>> >
>> > This patch provides a static initilizer for the forth type to make it
>> > complete.
>> >
>> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> I cannot apply this without an ACK from Paul.
>
> I have both queued, but if you would prefer to take them, then for the
> SRCU piece:
>
> Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Thanks!

I'll route them along with the other cpufreq material then.

Cheers,
Rafael
