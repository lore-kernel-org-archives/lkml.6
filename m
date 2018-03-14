Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeCNJ3I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:29:08 -0400
Received: from ozlabs.org ([103.22.144.67]:51507 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752419AbeCNJ2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:54 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 97c6f25d5828b497e3e802b1f7c70187c88df623
In-Reply-To: <1520412364-2680-1-git-send-email-wei.guo.simon@gmail.com>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Simon Guo <wei.guo.simon@gmail.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: PCI/hotplug: ppc: correct a php_slot usage after free
Message-Id: <401RHS1y6kz9sRX@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:43 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 08:46:04 UTC, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> In pnv_php_unregister_one(), pnv_php_put_slot() might kfree
> php_slot structure. But there is pci_hp_deregister() after
> that with php_slot reference.
> 
> This patch moves pnv_php_put_slot() to the end of function.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/97c6f25d5828b497e3e802b1f7c701

cheers
