Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965710AbeEYKVB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:21:01 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36801 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965473AbeEYKU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:20:59 -0400
X-Google-Smtp-Source: ADUXVKJoE4tkNEA9D6eWj1d45aT5F9xzUMYLPvxtEziFkqUUavkrSumU4hqLEO4sCdOJIbM/9rsTtX7YV0b7r9b6Hf4=
MIME-Version: 1.0
In-Reply-To: <20180525101255.htxgtjd3efunlfcq@linutronix.de>
References: <20180525094648.15464-1-bigeasy@linutronix.de> <CAJZ5v0j9hjASBOyrkCQ1CxF812THJZOHahJwpcmyC3XC4Fr6xA@mail.gmail.com>
 <20180525101255.htxgtjd3efunlfcq@linutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 May 2018 12:20:58 +0200
X-Google-Sender-Auth: M4WNJC4-oeuBkstw6CLVM4R_RgM
Message-ID: <CAJZ5v0jfnwj-fVW+v99dNH=T2hU1JEYncVo7D+R=mq-noHF+pg@mail.gmail.com>
Subject: Re: PM / suspend / s2idle: avoiding splats on RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 12:12 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-05-25 12:05:31 [+0200], Rafael J. Wysocki wrote:
>> On Fri, May 25, 2018 at 11:46 AM, Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de> wrote:
>> > Patch #1 is a repost with the s2idle bits included. I tested via
>> >         echo s2idle > mem_sleep && echo mem > state
>> >
>> > and I woke up the machine via the power on button. Patches #2+ were
>> > additionally required with s2idle.
>>
>> I quite don't like the first one for reasons explained in the reply to it.
>>
>> The others are fine by me and I can queue them up if you want me to do that.
>
> Yes, please. I will talk to tglx regarding #1 and get back to you.

OK
