Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755686AbeE1Sxx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 14:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754782AbeE1Sxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 14:53:50 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Remove obsolete insignal-boards.txt
Date: Mon, 28 May 2018 20:53:10 +0200
Message-Id: <20180528185310.21971-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatibles mentioned in insignal-boards.txt are already documented
under devicetree/bindings/arm/samsung/samsung-boards.txt.  Also the
contents of insignal-boards.txt is not accurate, e.g. does not mention
Arndale boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/insignal-boards.txt | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/insignal-boards.txt

diff --git a/Documentation/devicetree/bindings/arm/insignal-boards.txt b/Documentation/devicetree/bindings/arm/insignal-boards.txt
deleted file mode 100644
index 524c3dc5d808..000000000000
--- a/Documentation/devicetree/bindings/arm/insignal-boards.txt
+++ /dev/null
@@ -1,8 +0,0 @@
-* Insignal's Exynos4210 based Origen evaluation board
-
-Origen low-cost evaluation board is based on Samsung's Exynos4210 SoC.
-
-Required root node properties:
-    - compatible = should be one or more of the following.
-        (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
-        (b) "samsung,exynos4210"  - for boards based on Exynos4210 SoC.
-- 
2.14.1
