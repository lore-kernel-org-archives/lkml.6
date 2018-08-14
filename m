Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC73C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824DB21765
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824DB21765
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbeHNNZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:25:00 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:26604 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbeHNNY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:24:59 -0400
Received: from droid02.amlogic.com (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 14 Aug 2018
 18:38:34 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: amlogic: Add Meson G12A binding
Date:   Tue, 14 Aug 2018 18:38:39 +0800
Message-ID: <1534243121-33589-2-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534243121-33589-1-git-send-email-jianxin.pan@amlogic.com>
References: <1534243121-33589-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.217]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new bindings for the Meson G12A SoC

Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index b5c2b5c..cf4bbc7 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -57,6 +57,10 @@ Boards with the Amlogic Meson AXG A113D SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,a113d", "amlogic,meson-axg";
 
+Boards with the Amlogic Meson G12A S905D2 SoC shall have the following properties:
+  Required root node property:
+    compatible: "amlogic,g12a";
+
 Board compatible values (alphabetically, grouped by SoC):
 
   - "geniatech,atv1200" (Meson6)
@@ -101,6 +105,8 @@ Board compatible values (alphabetically, grouped by SoC):
 
   - "amlogic,s400" (Meson axg a113d)
 
+  - "amlogic,u200" (Meson g12a s905d2)
+
 Amlogic Meson Firmware registers Interface
 ------------------------------------------
 
-- 
1.9.1

