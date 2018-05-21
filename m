Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeEUKDz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:03:55 -0400
Received: from ozlabs.org ([203.11.71.1]:59489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752952AbeEUKBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:01:30 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5279821a6f5ff75d7dce632e49b9fbca5a2b98da
In-Reply-To: <20180516065857.8043B6F6F2@po14934vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: get rid of PMD_PAGE_SIZE() and _PMD_SIZE
Message-Id: <40qDnh0t87z9s3M@ozlabs.org>
Date: Mon, 21 May 2018 20:01:27 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-16 at 06:58:57 UTC, Christophe Leroy wrote:
> PMD_PAGE_SIZE() is nowhere used and _PMD_SIZE is only
> used by PMD_PAGE_SIZE().
> 
> This patch removes them.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5279821a6f5ff75d7dce632e49b9fb

cheers
