Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeEQWBc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 18:01:32 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44296 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751671AbeEQWBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 18:01:30 -0400
X-Google-Smtp-Source: AB8JxZpXiLkC6XnYGol4lt88HayjCzeKAinenB1jNRwP4acNH4+JKCpgZl2MSNk5kcxqsUam8+qcSw==
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc: ahs3@redhat.com, Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next 20180515 - ACPI disabled..
In-reply-to: <2369798.f7cP5IOQk6@aspire.rjw.lan>
References: <50539.1526419088@turing-police.cc.vt.edu> <664f2475-9718-d38e-7270-3426c94f86e8@redhat.com> <58438.1526423130@turing-police.cc.vt.edu>
 <2369798.f7cP5IOQk6@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 May 2018 18:01:21 -0400
Message-ID: <54836.1526594481@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 13:58:04 +0200, "Rafael J. Wysocki" said:
> On Wednesday, May 16, 2018 12:25:30 AM CEST valdis.kletnieks@vt.edu wrote:
> > On Tue, 15 May 2018 15:49:15 -0600, Al Stone said:
> > 
> > > Not off-hand.  Could you please send me a copy of /sys/firmware/acpi/tables/APIC

> There was one commit that I had to drop.
>
> Please try linux-next tomorrow and let me know if it works for you.

Confirming that linux-next 20180517 works as expected, thanks.
