Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193BBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA1A2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hopsi5H5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA1A2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeH2BCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:02:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47732 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH2BCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3O2+R9sDzKtEDhZNAcDcWQMGGfC02cUMlOn+/YL4u1I=; b=hopsi5H5VX6I
        vIJqreL1ZEAzvaF8MJAoRT0IJCqs+ubxjAZKBtonpai2v4vcyA/oCm8E6GvDwVRhZuGF/gI+/CqDB
        SLjev5MBkMuRVLRb2mUNdE6A6GFWE8AUuxUO+UW3HOaRp1aNmRLXRXrIFp9rHgG5OHwM+v2dPVo6N
        R6xs4=;
Received: from 94.197.121.204.threembb.co.uk ([94.197.121.204] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fulE0-0007lb-5M; Tue, 28 Aug 2018 21:08:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 26CED440078; Tue, 28 Aug 2018 21:54:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: qcom-rpmh: Add stylistic breaks in the default cases" to the regulator tree
In-Reply-To: 
Message-Id: <20180828205448.26CED440078@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:54:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: qcom-rpmh: Add stylistic breaks in the default cases

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

From beb5a17fa32ed9b3b44be23dda9caf92c01e8200 Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Fri, 10 Aug 2018 13:05:31 -0700
Subject: [PATCH] regulator: qcom-rpmh: Add stylistic breaks in the default
 cases

No functional change here but it can make the code more readable to
have breaks in the "default" case even though it's the last case.
Let's add them.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 301e7f695374..39ccf53fdeb3 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -504,6 +504,7 @@ static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int rpmh_mode)
 		break;
 	default:
 		mode = REGULATOR_MODE_INVALID;
+		break;
 	}
 
 	return mode;
@@ -537,6 +538,7 @@ rpmh_regulator_pmic4_smps_of_map_mode(unsigned int rpmh_mode)
 		break;
 	default:
 		mode = REGULATOR_MODE_INVALID;
+		break;
 	}
 
 	return mode;
@@ -566,6 +568,7 @@ static unsigned int rpmh_regulator_pmic4_bob_of_map_mode(unsigned int rpmh_mode)
 		break;
 	default:
 		mode = REGULATOR_MODE_INVALID;
+		break;
 	}
 
 	return mode;
-- 
2.18.0

