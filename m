Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeCNJ1u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:27:50 -0400
Received: from ozlabs.org ([103.22.144.67]:49557 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbeCNJ1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:27:47 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 58935176ad17976b7a7f6ea25c0ceb2ca4308a30
In-Reply-To: <20180214211519.15683-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>,
        Mathieu Malaterre <malat@debian.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/via-pmu: Fix section mismatch warning
Message-Id: <401RG939z2z9sD0@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:45 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-14 at 21:15:18 UTC, Mathieu Malaterre wrote:
> Make the struct via_pmu_driver const to avoid following warning:
> 
> WARNING: vmlinux.o(.data+0x4739c): Section mismatch in reference from the variable via_pmu_driver to the function .init.text:pmu_init()
> The variable via_pmu_driver references
> the function __init pmu_init()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Suggested-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/58935176ad17976b7a7f6ea25c0ceb

cheers
