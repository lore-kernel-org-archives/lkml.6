Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EDBECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C411B20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C411B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeGTIjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:39:54 -0400
Received: from mout.perfora.net ([74.208.4.197]:46051 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeGTIjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:39:54 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MI7Zo-1fkHIf39vq-003uVn; Fri, 20 Jul 2018 09:52:40 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] pinctrl: tegra: fix spelling in devicetree binding document
Date:   Fri, 20 Jul 2018 09:52:35 +0200
Message-Id: <20180720075235.18617-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:ZbjtXORYL4Td64OefD24YS0XBnYZ8AP+zilXfoMlA1bKQ7mt1O+
 XhsCEOM1k8LMYZwVlxM+GV23uv5C9PhFrWNVUJx0IaZUDHrDEJE5XzOYe7mFbBJeTAJwwm5
 RFzS1GK5eke94OZg0LlRtuiHg4V4pyMNGQES2XDQPWXGR4YHO6eWRErQ3pYVWxW+VtUfsAc
 JbKuk4sQLQ/QqHljt2aFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eRm3X56UAQw=:HnBXMkpUgZYwzMbEdsFqyr
 dHPdjhYLSWkgcnTIturdb4lYmySCWjuIiWm/pO/OxCbqCxq56z1wNKQgNhu+eSzsGfm+wkG/M
 Dk0KDNqRleLFhtAk5j+4vsHYPuoCBombcw1CCnIcgnfhpvqGnAbK/Su0tlfWx2m00UMDr0T8M
 Da7fIIZLi5tcEjK+gLDQs4awUhUE6v7HUae6XCejlKr1fWTtEe8UUB3+9CjyYPcQk73zGlwxQ
 0+MtZ84yoXztzYEEG67eT4EVFfWngvLlWI1VkSCtIEcicqy/QVKm88DUADneWWGBvHOn/sSS8
 WvM3qK4T6RAgV5OdY/5e//NcDIAhtz0F7KEirpLBxMJWSiz6Cm8njIgLrKJYoWRMuYaFAcGjm
 r+nTfVwu3Z7rieEaSIOGUvd/beUG+T6j5gSB2pbFTkdgmvMjxCrhrn/osBQbmr8OBGVd19gJm
 /M4iRXUBZtxlH/vxk4feJWEUPXNSoEVQeKlgUcU5jy4Jnw9oXSPHmx1J6wqZJpfHZvj/AKcQQ
 XPT3REywWPWsH/rKOGr9zXB0Y35DgGfYzMv1EAjkJqzY56F9abSe/5NoHzcweafWXCR9A2KdC
 Zs34QBFCJkrxfUfsZUnUPjYSCdGIsPbzLNSoTFCFaBW+s1vpb29ZxjqZ9doOCCQ3GDXG0uVzO
 7IMyBWKFk23TzhIH2HDYDIIyMnQFVkKfZkPcRJC1MifXo//a9SifAZgz1Dd0QSTZoWII=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes a spelling mistake.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt
index ecb5c0d25218..f4d06bb0b55a 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt
@@ -17,7 +17,7 @@ Tegra124 adds the following optional properties for pin configuration subnodes.
 The macros for options are defined in the
 	include/dt-binding/pinctrl/pinctrl-tegra.h.
 - nvidia,enable-input: Integer. Enable the pin's input path.
-		enable :TEGRA_PIN_ENABLE0 and
+		enable :TEGRA_PIN_ENABLE and
 		disable or output only: TEGRA_PIN_DISABLE.
 - nvidia,open-drain: Integer.
 		enable: TEGRA_PIN_ENABLE.
-- 
2.14.4

