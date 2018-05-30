Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeE3ONJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:13:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbeE3ONH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:13:07 -0400
Date: Wed, 30 May 2018 16:12:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Hareesh Gundu <hareeshg@codeaurora.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, jcrouse@codeaurora.org,
        Mel Gorman <mgorman@suse.de>, efault@gmx.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/plist.c: Export plist_*() APIs
Message-ID: <20180530141253.GI12217@hirez.programming.kicks-ass.net>
References: <1512484543-24772-1-git-send-email-hareeshg@codeaurora.org>
 <20171205144104.egber33dwpc6uo7c@hirez.programming.kicks-ass.net>
 <12861d19-1579-2f78-7c4c-ac8983b505ae@codeaurora.org>
 <20171206155917.se5mmw2gf5qz4otf@hirez.programming.kicks-ass.net>
 <8a59865a-1143-3ba1-8be7-cf590d422c36@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a59865a-1143-3ba1-8be7-cf590d422c36@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 05:55:05PM +0530, Hareesh Gundu wrote:

> Below is the reference for in-tree kernel module proposal for
> "drviers/gpu/msm" which is referring to plist_* symbols.
> 
> https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/gpu/msm/adreno_dispatch.c?h=msm-4.9#n533
> 
> Could you please revisit the patch and approve for upstream.

I could not find where you actually use the priority. In any case, the
normal way is to submit the export patch along with the patches that use
it.

Please post the lot to the appropriate lists and people and go from there.

Also, you're missing all the SPDX tags, see Documentation/process/license-rules.rst
