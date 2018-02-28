Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeB1L0T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:26:19 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35413 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752301AbeB1L0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:26:17 -0500
X-Google-Smtp-Source: AG47ELvFPKPcoKsh8rcCtoHUPqFYuaW4EsktxRxHo+dN0kQ/dRXIIVO642J/06APQcpeTNoIniPwKA==
Date: Wed, 28 Feb 2018 12:26:09 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>,
        Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH] locking/xchg/alpha: Remove memory barriers from the
 _local() variants
Message-ID: <20180228112609.GA32523@andrea>
References: <1519704058-13430-1-git-send-email-parri.andrea@gmail.com>
 <20180227200830.GA3164@andrea>
 <20180228105810.GB7681@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228105810.GB7681@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:58:11AM +0000, Will Deacon wrote:
> On Tue, Feb 27, 2018 at 09:08:31PM +0100, Andrea Parri wrote:
> > [+ Will]
> > 
> > I'm not sure how this happened; Will, you at least figure as Reported-by: ;-)
> 
> Thanks, this looks better to me. Have you build an Alpha kernel to check
> that the various cmpxchg variants are producing the expected asm?

Indeed.  Compile tested (only).

  Andrea


> 
> Will
