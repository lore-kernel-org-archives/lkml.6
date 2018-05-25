Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966845AbeEYLox (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:44:53 -0400
Received: from ozlabs.org ([203.11.71.1]:47153 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966243AbeEYLlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:35 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3fc5ee9b2846db2eaddeadf089ef258167c4ee09
In-Reply-To: <20180404201142.27691-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,15/19] powerpc: Add missing prototype
Message-Id: <40skqK5fjTz9s3B@ozlabs.org>
Date: Fri, 25 May 2018 21:41:33 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-04 at 20:11:42 UTC, Mathieu Malaterre wrote:
> Add one missing prototype for function rh_dump_blk. Fix warning treated as
> error in W=1:
> 
>   arch/powerpc/lib/rheap.c:740:6: error: no previous prototype for ‘rh_dump_blk’ [-Werror=missing-prototypes]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3fc5ee9b2846db2eaddeadf089ef25

cheers
