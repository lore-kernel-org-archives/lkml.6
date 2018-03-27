Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbeC0HgK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:36:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeC0HgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:36:09 -0400
Date: Tue, 27 Mar 2018 09:36:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next 0/6] update static key users to modern api
Message-ID: <20180327073605.GM4043@hirez.programming.kicks-ass.net>
References: <20180326210929.5244-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326210929.5244-1-dave@stgolabs.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 02:09:23PM -0700, Davidlohr Bueso wrote:
> Changes from v1:
>   - added the 'static' keyword where it belongs.
>   - added networking and x86-perf patches. Unlike the first three,
>     these these use the global/extern variants.
> 
> Hi,
> 
> I noticed a few users in the kernel calling stale static key api. Patches
> are straightforward; note that the irqchip was also changed to not use
> refcounting functions as it only 'disables' the feature.
> 
> Applies on today's -next. Compile-tested.
> 

Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
