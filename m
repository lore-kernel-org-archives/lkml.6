Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeBROUd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 09:20:33 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40236 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbeBROUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 09:20:32 -0500
X-Google-Smtp-Source: AH8x226ELmk88sxyP+srCEawXUZY8733Qja0YTo17q6x9k+R0l9pHSVaFLhNv8USallg5bNvAUbQudA6iUj1bKCTizA=
MIME-Version: 1.0
In-Reply-To: <20180218125802.lu5abzydm2hwxj5p@ltop.local>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com> <20180218125802.lu5abzydm2hwxj5p@ltop.local>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 18 Feb 2018 16:20:31 +0200
Message-ID: <CAHp75Vdyqsaf31uxrhJXvJEK=npj_jJfyaEUA-NK0CqU_bhtGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] lib/test_printf: Mark big constant with ULL
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 2:58 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Feb 16, 2018 at 11:07:03PM +0200, Andy Shevchenko wrote:
>> Sparse complains that constant is so bit for unsigned long on 64-bit
>> architecture.
>>
>> lib/test_printf.c:217:54: warning: constant 0xffff0123456789ab is so big it is unsigned long
>> lib/test_printf.c:246:54: warning: constant 0xffff0123456789ab is so big it is unsigned long
>>
>> To satisfy everyone, mark the constant with ULL.
>
> It should be 'UL' not 'ULL' since for architectures a pointer and
> a unsigned long have the ame size while on 32bit archs, long long
> are (or may?) 64bit.

Perhaps, I'll try next week. Though ULL works fine as well.

-- 
With Best Regards,
Andy Shevchenko
