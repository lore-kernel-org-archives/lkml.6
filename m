Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4519E214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ceHTfnqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeLRHff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:35:35 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8355 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbeLRHfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:35:31 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18a33e0000>; Mon, 17 Dec 2018 23:35:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 23:35:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Dec 2018 23:35:31 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:35:31 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 07:35:31 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c18a3410002>; Mon, 17 Dec 2018 23:35:31 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 10/12] arm64: dts: tegra210: set EDP interrupt line
Date:   Tue, 18 Dec 2018 15:34:42 +0800
Message-ID: <1545118484-23641-12-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545118484-23641-1-git-send-email-wni@nvidia.com>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545118526; bh=2xyuyRnyUt/ykeAUwBp+4oxwuqn3YHYtQ3ura7HNEEE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ceHTfnqK8IKUiCoatZS2tP+Yk96DNXPAz79toa4Pm3IwAXOUwbHscYmxrHPHDSwjz
         gPJNouQ7pXcu+98hq3hYE6ci8HE8EjdLGPymC/P9vL79voHVT8q8CiEztJRv9j++Qx
         2mkcg8OGlSO0wUFLg2JF9PHPGllHqZCe447GNABnEFxA/1TZXV9vH69z39ABBxpI79
         Fy6Ji7TgMstyenx6hS260axkjA3EH1IF3/qkqU7lnojr6uNBKNnYxwvCjDFJ+ATU7j
         F3V1oWtSoH01xgdP6glzj4SY0aJYw7cxfwlLtVkBwoK0//yCQq1MCPVUj2nEbSsT7Q
         ssVXyckQsVgbw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set EDP interrupt line.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 57dae9cc7b7d..b4531a8c18f6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1324,7 +1324,8 @@
 		reg = <0x0 0x700e2000 0x0 0x600 /* SOC_THERM reg_base */
 			0x0 0x60006000 0x0 0x400>; /* CAR reg_base */
 		reg-names = "soctherm-reg", "car-reg";
-		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA210_CLK_TSENSOR>,
 			<&tegra_car TEGRA210_CLK_SOC_THERM>;
 		clock-names = "tsensor", "soctherm";
-- 
2.7.4

