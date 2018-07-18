Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307A1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34C2206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34C2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeGRMYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:24:48 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33508 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730512AbeGRMYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:24:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EA9E01A002D;
        Wed, 18 Jul 2018 13:47:02 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DE2761A0004;
        Wed, 18 Jul 2018 13:47:02 +0200 (CEST)
Received: from fsr-ub1464-019.ea.freescale.net (fsr-ub1464-019.ea.freescale.net [10.171.81.207])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 78646205E1;
        Wed, 18 Jul 2018 13:47:02 +0200 (CEST)
From:   Camelia Groza <camelia.groza@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org
Cc:     paulus@samba.org, mpe@ellerman.id.au, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Camelia Groza <camelia.groza@nxp.com>
Subject: [PATCH 2/3] powerpc/dts/fsl: t4240rdb: use the Cortina PHY driver compatible
Date:   Wed, 18 Jul 2018 14:46:50 +0300
Message-Id: <6fa5aa04d257525c5703b7c8ca833ec0ae0047c7.1531903211.git.camelia.groza@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1531903211.git.camelia.groza@nxp.com>
References: <cover.1531903211.git.camelia.groza@nxp.com>
In-Reply-To: <cover.1531903211.git.camelia.groza@nxp.com>
References: <cover.1531903211.git.camelia.groza@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cortina PHY requires the use of the dedicated Cortina PHY driver
instead of the generic one.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t4240rdb.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t4240rdb.dts b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
index 15eb0a3..a56a705 100644
--- a/arch/powerpc/boot/dts/fsl/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
@@ -267,22 +267,22 @@
 
 			mdio@fd000 {
 				xfiphy1: ethernet-phy@10 {
-					compatible = "ethernet-phy-ieee802.3-c45";
+					compatible = "ethernet-phy-id13e5.1002";
 					reg = <0x10>;
 				};
 
 				xfiphy2: ethernet-phy@11 {
-					compatible = "ethernet-phy-ieee802.3-c45";
+					compatible = "ethernet-phy-id13e5.1002";
 					reg = <0x11>;
 				};
 
 				xfiphy3: ethernet-phy@13 {
-					compatible = "ethernet-phy-ieee802.3-c45";
+					compatible = "ethernet-phy-id13e5.1002";
 					reg = <0x13>;
 				};
 
 				xfiphy4: ethernet-phy@12 {
-					compatible = "ethernet-phy-ieee802.3-c45";
+					compatible = "ethernet-phy-id13e5.1002";
 					reg = <0x12>;
 				};
 			};
-- 
1.9.1

