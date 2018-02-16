Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034005AbeBPOR3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:17:29 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37242 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033893AbeBPOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:17:28 -0500
X-Google-Smtp-Source: AH8x226CxK0/rQnCGgZa9KYDpWqL5RdtADCh7YBC90wHI+DLgQ6Y/fQL0tNJS7OdM5aaecHI2huakd478M1ysn783Qk=
MIME-Version: 1.0
In-Reply-To: <1518713696-11360-1-git-send-email-tedheadster@gmail.com>
References: <1518713696-11360-1-git-send-email-tedheadster@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 16:17:27 +0200
Message-ID: <CAHp75Vec015tw-n-cc-anZ9unFEGhF=Lj55SNwDUDK8dvOdYOg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/Kconfig : Add missing i586-class cpus to
 X86_CMPXCHG64 Kconfig group
To: Matthew Whitehead <tedheadster@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 6:54 PM, Matthew Whitehead
<tedheadster@gmail.com> wrote:
> Several i586-class cpus supporting this instruction are missing from
> the X86_CMPXCHG64 config group.

What about Intel Quark? MinuteIA core which is currently set as M586TSC.

> Using a configuration with either M586TSC or M586MMX currently sets
> X86_MINIMUM_CPU_FAMILY=4 instead of the correct value 5.

Are you sure about this? See above.

-- 
With Best Regards,
Andy Shevchenko
