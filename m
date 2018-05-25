Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966943AbeEYLpp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:45:45 -0400
Received: from ozlabs.org ([203.11.71.1]:33597 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966507AbeEYLlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:31 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 910be6be6c00e6d33d47985586c392155ee7aa0e
In-Reply-To: <20180404201504.28003-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,09/19] powerpc/chrp/pci: Make some functions static
Message-Id: <40skqF5zQZz9s08@ozlabs.org>
Date: Fri, 25 May 2018 21:41:29 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-04 at 20:15:03 UTC, Mathieu Malaterre wrote:
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=1:
> 
>   arch/powerpc/platforms/chrp/pci.c:34:5: error: no previous prototype for ‘gg2_read_config’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/pci.c:61:5: error: no previous prototype for ‘gg2_write_config’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/pci.c:97:5: error: no previous prototype for ‘rtas_read_config’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/pci.c:112:5: error: no previous prototype for ‘rtas_write_config’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/910be6be6c00e6d33d47985586c392

cheers
