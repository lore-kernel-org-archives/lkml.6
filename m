Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC8020663
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfBHMZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:25:23 -0500
Received: from mx.socionext.com ([202.248.49.38]:27747 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfBHMZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:25:23 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Feb 2019 21:25:22 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 8D6F860062;
        Fri,  8 Feb 2019 21:25:22 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 8 Feb 2019 21:25:22 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 1DE9E1A04E1;
        Fri,  8 Feb 2019 21:25:22 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 090FC1202F1;
        Fri,  8 Feb 2019 21:25:22 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v2 03/15] dt-bindings: Add documentation for Milbeaut SoCs
Date:   Fri,  8 Feb 2019 21:26:04 +0900
Message-Id: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a DT binding documentation for the M10V and its evaluation
board.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 Documentation/devicetree/bindings/arm/milbeaut.txt | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/milbeaut.txt

diff --git a/Documentation/devicetree/bindings/arm/milbeaut.txt b/Documentation/devicetree/bindings/arm/milbeaut.txt
new file mode 100644
index 0000000..9fd053a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/milbeaut.txt
@@ -0,0 +1,6 @@
+Milbeaut platforms device tree bindings
+---------------------------------------
+
+- Milbeaut M10V Evaluation Board
+    Required root node properties:
+      - compatible = "socionext,milbeaut-m10v-evb", "socionext,sc2000a";
-- 
1.9.1

