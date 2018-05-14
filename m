Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbeENHYC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:24:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753510AbeENHYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:24:01 -0400
Date: Mon, 14 May 2018 09:23:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriel C <nix.or.die@gmail.com>
Cc: kevin.b.stanton@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: commit bd9240a18edfbfa72e957fc2ba831cf1f13ea073 seems to break
 with intel-ucode 20180425
Message-ID: <20180514072355.GB12198@hirez.programming.kicks-ass.net>
References: <CAEJqkgjMMMwK0Y7xSJCGVnbPor1MirA30HrN=U2EsGZNRQFs8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJqkgjMMMwK0Y7xSJCGVnbPor1MirA30HrN=U2EsGZNRQFs8A@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 12:55:35PM +0200, Gabriel C wrote:
> Hi Peter,
> 
> after updating ucode to 20180425 on my laptop I always hit the
> 'TSC_DEADLINE disabled' error and so early microcode update from
> inird breaks.
> 
> Also I'm able to late load the microcode from command line but
> not from initrd.
> 
> Going back to ucode 20180312 make things work again.
> 
> I've tested on latest 4.16.8 kernel for now.
> 
> lscpu output:

Please provide /proc/cpuinfo (a single cpu is sufficient) for both
firmwares.

lscpu (whatever that is) lacks useful information, like the microcode
version.
