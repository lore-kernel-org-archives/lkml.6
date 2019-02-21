Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B696C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295FC20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550749344;
	bh=u6+rLsAnZUjIc3lzVfxsqRt5nzKpT1tVLtgZD3lx/WY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=kF3CK56lQWW1YHBAvlWR6rWefSIagFnq5ZWyh91gi2RJz8IIh6apMe8Ig2FxXe7uX
	 2hc7Ln7QbHT901UESkM0ahBmsUkFg6+/pu4Y2bwE0F+ZNVtDlvCMTxGLZEXrcFQy28
	 o+K08ZIhIQ3TjzAip6kc/dUQOzpL1xQ4K+eY8UXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfBULmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:42:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43472 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBULmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IG2kw/xfi3AAp+GOdvXof2aw77wVmA1JYE4L6xC4yI8=; b=ufpT7Aej7m62
        g3G+3VmW50OKkangGGjkSUG07fXlTIl6A24nilCVhdQLjYmizlnpr/6/bSZG2B+Y7FozHkhMSqmLg
        maEcHD3F/nb9zSFYmMFQYwRbfMfqV37S1TZ21IuIA8M79vTPywyXDa8RAgTMw5JJZSTAu19aMAg0E
        VZXM0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwmk0-00039i-W2; Thu, 21 Feb 2019 11:42:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 89D7F1122744; Thu, 21 Feb 2019 11:42:12 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied ".mailmap: Add Mathieu Othacehe" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190221114212.89D7F1122744@debutante.sirena.org.uk>
Date:   Thu, 21 Feb 2019 11:42:12 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   .mailmap: Add Mathieu Othacehe

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 36a495bf435bc9a388b6d769baacaf45ae7c3a7f Mon Sep 17 00:00:00 2001
From: Mathieu Othacehe <m.othacehe@gmail.com>
Date: Wed, 13 Feb 2019 17:12:49 +0100
Subject: [PATCH] .mailmap: Add Mathieu Othacehe

Some contributions appears as Mathieu Othacehe and other as Mathieu
OTHACEHE.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index ea98fcc197e4..37e1847c7988 100644
--- a/.mailmap
+++ b/.mailmap
@@ -123,6 +123,7 @@ Mark Brown <broonie@sirena.org.uk>
 Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
+Mathieu Othacehe <m.othacehe@gmail.com>
 Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
 Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
 Matthew Wilcox <willy@infradead.org> <mawilcox@linuxonhyperv.com>
-- 
2.20.1

