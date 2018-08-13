Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C998C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B830217AC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B830217AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeHMOaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:30:11 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:13636 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbeHMOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:30:10 -0400
Received: from droid02.amlogic.com (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Mon, 13 Aug 2018
 19:48:17 +0800
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
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: Add Meson G12A binding
Date:   Mon, 13 Aug 2018 19:48:19 +0800
Message-ID: <1534160901-22889-2-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534160901-22889-1-git-send-email-jianxin.pan@amlogic.com>
References: <1534160901-22889-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.217]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new bindings for the Meson G12A SoC

Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
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

