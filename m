Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeERHls (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:41:48 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48954 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeERHlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:41:47 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: valdis.kletnieks@vt.edu
Cc: ahs3@redhat.com, Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next 20180515 - ACPI disabled..
Date: Fri, 18 May 2018 09:41:12 +0200
Message-ID: <1810137.ABeZ7v6Jz6@aspire.rjw.lan>
In-Reply-To: <54836.1526594481@turing-police.cc.vt.edu>
References: <50539.1526419088@turing-police.cc.vt.edu> <2369798.f7cP5IOQk6@aspire.rjw.lan> <54836.1526594481@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May 18, 2018 12:01:21 AM CEST valdis.kletnieks@vt.edu wrote:
> On Wed, 16 May 2018 13:58:04 +0200, "Rafael J. Wysocki" said:
> > On Wednesday, May 16, 2018 12:25:30 AM CEST valdis.kletnieks@vt.edu wrote:
> > > On Tue, 15 May 2018 15:49:15 -0600, Al Stone said:
> > > 
> > > > Not off-hand.  Could you please send me a copy of /sys/firmware/acpi/tables/APIC
> 
> > There was one commit that I had to drop.
> >
> > Please try linux-next tomorrow and let me know if it works for you.
> 
> Confirming that linux-next 20180517 works as expected, thanks.
> 

Good, thanks!
