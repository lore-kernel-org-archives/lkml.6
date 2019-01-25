Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4645AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C05F21919
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfAYIPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:15:51 -0500
Received: from inva021.nxp.com ([92.121.34.21]:46662 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfAYIPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:15:51 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 98096200317;
        Fri, 25 Jan 2019 09:15:49 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FD11200042;
        Fri, 25 Jan 2019 09:15:44 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E705F402A2;
        Fri, 25 Jan 2019 16:15:37 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     axboe@kernel.dk, shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.tang@nxp.com, Peng Ma <peng.ma@nxp.com>
Subject: [v5 1/2] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to the list
Date:   Fri, 25 Jan 2019 08:10:12 +0000
Message-Id: <20190125081013.21663-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lx2160a compatible to bindings documentation.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
changed for V5:
	- change the lxx2160a to lx2160a

 .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
index 7c3ca0e..9ecc019 100644
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -3,7 +3,7 @@ Binding for Freescale QorIQ AHCI SATA Controller
 Required properties:
   - reg: Physical base address and size of the controller's register area.
   - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
-    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a etc.
+    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a, lx2160a, etc.
   - clocks: Input clock specifier. Refer to common clock bindings.
   - interrupts: Interrupt specifier. Refer to interrupt binding.
 
-- 
1.7.1

