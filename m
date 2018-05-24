Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965232AbeEXI1d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:27:33 -0400
Received: from foss.arm.com ([217.140.101.70]:38006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964864AbeEXI1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:27:30 -0400
Date: Thu, 24 May 2018 09:27:24 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Subject: Re: [PATCH 00/13] atomics: API cleanups
Message-ID: <20180524082723.2xoceagwflrh5gf4@salmiak>
References: <20180523133533.1076-1-mark.rutland@arm.com>
 <20180523171817.GV12198@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523171817.GV12198@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 07:18:17PM +0200, Peter Zijlstra wrote:
> On Wed, May 23, 2018 at 02:35:20PM +0100, Mark Rutland wrote:
> > This series contains a few cleanups of the atomic API, fixing an
> > inconsistency between atomic_* and atomic64_*, and minimizing repetition
> > in arch code. This is nicer for arch code, and the improved regularity
> > will help when generating the atomic headers in future.

> Thanks for this Mark,
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Cheers!

> Ingo, can you magic this into tip somewhere?

FWIW, I've accumulated acks (and fixed the typo in patch two) in my branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/api-cleanup

Thanks,
Mark.
