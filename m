Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45018C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71B32156B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71B32156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emtrion.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeHXRBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:01:38 -0400
Received: from mail3.emtrion.de ([80.150.99.69]:28555 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbeHXRBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:01:37 -0400
Received: from tuelinux-v3.emtrion.local (2003:5a:a012:1:20c:29ff:fecb:7426)
 by bmk019s01.emtrion.local (2003:5a:a012:1:d9c:d045:28a7:5f84) with Microsoft
 SMTP Server (TLS) id 8.3.485.1; Fri, 24 Aug 2018 15:26:56 +0200
From:   Jan Tuerk <jan.tuerk@emtrion.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "GitAuthor: Jan Tuerk" <jan.tuerk@emtrion.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 1/4] ARM: dts: imx: Add an cpu0 label for imx6dl devices.
Date:   Fri, 24 Aug 2018 15:26:11 +0200
Message-ID: <20180824132617.43975-1-jan.tuerk@emtrion.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822155137.10018-1-jan.tuerk@emtrion.com>
References: <20180822155137.10018-1-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-11.0.0.4283-8.100.1062-24050.007
X-TM-AS-Result: No--3.128500-8.000000-31
X-TM-AS-MatchedID: 706719-188121-700016-704156-701016-700270-188019-700264-7
        08712-701274-139703-780058-850095-851079-148004-148133-10019-41000-42000-42
        003
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the label cpu0 allows the adjustment of cpu-parameters
by reference in overlaying dtsi files in the same way as it
is possible for imx6q devices.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index f0607eb41df4..2ed10310a7b7 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -15,7 +15,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0>;
-- 
emtrion GmbH
Alter Schlachthof 45
76131 Karlsruhe
GERMANY
https://www.emtrion.de

Amtsgericht Mannheim
HRB 110 300
Geschäftsführer: Dieter Baur, Ramona Maurer

