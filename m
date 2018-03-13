Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeCMQmT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:42:19 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:37703 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbeCMQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:42:18 -0400
X-Google-Smtp-Source: AG47ELsTc2+ALlZrFF4teFRJs9yVHFQ+MIjewDf5xnN/t0vfI3BKW8Gv1wPzlSJbBtHo5qbrW2Frg5lwxjusOkRKOss=
MIME-Version: 1.0
In-Reply-To: <20180311172309.GA1964@seema-Inspiron-15-3567>
References: <20180311172309.GA1964@seema-Inspiron-15-3567>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 18:42:16 +0200
Message-ID: <CAHp75VfdJwVy3EpvGJHS7_Xz_YCoLXcV4o=88megrqcMG2KyBA@mail.gmail.com>
Subject: Re: [PATCH] mtd: Replace printk() with more standardize output format.
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ezequiel@vanguardiasur.com.ar
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 7:23 PM, Arushi Singhal
<arushisinghal19971997@gmail.com> wrote:

> +               pr_notice("ftl_cs: format error: too many "
> +                         "transfer units!\n");

Please, join messages back to be one line for one line.

Examples:

pr("part1 "
 "part2\'n");

-> pr("part1 part2\'n");

While
pr("part1\n"
 "part2\'n");

stays the same.

-- 
With Best Regards,
Andy Shevchenko
