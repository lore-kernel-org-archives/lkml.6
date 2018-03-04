Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932261AbeCDUj3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 15:39:29 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:36608 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932090AbeCDUj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 15:39:28 -0500
Date: Sun, 4 Mar 2018 22:39:26 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] init/ramdisk: use pr_cont() at the end of ramdisk loading
Message-ID: <20180304203926.fdimiyyunogejlas@darkstar.musicnaut.iki.fi>
References: <20180302205552.16031-1-aaro.koskinen@iki.fi>
 <CAHp75VcY4+nO26jEq4NgXAPVq2rB2uDnM0Syh=R-=sh9gPOtZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcY4+nO26jEq4NgXAPVq2rB2uDnM0Syh=R-=sh9gPOtZQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 03, 2018 at 06:14:33PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 2, 2018 at 10:55 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > Use pr_cont() at the end of ramdisk loading. This will avoid the rotator
> > and an extra newline appearing in the dmesg.
> 
> >                                 printk("Error closing the disk.\n");
> 
> What about this one?

I think it should be left as is.

A.
