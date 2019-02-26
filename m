Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393C8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFE22147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfBZD1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:27:54 -0500
Received: from ozlabs.org ([203.11.71.1]:48541 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfBZD1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 22:27:53 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 447klq3Nv0z9sDL; Tue, 26 Feb 2019 14:27:51 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6d183ca8baec983dc4208ca45ece3c36763df912
X-Patchwork-Hint: ignore
In-Reply-To: <e3ad0e890941de019189a616cbb40c3665264b37.1550775950.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, j.neuschaefer@gmx.net
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v5,01/16] powerpc/wii: properly disable use of BATs when requested.
Message-Id: <447klq3Nv0z9sDL@ozlabs.org>
Date:   Tue, 26 Feb 2019 14:27:51 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-21 at 19:08:37 UTC, Christophe Leroy wrote:
> 'nobats' kernel parameter or some options like CONFIG_DEBUG_PAGEALLOC
> deny the use of BATS for mapping memory.
> 
> This patch makes sure that the specific wii RAM mapping function
> takes it into account as well.
> 
> Fixes: de32400dd26e ("wii: use both mem1 and mem2 as ram")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jonathan Neuschafer <j.neuschaefer@gmx.net>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6d183ca8baec983dc4208ca45ece3c36

cheers
