Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA75EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C374820659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfANKMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:12:13 -0500
Received: from ozlabs.org ([203.11.71.1]:51363 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfANKMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:12:13 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43dTmB6lM1z9sD9; Mon, 14 Jan 2019 21:12:10 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fb0bdec51a4901b7dd088de0a1e365e1b9f5cd21
X-Patchwork-Hint: ignore
In-Reply-To: <9b1d38ef4c4d26f9ef9b6a69a37949a4eee722df.1547025153.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/8xx: fix setting of pagetable for Abatron BDI debug tool.
Message-Id: <43dTmB6lM1z9sD9@ozlabs.org>
Date:   Mon, 14 Jan 2019 21:12:10 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 20:30:07 UTC, Christophe Leroy wrote:
> Commit 8c8c10b90d88 ("powerpc/8xx: fix handling of early NULL pointer
> dereference") moved the loading of r6 earlier in the code. As some
> functions are called inbetween, r6 needs to be loaded again with the
> address of swapper_pg_dir in order to set PTE pointers for
> the Abatron BDI.
> 
> Fixes: 8c8c10b90d88 ("powerpc/8xx: fix handling of early NULL pointer dereference")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/fb0bdec51a4901b7dd088de0a1e365e1

cheers
