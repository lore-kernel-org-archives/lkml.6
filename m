Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeAaIKA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:10:00 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:46200 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeAaIJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:09:59 -0500
X-Google-Smtp-Source: AH8x227xb8Y+buYr5lI9He53/k4Y1FDhS29okeOUWt62CSisfWqGCXf7i9wtmhkTypLf4eAYwmVH/w==
Date: Wed, 31 Jan 2018 09:09:55 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Meelis Roos <mroos@linux.ee>,
        Linux Kernel list <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: 4.15: WARNING: CPU: 3 PID: 258 at kernel/irq/chip.c:244
 __irq_startup+0x80/0x100
Message-ID: <20180131080955.ikdrrus6cotfnozs@gmail.com>
References: <alpine.LRH.2.21.1801291809460.13788@math.ut.ee>
 <alpine.DEB.2.20.1801291732092.1849@nanos>
 <alpine.DEB.2.20.1801301935410.1797@nanos>
 <alpine.LRH.2.21.1801302127080.11640@math.ut.ee>
 <alpine.DEB.2.20.1801310856390.2293@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1801310856390.2293@nanos>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > cures the warning and at least the first bootup was working otherwise 
> > too.
> 
> I'll do a proper fix and queue it so your museum is kept alive.

Museum, space heater and ventilation system all in one? :-)

Thanks,

	Ingo
