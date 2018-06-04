Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeFDHkn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:40:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeFDHkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:40:42 -0400
Date: Mon, 4 Jun 2018 09:40:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 0/9] Rewrite asm-generic/bitops/{atomic,lock}.h and
 use on arm64
Message-ID: <20180604074029.GN12217@hirez.programming.kicks-ass.net>
References: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 05:06:20PM +0100, Will Deacon wrote:
> Hi all,
> 
> This patch series has previously been posted in RFC form here:
> 
>   RFCv1: https://www.spinics.net/lists/arm-kernel/msg634719.html
>   RFCv2: https://www.spinics.net/lists/arm-kernel/msg636875.html
>      v1: https://www.spinics.net/lists/arm-kernel/msg655262.html
> 
> The only change since v1 is that some of the fetch ops are replaced
> by non-value-returning ops for some of the atomic bitops.
> 

Looks good,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

How do you want to route this, through tip or the arm64 tree?
