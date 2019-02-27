Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83F0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EAF218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfB0Evg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:51:36 -0500
Received: from mx.socionext.com ([202.248.49.38]:30986 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729654AbfB0Evf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 23:51:35 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 Feb 2019 13:51:33 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 038E16117D;
        Wed, 27 Feb 2019 13:51:34 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 27 Feb 2019 13:51:33 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 5DB3C40392;
        Wed, 27 Feb 2019 13:51:33 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 34614121B6C;
        Wed, 27 Feb 2019 13:51:33 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v4 02/10] dt-bindings: arm: Add SMP enable-method for Milbeaut
Date:   Wed, 27 Feb 2019 13:52:05 +0900
Message-Id: <1551243125-10597-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a compatible string "socionext,milbeaut-m10v-smp"
for Milbeaut M10V to the 32 bit ARM CPU device tree binding.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 298c17b..365dcf3 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -228,6 +228,7 @@ patternProperties:
                 - renesas,r9a06g032-smp
                 - rockchip,rk3036-smp
                 - rockchip,rk3066-smp
+		- socionext,milbeaut-m10v-smp
                 - ste,dbx500-smp
 
       cpu-release-addr:
-- 
1.9.1

