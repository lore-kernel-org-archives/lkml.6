Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BAAC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B6420870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544724750;
	bh=7UmUX9xaTdSkNPLRDUKvj2/pvR0L+D+IlPS/sikWQso=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=w9bxKsNZ6jvBIiVMZovte5xJM7mb6pWGmd9ksBSSnpV/oWzJNBeYL+I3nOM7y1NGy
	 8GgQTjaZ6jWUFVWTNFsoL/V3t8ES411WWaZ4tuKaR/ufwsSX2WrqN3S7+uIi/QtSN5
	 LViuYajRbi5aKDmLYZOTiFWpPj0vKbWkHhnv7aBc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B6420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbeLMSM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:12:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37538 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbeLMSLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gB6FGwjKUoZC+I/0YqUK5+FofEbqxJLk+glW6Dsx6FM=; b=fV+8BnvDSJ0v
        6Pft5m6hprMSgoVYXlpzp7o0VgOWhJIJeSKwGyKRuATHMbCSvHCxGIntHWeoVChyUmRXXLERYRH/F
        gqHa/mQeT7zwiWW0SRQaw6v618ebbXhW0XnWV4++9C2pfcXnExMeGUuUu1AyX9qb4cD8eohrwa/+e
        l8rJ8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVSS-0002Qz-Cp; Thu, 13 Dec 2018 18:11:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 160E811254D1; Thu, 13 Dec 2018 18:11:36 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Priit Laes <plaes@plaes.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: dts: enable soft-start and ramp delay for the OLinuXino Lime2" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213181136.160E811254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 18:11:36 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: dts: enable soft-start and ramp delay for the OLinuXino Lime2

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

From c1132b006785b14d01ccf40922493278984555d5 Mon Sep 17 00:00:00 2001
From: Olliver Schinagl <oliver@schinagl.nl>
Date: Tue, 11 Dec 2018 17:17:10 +0200
Subject: [PATCH] regulator: dts: enable soft-start and ramp delay for the
 OLinuXino Lime2

The OLinuXino Lime2 has a big capacitor on its LDO3 output. It is
actually too large, causing the PMIC to shutdown when toggling the LDO3.

By enabling soft-start and ramp delay we increase the time for the
capacitor to charge lowering the current drain on the power regulator.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index b828677f331d..ffafe9720b35 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -245,6 +245,8 @@
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
 	regulator-name = "vddio-csi0";
+	regulator-soft-start;
+	regulator-ramp-delay = <1600>;
 };
 
 &reg_ldo4 {
-- 
2.19.0.rc2

