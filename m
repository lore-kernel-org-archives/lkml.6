Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbeFDOKp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:10:45 -0400
Received: from ozlabs.org ([203.11.71.1]:38337 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753580AbeFDOKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:10:42 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a6b3964ad71a61bb7c61d80a60bea7d42187b2eb
In-Reply-To: <20180424041559.32410-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: msuchanek@suse.de, linux-kernel@vger.kernel.org, npiggin@gmail.com
Subject: Re: [1/6] powerpc/64s: Add barrier_nospec
Message-Id: <40zxfm40PKz9s0w@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:39 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-24 at 04:15:54 UTC, Michael Ellerman wrote:
> From: Michal Suchanek <msuchanek@suse.de>
> 
> A no-op form of ori (or immediate of 0 into r31 and the result stored
> in r31) has been re-tasked as a speculation barrier. The instruction
> only acts as a barrier on newer machines with appropriate firmware
> support. On older CPUs it remains a harmless no-op.
> 
> Implement barrier_nospec using this instruction.
> 
> mpe: The semantics of the instruction are believed to be that it
> prevents execution of subsequent instructions until preceding branches
> have been fully resolved and are no longer executing speculatively.
> There is no further documentation available at this time.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/a6b3964ad71a61bb7c61d80a60bea7

cheers
