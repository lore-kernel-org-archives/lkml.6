Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753286AbeBFSnQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:43:16 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:41381 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753128AbeBFSnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:43:09 -0500
X-Google-Smtp-Source: AH8x227LQNnfZhINjhRH7FaNrrbXKffI+JdlwguAa/0Ebi7v8vk95Blsa6Dznsi19yMrLuEtFfkbo70r37Zjbz1Lyk8=
MIME-Version: 1.0
In-Reply-To: <20180205222254.GS29988@eros>
References: <20180204174521.21383-1-kilobyte@angband.pl> <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
 <CAGXu5j+rWhT7_DH5Z96_7naPou96-6736x4mjq0r_8EG4iiQ_g@mail.gmail.com>
 <20180205201555.GQ29988@eros> <CAGXu5j+KSm3rOK46xiYPx8SRaO9T5LaeaXxOA3PSktJv4F__dg@mail.gmail.com>
 <20180205205817.72dy7e7xzjcnwmhs@angband.pl> <20180205222254.GS29988@eros>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Feb 2018 20:43:08 +0200
Message-ID: <CAHp75VfYg_k6Xc3XEW-sLGiU64SXs8jRnGh-Ee4-NUiEkXSGyw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: avoid misleading "(null)" for %px
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Adam Borowski <kilobyte@angband.pl>, Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 12:22 AM, Tobin C. Harding <me@tobin.cc> wrote:

> The original patch is good IMO and I AFAICT in everyone else's.

The original patch misses test cases.

Without them is problematic to follow what's going on with printing.

-- 
With Best Regards,
Andy Shevchenko
