Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbeCTSos (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:44:48 -0400
Received: from ms.lwn.net ([45.79.88.28]:44916 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeCTSor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:44:47 -0400
Date: Tue, 20 Mar 2018 12:44:45 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] x86: Force asm-goto
Message-ID: <20180320124445.3bb1da1c@lwn.net>
In-Reply-To: <20180320155036.GU4043@hirez.programming.kicks-ass.net>
References: <20180319154124.337947038@infradead.org>
        <20180319154717.652679334@infradead.org>
        <20180320094554.2bc49dea@lwn.net>
        <20180320155036.GU4043@hirez.programming.kicks-ass.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018 16:50:36 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > Given that, how about a patch to Documentation/Changes to reflect the new
> > reality?  It's not in RST yet, so you should be able to go there without
> > ill effect :)  
> 
> 
> That thing says:
> 
>   GCC
>   ---
> 
>   The gcc version requirements may vary depending on the type of CPU in your
>   computer. jon
> 
> Which is still entirely accurate. And afaik the 3.2 minimum listed there
> still works for !x86.

Well, other recent discussions established that nothing earlier than 4.1
has been observed to work anywhere for some time.

I guess what we really need is a little table of architecture-specific
minimum GCC versions so that our users actually know what's required.
I'll see if I can find a moment to pull that together at some point.

jon
