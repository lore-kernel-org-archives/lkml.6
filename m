Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032095AbeBPQcs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:32:48 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45563 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031831AbeBPQcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:32:46 -0500
X-Google-Smtp-Source: AH8x227P17kc9PxbdEhCxouzsT6NDjuQ8gGx0ZYSrJDixc0e4R0CSk+6jXkAZ6LSOaFJBda05kr219gS8Tr8SQsd8YQ=
MIME-Version: 1.0
In-Reply-To: <CAP8WD_YMVJBx7qpqsLW8PSwkc5HS1GXTMJgWPHbSdnTt4fYCOw@mail.gmail.com>
References: <1518713696-11360-1-git-send-email-tedheadster@gmail.com>
 <CAHp75Vec015tw-n-cc-anZ9unFEGhF=Lj55SNwDUDK8dvOdYOg@mail.gmail.com> <CAP8WD_YMVJBx7qpqsLW8PSwkc5HS1GXTMJgWPHbSdnTt4fYCOw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 18:32:44 +0200
Message-ID: <CAHp75VefOvDZGXNPediXvHDL79u2hH=hPAaD1b9sr7fux0vR3Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/Kconfig : Add missing i586-class cpus to
 X86_CMPXCHG64 Kconfig group
To: whiteheadm@acm.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 5:08 PM, tedheadster <tedheadster@gmail.com> wrote:
> On Fri, Feb 16, 2018 at 9:17 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Thu, Feb 15, 2018 at 6:54 PM, Matthew Whitehead
>> <tedheadster@gmail.com> wrote:
>>> Several i586-class cpus supporting this instruction are missing from
>>> the X86_CMPXCHG64 config group.
>>
>> What about Intel Quark? MinuteIA core which is currently set as M586TSC.

> I am unsure what you are asking here. I do not see any option for
> Intel Quark processor types in arch/x86/Kconfig.cpu. Are you saying
> there should be one?

> Or perhaps you are saying that Intel Quark is currently set for
> M586TSC and it lacks the CMPXCHG64 instruction?

This is a good question.
The CPUID tells us family 5, model 9.

> If so, I would change
> my config option from M586TSC to M586.


-- 
With Best Regards,
Andy Shevchenko
