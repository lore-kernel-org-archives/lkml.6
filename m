Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeBRXzM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:55:12 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33359 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeBRXzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:55:10 -0500
X-Google-Smtp-Source: AH8x226aGp8bjI3fIQJJMqqm+byJVLJEMxrOt0BhGmYNkWsuBn/0lC3vINazI6KjjANGwZNwNbfPFYEECtl7MM/GNoM=
MIME-Version: 1.0
In-Reply-To: <20180218215204.GB22942@eros>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com> <20180218215204.GB22942@eros>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Feb 2018 01:55:09 +0200
Message-ID: <CAHp75Vda2+1=ToaFL=gRDL1G+CMj4RQZY5nyS50rB=rv7Nx2KA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] lib/test_printf: Mark big constant with ULL
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 11:52 PM, Tobin C. Harding <me@tobin.cc> wrote:
> On Fri, Feb 16, 2018 at 11:07:03PM +0200, Andy Shevchenko wrote:

> What tree does this set apply to please?  I tried mainline rc1 and
> next-20180216.  Happy to see some code duplication removal from
> vsprintf.c :)

IIRC latest next, i.e. 20180217.


-- 
With Best Regards,
Andy Shevchenko
