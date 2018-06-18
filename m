Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C173C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC43208E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="or27itsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC43208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935068AbeFRMBH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:01:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47024 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933575AbeFRMBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IKwQXWkadES+wT+gBkJ6JMb2gugJB510eblj2JBJjsE=; b=or27itshy6Bx
        5coXnAc/XSQOeIvCSIH0KMzyo2ClOBkA7wXNeVLFCIEaXn7GpQLGpRGhinxTecfnC55Mzy39Qil2L
        1/8f+AocZ/hmi88IWL38/9dv/BCBQjGyWkHHguiPaEjAZy+dWGr4K0BXajkctpZHFMWrtS9MhcYFW
        VhWP4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsqF-00080u-Jj; Mon, 18 Jun 2018 12:01:03 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsqF-0000XA-5h; Mon, 18 Jun 2018 13:01:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Fix typo in comment of struct regulator_linear_range" to the regulator tree
In-Reply-To:  <20180607235138.92819-1-mka@chromium.org>
Message-Id: <E1fUsqF-0000XA-5h@debutante>
Date:   Mon, 18 Jun 2018 13:01:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Fix typo in comment of struct regulator_linear_range

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

From 7bd0c7ba62e8a9840f15fc4ff0122b29fe1b6413 Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Thu, 7 Jun 2018 16:51:38 -0700
Subject: [PATCH] regulator: Fix typo in comment of struct
 regulator_linear_range

regulator_map_linar_range() => regulator_map_linear_range()

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regulator/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index fc2dc8df476f..dea96ee39fdc 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -46,7 +46,7 @@ enum regulator_status {
 /**
  * struct regulator_linear_range - specify linear voltage ranges
  *
- * Specify a range of voltages for regulator_map_linar_range() and
+ * Specify a range of voltages for regulator_map_linear_range() and
  * regulator_list_linear_range().
  *
  * @min_uV:  Lowest voltage in range
-- 
2.17.1

