Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbeE3LKD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:10:03 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39869 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbeE3LJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:09:58 -0400
X-Google-Smtp-Source: ADUXVKL30mLNCVTto4WM7YSs4cExlu/PB6B+jQt0a3Dz0D2S3NyFguPVRGH5iOksKgBX/qBGj6xD1cMpBOmy0XHN9Xg=
MIME-Version: 1.0
In-Reply-To: <20180529172611.GL3803@linux.vnet.ibm.com>
References: <20180525101958.13277-1-bigeasy@linutronix.de> <20180525101958.13277-2-bigeasy@linutronix.de>
 <CAJZ5v0jEUR7YxzujvZn8WVK+dMxmOxoHNiLKcmgCq9awHR=vYg@mail.gmail.com>
 <20180529120443.GE3803@linux.vnet.ibm.com> <CAJZ5v0j_O=nL6Eym5GqGGDC8LPB5vu-YAp9DFfZSJsHd-TMEmg@mail.gmail.com>
 <20180529172611.GL3803@linux.vnet.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 May 2018 13:09:57 +0200
X-Google-Sender-Auth: 5CPAlLTxgbqEtMLfSN3Ed2GlW14
Message-ID: <CAJZ5v0gYcFywNZh+-EHSmwU89AER=a8ouKtK93j=Lu4DSHUzNw@mail.gmail.com>
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

On Tue, May 29, 2018 at 7:26 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Tue, May 29, 2018 at 07:14:49PM +0200, Rafael J. Wysocki wrote:
>> On Tue, May 29, 2018 at 2:04 PM, Paul E. McKenney
>> <paulmck@linux.vnet.ibm.com> wrote:
>> > On Tue, May 29, 2018 at 10:09:51AM +0200, Rafael J. Wysocki wrote:
>> >> On Fri, May 25, 2018 at 12:19 PM, Sebastian Andrzej Siewior
>> >> <bigeasy@linutronix.de> wrote:
>> >> > There are macros for static initializer for the three out of four
>> >> > possible notifier types, that are:
>> >> >         ATOMIC_NOTIFIER_HEAD()
>> >> >         BLOCKING_NOTIFIER_HEAD()
>> >> >         RAW_NOTIFIER_HEAD()
>> >> >
>> >> > This patch provides a static initilizer for the forth type to make it
>> >> > complete.
>> >> >
>> >> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> >> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> >>
>> >> I cannot apply this without an ACK from Paul.
>> >
>> > I have both queued, but if you would prefer to take them, then for the
>> > SRCU piece:
>> >
>> > Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> > Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>>
>> Thanks!
>>
>> I'll route them along with the other cpufreq material then.
>
> Please let me know when you have them queued so that I can remove
> them from -rcu.

I've just added them to my linux-next branch.

Cheers,
Rafael
