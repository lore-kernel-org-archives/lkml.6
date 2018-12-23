Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE06C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25962173B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbeLWN2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 08:28:12 -0500
Received: from ozlabs.org ([203.11.71.1]:51077 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbeLWN2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 08:28:07 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43N38Q0SKfz9sNw; Mon, 24 Dec 2018 00:28:05 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 96d19d70e1012383365c68e271d99f833a2d85f3
X-Patchwork-Hint: ignore
In-Reply-To: <8b818f91a5dd1e33f4ffac11ad45d72a8caafb80.1545290681.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/8xx: Allow pinning IMMR TLB when using early debug console
Message-Id: <43N38Q0SKfz9sNw@ozlabs.org>
Date:   Mon, 24 Dec 2018 00:28:05 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-20 at 07:25:28 UTC, Christophe Leroy wrote:
> CONFIG_EARLY_DEBUG_CPM requires IMMR area TLB to be pinned
> otherwise it doesn't survive MMU_init, and the boot fails.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/96d19d70e1012383365c68e271d99f

cheers
