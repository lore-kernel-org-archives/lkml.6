Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbeDYTl3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 15:41:29 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37154 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeDYTlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 15:41:25 -0400
X-Google-Smtp-Source: AIpwx4+DylxrQy4QkVaDDPVoem4epaXi76J+EYc4xKr0zabPAgnV2AQbtqhGM3E+6cC3Pww7FJoilQtDqSFWxc2u/kI=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804252108280.1589@nanos.tec.linutronix.de>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org>
 <CA+55aFypQ0aMSO7T0hxN2YCvckSLZh6BMTuz185TyJZ69jRUrg@mail.gmail.com> <alpine.DEB.2.21.1804252108280.1589@nanos.tec.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Apr 2018 12:41:23 -0700
X-Google-Sender-Auth: eScsMxPVpnR4t_krQTScpeAUE_8
Message-ID: <CA+55aFz2_cwCjBDAqvzeX89Md26JR=DLhQxTPGuq8OQkWi0ehw@mail.gmail.com>
Subject: Re: [tip:timers/urgent] Revert: Unify CLOCK_MONOTONIC and CLOCK_BOOTTIME
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Salyzyn <salyzyn@android.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>, Peter Anvin <hpa@zytor.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, Pavel Machek <pavel@ucw.cz>,
        Kevin Easton <kevin@guarana.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 12:09 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 25 Apr 2018, Linus Torvalds wrote:
>>
>> I don't see the reported watchdog things, and I run systemd and I ran
>> these patches.
>
> With suspend/resume?

Yes. I run them on my laptop, and while I don't do a _lot_ of
suspend/resume, I do some. My laptop right now is running a "just
after rc1" kernel, and has been for the last week, and has a couple of
suspends in that time. Type "closed my laptop, took it elsewhere,
opened it again", so more than a few minutes.

> Fair enough. Do the reporters have more information or do I have to chase
> it down myself?

I think reporters should just say what distro they are running, and
systemd versions etc, and how they debugged this. Maybe the pattern is
obvious.

For the record, I just run plain F27, obviously with my own kernel
(and a tweaked config, but it approaches just being a "make
localmodconfig" of the distro config).

               Linus
