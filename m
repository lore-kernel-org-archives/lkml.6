Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeEOICz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:02:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49380 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752675AbeEOICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:02:53 -0400
Date: Tue, 15 May 2018 10:02:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: jpoimboe@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: ignore INT3 padding
Message-ID: <20180515080246.GT12217@hirez.programming.kicks-ass.net>
References: <20180514223504.GA14804@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514223504.GA14804@avx2>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 01:35:04AM +0300, Alexey Dobriyan wrote:
> NOP padding doesn't count as unreachable instruction
> neither should INT3.

Josh already did a patch for that, but I now realize that never hit
lkml.

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=158754d60cdb824383c44a79d2166d5344c7a395
