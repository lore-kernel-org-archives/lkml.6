Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88955C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455F72083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455F72083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeIAM0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:26:01 -0400
Received: from mout.perfora.net ([74.208.4.197]:42425 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbeIAMZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:05 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MKKIa-1fwZGn1ZMk-001iMQ; Sat, 01 Sep 2018 10:13:47 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 24/34] ARM: tegra: colibri_t30: annotate ehci instance 1
Date:   Sat,  1 Sep 2018 10:12:38 +0200
Message-Id: <20180901081248.22639-25-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:FZTSuWWrzUZrkNTBZ4UEgIWEzo2MYT7FRmjMzfpiU2JWbmpTglr
 hzQhf8Mzz0b2f3aJZSWG0iQNvaCxYnQbTE1zsxewl67zuaVpUfpNQUhuBBeVqsslZ4DiosH
 TIs2oG0E99LoXDr+NtU+tAQHS6r38f/dDtb9jY3meTgvCfyNsqlO/Vp7YyIb1Jm6arvDFRQ
 6p+wro29Dubwso2nBUa+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9ed4HiHTTxY=:m+xWsFQnMj9d3DBoYpeRmc
 Or/zLaKIF50/zPe79vxAibckA9cEMVKst5G2aJTENdHvssrBAzT3rOl4l4O6SjwbUfJ4K1HwQ
 Jkx5SdF+c11nlXUP5+GlwhPMQPTqnubjNAsTV6MEREVu9ikYyjDGw7XPenMLpFBhrNVfUHBEK
 eObew20wWjz8vkD3ryUSvuX7fAywc29fO/kdrWozSPQZzfM5nSG0RUp9vW2Akpn+vaHt8rx2F
 aHlDt4zDRnVwCgJMU7pMOFlAMsirh0EJW+xajVpRzfOKCoURzUqdaH9nYOliXKjL0xulLYijt
 oLo10q/pUe9RvbHWos18sxoMfTMm4h3G8Sz+Vuv3gCp1QENyRBmmmlGkAK+lGSGL1SbiDsvPp
 xMFjbHiGE4nB5jXwv/0GaZMDc3PbR127lY6+NxilxAYWFGZ1584QfwR0U2F15y30JtYj0NX6o
 hw3NV+IPgTUD0QfRcbVAeZ8vzsRs0wiVIAC2FldFUcI/v71chyQglDM/HHv1HdQhgD7u5+kkS
 3E9w9O9TQPz+zsPkUv5mR/3QGFp3z1Nw4lXkV+OfG8TNW49SAlcwu2jffe/yQ2tpalTxVZKl/
 9fUQtIHiMxHm9KnN+ojrg7/pH2hhXEW0BF10TMeNdEVQJlbDixKTdgX1RJtbA5LFlbxVJ3FUA
 39ozSVo+SGy0r8cYGQ8AtVQ4NpvDlzvE2+Y8vldi7bSSsVRHaIz/I0zAr0xfmfsh+qa0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate EHCI instance 1 (USB2_DP/N) connecting to ASIX AX88772B USB to
Ethernet chip being on-module.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 1337674c530c..7a4e454a1960 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -939,7 +939,7 @@
 		mmc-ddr-1_8v;
 	};
 
-	/* EHCI instance 1: USB2_DP/N -> AX88772B */
+	/* EHCI instance 1: USB2_DP/N -> AX88772B (On-module) */
 	usb@7d004000 {
 		status = "okay";
 		#address-cells = <1>;
-- 
2.14.4

