Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966363AbeBPPIn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:08:43 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:39849 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeBPPIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:08:41 -0500
X-Google-Smtp-Source: AH8x226oOd0Qqggh+GawFTkMDj8wEfpNQ/lTNr0e+BTSggtNnk/tzluLgJ7k5Ic0ZJxh403fIJKkvfEExrAH1EGkN4g=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
In-Reply-To: <CAHp75Vec015tw-n-cc-anZ9unFEGhF=Lj55SNwDUDK8dvOdYOg@mail.gmail.com>
References: <1518713696-11360-1-git-send-email-tedheadster@gmail.com> <CAHp75Vec015tw-n-cc-anZ9unFEGhF=Lj55SNwDUDK8dvOdYOg@mail.gmail.com>
From: tedheadster <tedheadster@gmail.com>
Date: Fri, 16 Feb 2018 10:08:20 -0500
Message-ID: <CAP8WD_YMVJBx7qpqsLW8PSwkc5HS1GXTMJgWPHbSdnTt4fYCOw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/Kconfig : Add missing i586-class cpus to
 X86_CMPXCHG64 Kconfig group
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy

On Fri, Feb 16, 2018 at 9:17 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Feb 15, 2018 at 6:54 PM, Matthew Whitehead
> <tedheadster@gmail.com> wrote:
>> Several i586-class cpus supporting this instruction are missing from
>> the X86_CMPXCHG64 config group.
>
> What about Intel Quark? MinuteIA core which is currently set as M586TSC.
>

I am unsure what you are asking here. I do not see any option for
Intel Quark processor types in arch/x86/Kconfig.cpu. Are you saying
there should be one?

Or perhaps you are saying that Intel Quark is currently set for
M586TSC and it lacks the CMPXCHG64 instruction? If so, I would change
my config option from M586TSC to M586.

>> Using a configuration with either M586TSC or M586MMX currently sets
>> X86_MINIMUM_CPU_FAMILY=4 instead of the correct value 5.
>
> Are you sure about this? See above.
>

Yes I am sure of this, I tested it very well. A similar problem
happens with an M686 configuration for a different reason.

- Matthew
