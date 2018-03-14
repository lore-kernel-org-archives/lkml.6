Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeCNJdZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:33:25 -0400
Received: from ozlabs.org ([103.22.144.67]:46503 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbeCNJ1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:27:43 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 65e13c202d7826dc3497c32961008db03fb3eb4b
In-Reply-To: <20180131075445.9292-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/epapr: Move register keyword at the beginning of declaration
Message-Id: <401RG63QgQz9sVK@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:42 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-01-31 at 07:54:43 UTC, Mathieu Malaterre wrote:
> Fix warning for all register unsigned long (0,3-12) that appear during W=1
> compilation:
> 
> ./arch/powerpc/include/asm/epapr_hcalls.h:479:2: warning: ‘register’ is not at beginning of declaration [-Wold-style-declaration]
>   unsigned long register r[\d] asm("r[\d]");
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/65e13c202d7826dc3497c32961008d

cheers
