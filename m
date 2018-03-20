Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeCTPuo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:50:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeCTPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:50:41 -0400
Date: Tue, 20 Mar 2018 16:50:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] x86: Force asm-goto
Message-ID: <20180320155036.GU4043@hirez.programming.kicks-ass.net>
References: <20180319154124.337947038@infradead.org>
 <20180319154717.652679334@infradead.org>
 <20180320094554.2bc49dea@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320094554.2bc49dea@lwn.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 09:45:54AM -0600, Jonathan Corbet wrote:
> On Mon, 19 Mar 2018 16:41:25 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > A primary prerequisite for this is of course that the compiler
> > supports asm-goto. This effecively lifts the minimum GCC version to
> > build an x86 kernel to gcc-4.5.
> 
> Given that, how about a patch to Documentation/Changes to reflect the new
> reality?  It's not in RST yet, so you should be able to go there without
> ill effect :)


That thing says:

  GCC
  ---

  The gcc version requirements may vary depending on the type of CPU in your
  computer. jon

Which is still entirely accurate. And afaik the 3.2 minimum listed there
still works for !x86.
