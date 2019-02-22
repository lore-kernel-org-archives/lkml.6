Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10908C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2BA2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfBVJrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:47:40 -0500
Received: from ozlabs.org ([203.11.71.1]:42201 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfBVJri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:47:38 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RMr2LDDz9sBK; Fri, 22 Feb 2019 20:47:36 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e995265252fad3cf10cec6821ff0870cd95c4f08
X-Patchwork-Hint: ignore
In-Reply-To: <8e172be53248cbc3297b345ae2ce7ddda6d5f0c5.1545070330.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/setup: display reason for not booting
Message-Id: <445RMr2LDDz9sBK@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:47:36 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 06:53:41 UTC, Christophe Leroy wrote:
> When no machine description matches, display it clearly
> before looping forever.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e995265252fad3cf10cec6821ff0870c

cheers
