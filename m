Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DE0C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E633421773
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeLWN1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 08:27:53 -0500
Received: from ozlabs.org ([203.11.71.1]:38627 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbeLWN1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 08:27:53 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43N3875xhrz9sDN; Mon, 24 Dec 2018 00:27:51 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a083787680f80f2c16316a1d907bf8d3f6b42311
X-Patchwork-Hint: ignore
In-Reply-To: <20181120151230.32159-1-alexandre.belloni@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: powerpc/fsl-rio: fix spelling mistake "reserverd" -> "reserved"
Message-Id: <43N3875xhrz9sDN@ozlabs.org>
Date:   Mon, 24 Dec 2018 00:27:51 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-20 at 15:12:30 UTC, Alexandre Belloni wrote:
> Fix a spelling mistake in a register description.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a083787680f80f2c16316a1d907bf8

cheers
