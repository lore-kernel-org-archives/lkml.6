Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeFDJDw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:03:52 -0400
Received: from foss.arm.com ([217.140.101.70]:40408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751948AbeFDJDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:03:51 -0400
Date: Mon, 4 Jun 2018 10:04:22 +0100
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@kernel.org
Subject: Re: [PATCH v2 0/9] Rewrite asm-generic/bitops/{atomic,lock}.h and
 use on arm64
Message-ID: <20180604090421.GA9482@arm.com>
References: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
 <20180604074029.GN12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604074029.GN12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 09:40:29AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 01, 2018 at 05:06:20PM +0100, Will Deacon wrote:
> > Hi all,
> > 
> > This patch series has previously been posted in RFC form here:
> > 
> >   RFCv1: https://www.spinics.net/lists/arm-kernel/msg634719.html
> >   RFCv2: https://www.spinics.net/lists/arm-kernel/msg636875.html
> >      v1: https://www.spinics.net/lists/arm-kernel/msg655262.html
> > 
> > The only change since v1 is that some of the fetch ops are replaced
> > by non-value-returning ops for some of the atomic bitops.
> > 
> 
> Looks good,
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks, Peter!

> How do you want to route this, through tip or the arm64 tree?

I think -tip would make the most sense, if that's ok with Ingo.

Cheers,

Will
