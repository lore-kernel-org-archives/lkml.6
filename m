Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9BCC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DEE20868
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DEE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeKESCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:02:40 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:14554 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727537AbeKESCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:02:39 -0500
X-UUID: 18df8452e77f4dce92128b72518afa16-20181105
X-UUID: 18df8452e77f4dce92128b72518afa16-20181105
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 372779556; Mon, 05 Nov 2018 16:43:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 5 Nov 2018 16:43:57 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 5 Nov 2018 16:43:57 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-clk@vger.kernel.org>, Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] dt-bindings: arm: mediatek: document clk bindings for MT7629
Date:   Mon, 5 Nov 2018 16:43:56 +0800
Message-ID: <b947cd11a6b13a7a160bbb6af42261bf50bffe28.1541143168.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <815e38d4d74689980cd73c86d9e80fd5854cfc94.1541143168.git.ryder.lee@mediatek.com>
References: <815e38d4d74689980cd73c86d9e80fd5854cfc94.1541143168.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 28512F20D637FED0EEC8FE906F10F24284664C8EB0BF67104F5791262DFDCFA82000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for apmixedsys, infracfg,
pciesys, pericfg, topckgen, ethsys, sgmiisys and ssusbsys for MT7629.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt     | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt   | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt    | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt    | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt   | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt   | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt   | 1 +
 8 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index 4e4a3c0..de40754 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6797-apmixedsys"
 	- "mediatek,mt7622-apmixedsys"
 	- "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
+	- "mediatek,mt7629-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
 	- "mediatek,mt8173-apmixedsys"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
index f17cfe6..6b7e806 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
@@ -9,6 +9,7 @@ Required Properties:
 	- "mediatek,mt2701-ethsys", "syscon"
 	- "mediatek,mt7622-ethsys", "syscon"
 	- "mediatek,mt7623-ethsys", "mediatek,mt2701-ethsys", "syscon"
+	- "mediatek,mt7629-ethsys", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index 89f4272..417bd83 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -12,6 +12,7 @@ Required Properties:
 	- "mediatek,mt6797-infracfg", "syscon"
 	- "mediatek,mt7622-infracfg", "syscon"
 	- "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon"
+	- "mediatek,mt7629-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
index 7fe5dc6..d179a61 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be:
 	- "mediatek,mt7622-pciesys", "syscon"
+	- "mediatek,mt7629-pciesys", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
index 6755514..4c7e478 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt2712-pericfg", "syscon"
 	- "mediatek,mt7622-pericfg", "syscon"
 	- "mediatek,mt7623-pericfg", "mediatek,mt2701-pericfg", "syscon"
+	- "mediatek,mt7629-pericfg", "syscon"
 	- "mediatek,mt8135-pericfg", "syscon"
 	- "mediatek,mt8173-pericfg", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
index d113b8e..30cb645 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be:
 	- "mediatek,mt7622-sgmiisys", "syscon"
+	- "mediatek,mt7629-sgmiisys", "syscon"
 - #clock-cells: Must be 1
 
 The SGMIISYS controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
index b8184da..7cb02c93 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be:
 	- "mediatek,mt7622-ssusbsys", "syscon"
+	- "mediatek,mt7629-ssusbsys", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index d849465..d160c2b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6797-topckgen"
 	- "mediatek,mt7622-topckgen"
 	- "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
+	- "mediatek,mt7629-topckgen"
 	- "mediatek,mt8135-topckgen"
 	- "mediatek,mt8173-topckgen"
 - #clock-cells: Must be 1
-- 
1.9.1

