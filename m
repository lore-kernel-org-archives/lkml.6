Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeCCQOg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 11:14:36 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:43253 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeCCQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 11:14:35 -0500
X-Google-Smtp-Source: AG47ELsYDQOJ68x+omdeqB5tUqfAZ3sxgZsVwgekU1cDbN/PDckD5W9WfZJ6I7VOO+C2WonJ9y3Xfe8xO/K2xN6QCq8=
MIME-Version: 1.0
In-Reply-To: <20180302205552.16031-1-aaro.koskinen@iki.fi>
References: <20180302205552.16031-1-aaro.koskinen@iki.fi>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 3 Mar 2018 18:14:33 +0200
Message-ID: <CAHp75VcY4+nO26jEq4NgXAPVq2rB2uDnM0Syh=R-=sh9gPOtZQ@mail.gmail.com>
Subject: Re: [PATCH] init/ramdisk: use pr_cont() at the end of ramdisk loading
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 10:55 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Use pr_cont() at the end of ramdisk loading. This will avoid the rotator
> and an extra newline appearing in the dmesg.

>                                 printk("Error closing the disk.\n");

What about this one?

-- 
With Best Regards,
Andy Shevchenko
