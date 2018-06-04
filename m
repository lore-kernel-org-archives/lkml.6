Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbeFDOKh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:10:37 -0400
Received: from ozlabs.org ([203.11.71.1]:53751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753478AbeFDOKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:10:34 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0cc377d16e565b90b43b7550cdf5b3abd7942a75
In-Reply-To: <20180417112310.BD2686C07F@po15720vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/misc: merge reloc_offset() and add_reloc_offset()
Message-Id: <40zxfd308yz9s4Y@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:33 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-17 at 11:23:10 UTC, Christophe Leroy wrote:
> reloc_offset() is the same as add_reloc_offset(0)
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0cc377d16e565b90b43b7550cdf5b3

cheers
