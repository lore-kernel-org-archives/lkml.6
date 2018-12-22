Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC458C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA1721917
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbeLVRCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:02:52 -0500
Received: from ozlabs.org ([203.11.71.1]:55597 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389125AbeLVRBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:02 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLSr1Xcjz9sPB; Sat, 22 Dec 2018 20:54:52 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f242e0ac95cadb27527d0b06c957723c9f63dd74
X-Patchwork-Hint: ignore
In-Reply-To: <9e06c82e76e8e29cb1ae0b989f3bbbb6b2099e03.1545053638.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/prom: move the device tree if not in declared memory.
Message-Id: <43MLSr1Xcjz9sPB@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:54:52 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 14:18:27 UTC, Christophe Leroy wrote:
> If the device tree doesn't reside in the memory which is declared
> inside it, it has to be moved as well as this memory will not be
> mapped by the kernel.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f242e0ac95cadb27527d0b06c95772

cheers
