Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeBHP3q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:29:46 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33298 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeBHP3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:29:16 -0500
X-Google-Smtp-Source: AH8x2273NA8NTul84i7ClNaV+LDk3uUrFXnqO5KhzddoxVTA2sA2nqtzQpUsW7PsgMobKj+YHT1T6bnTyqlVxywaXZA=
MIME-Version: 1.0
In-Reply-To: <20180207154116.xvojw3bzmnmexkav@pathway.suse.cz>
References: <20180204174521.21383-1-kilobyte@angband.pl> <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
 <CAGXu5j+rWhT7_DH5Z96_7naPou96-6736x4mjq0r_8EG4iiQ_g@mail.gmail.com>
 <20180205201555.GQ29988@eros> <CAGXu5j+KSm3rOK46xiYPx8SRaO9T5LaeaXxOA3PSktJv4F__dg@mail.gmail.com>
 <20180205205817.72dy7e7xzjcnwmhs@angband.pl> <20180207150328.nuk7f76nutq2trcg@pathway.suse.cz>
 <CAMuHMdVJZnbFrLxBZm1m6C+sR1MKuk3=G4RoYVkAgcxYDHgMGw@mail.gmail.com> <20180207154116.xvojw3bzmnmexkav@pathway.suse.cz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 8 Feb 2018 17:29:14 +0200
Message-ID: <CAHp75VeSds86y9+YBebhfVAS-ZOA1yeMXUD2o2du0SkbQjPDAw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: avoid misleading "(null)" for %px
To: Petr Mladek <pmladek@suse.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Adam Borowski <kilobyte@angband.pl>, Kees Cook <keescook@chromium.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 5:41 PM, Petr Mladek <pmladek@suse.com> wrote:
> On Wed 2018-02-07 16:11:13, Geert Uytterhoeven wrote:

> To make it clear. I was talking about "%p" format that is handled
> in the pointer() function in lib/vsprintf.c. The "(null)" makes
> sense only for the many modifiers that do deference of
> the pointer, e.g. "%pa", "%pE", "%ph".

JFYI: I have a patch to eliminate those for %pE & %ph.

Google for "lib/vsprintf: Remove useless NULL checks" as a first in
the series for new extension to print times.

I just need time to address comments and resend the series.

-- 
With Best Regards,
Andy Shevchenko
