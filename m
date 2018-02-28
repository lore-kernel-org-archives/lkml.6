Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeB1K6L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:58:11 -0500
Received: from foss.arm.com ([217.140.101.70]:47716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752477AbeB1K6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:58:09 -0500
Date: Wed, 28 Feb 2018 10:58:11 +0000
From: Will Deacon <will.deacon@arm.com>
To: Andrea Parri <parri.andrea@gmail.com>
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
Message-ID: <20180228105810.GB7681@arm.com>
References: <1519704058-13430-1-git-send-email-parri.andrea@gmail.com>
 <20180227200830.GA3164@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227200830.GA3164@andrea>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 09:08:31PM +0100, Andrea Parri wrote:
> [+ Will]
> 
> I'm not sure how this happened; Will, you at least figure as Reported-by: ;-)

Thanks, this looks better to me. Have you build an Alpha kernel to check
that the various cmpxchg variants are producing the expected asm?

Will
