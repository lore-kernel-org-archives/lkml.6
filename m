Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B23C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A292146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A292146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeLGNG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:06:58 -0500
Received: from ozlabs.org ([203.11.71.1]:43023 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLGNG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:06:57 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43BCRN2W12z9s3q; Sat,  8 Dec 2018 00:06:56 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a43ccc4bc499cb592e2cb3b4ada8d396a37e1c8e
X-Patchwork-Hint: ignore
In-Reply-To: <92106c1e558d4ecbdea315669cb4a4407f5dce5e.1543499861.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v9,01/20] powerpc/book3s32: Remove CONFIG_BOOKE dependent code
Message-Id: <43BCRN2W12z9s3q@ozlabs.org>
Date:   Sat,  8 Dec 2018 00:06:56 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-29 at 14:06:47 UTC, Christophe Leroy wrote:
> BOOK3S/32 cannot be BOOKE, so remove useless code
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a43ccc4bc499cb592e2cb3b4ada8d3

cheers
