Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966877AbeEYLpK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:45:10 -0400
Received: from ozlabs.org ([203.11.71.1]:33947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966541AbeEYLld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:33 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f72cf3f1d49f2c35d6cb682af2e8c93550f264e4
In-Reply-To: <20180404201306.27818-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3, 12/19] powerpc/powermac: Add missing prototype for note_bootable_part()
Message-Id: <40skqH2H4jz9s33@ozlabs.org>
Date: Fri, 25 May 2018 21:41:31 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-04 at 20:13:05 UTC, Mathieu Malaterre wrote:
> Add a missing prototype for function `note_bootable_part` to silence a
> warning treated as error with W=1:
> 
>   arch/powerpc/platforms/powermac/setup.c:361:12: error: no previous prototype for ‘note_bootable_part’ [-Werror=missing-prototypes]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f72cf3f1d49f2c35d6cb682af2e8c9

cheers
