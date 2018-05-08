Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932716AbeEHOwq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:52:46 -0400
Received: from ozlabs.org ([203.11.71.1]:34215 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932375AbeEHOwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:52:43 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0ea5ee035133aeb549883ddc604a6507c9493b9e
In-Reply-To: <20180502112948.1747-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, rostedt@goodmis.org,
        mingo@redhat.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: tracing: Remove PPC32 wart from config TRACING_SUPPORT
Message-Id: <40gMsj6lvLz9s0W@ozlabs.org>
Date: Wed,  9 May 2018 00:52:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-02 at 11:29:48 UTC, Michael Ellerman wrote:
> config TRACING_SUPPORT has an exception for PPC32, because PPC32
> didn't have irqflags tracing support.
> 
> But that hasn't been true since commit 5d38902c4838 ("powerpc: Add
> irqtrace support for 32-bit powerpc") (Jun 2009).
> 
> So remove the exception for PPC32 and the comment.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/0ea5ee035133aeb549883ddc604a65

cheers
