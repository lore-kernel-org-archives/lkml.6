Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbeAaL7e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 06:59:34 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34828 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753426AbeAaL7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 06:59:33 -0500
X-Google-Smtp-Source: AH8x226iznurIUwWklPNovx8s5X5fy2A+PoS/eiSF7VcZiSZi8Tjyy5KUG3LHJTyMX61nI31F08Iiw==
Date: Wed, 31 Jan 2018 12:59:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel list <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 4.15: WARNING: CPU: 3 PID: 258 at kernel/irq/chip.c:244
 __irq_startup+0x80/0x100
Message-ID: <20180131115929.7axv64rggltlpg2h@gmail.com>
References: <alpine.LRH.2.21.1801291809460.13788@math.ut.ee>
 <alpine.DEB.2.20.1801291732092.1849@nanos>
 <alpine.DEB.2.20.1801301935410.1797@nanos>
 <alpine.LRH.2.21.1801302127080.11640@math.ut.ee>
 <alpine.DEB.2.20.1801310856390.2293@nanos>
 <20180131080955.ikdrrus6cotfnozs@gmail.com>
 <alpine.LRH.2.21.1801311308060.31027@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1801311308060.31027@math.ut.ee>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Meelis Roos <mroos@linux.ee> wrote:

> > > I'll do a proper fix and queue it so your museum is kept alive.
> 
> Thank you.
> 
> > Museum, space heater and ventilation system all in one? :-)
> 
> Actually, I do have a computer museum that is open for groups in Tartu, 
> Estonia, at University of Tartu, Institute of Computer Science. But this 
> museum displays older stuff than P3.
> 
> In the queue for the museum, I have lots of servers and desktops and 
> laptops that look too similar for presentation but are interesting for 
> testing kernels. This set includes 100+ machines that are ocassionally 
> powered on and most test 1-2 RC-s and the release kernels - can not 
> afford to run them 24x7.
> 
> Currently, there are 30+ sparc64 machines, 30 x86 towers (mostly 
> desktop, mostly 32-bit), 7 laptops, 25 x86 rack servers, 6 ia64, 2 
> powerpc, 4 alpha and 5 parisc machines. At any moment, at least some of 
> them are out of order but the majority are alive.

That's very, very impressive! :-)

Thanks,

	Ingo
