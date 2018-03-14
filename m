Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeCNJcb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:32:31 -0400
Received: from ozlabs.org ([103.22.144.67]:34369 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751886AbeCNJ15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:27:57 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 848092faa0c7687a99bf465808f7dae5bb5ca6be
In-Reply-To: <20180225172236.29650-13-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [12/21] powerpc: Add missing prototype for time_init
Message-Id: <401RGM4WR3z9sVk@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:55 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 17:22:27 UTC, Mathieu Malaterre wrote:
> The function time_init did not have a prototype defined in the time.h
> header. Fix the following warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/time.o
> arch/powerpc/kernel/time.c:1068:13: error: no previous prototype for ‘time_init’ [-Werror=missing-prototypes]
>  void __init time_init(void)
>              ^~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/848092faa0c7687a99bf465808f7da

cheers
