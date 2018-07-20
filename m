Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FABECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F279820652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F279820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeGTJK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:10:28 -0400
Received: from mout.perfora.net ([74.208.4.194]:42855 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbeGTJK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:10:28 -0400
X-Greylist: delayed 1723 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jul 2018 05:10:27 EDT
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MWzli-1fUQ753p7E-00Vywe; Fri, 20 Jul 2018 10:23:08 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2] pinctrl: tegra: fix spelling in devicetree binding document
Date:   Fri, 20 Jul 2018 10:22:57 +0200
Message-Id: <20180720082258.1590-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:U5yQERU9V1/6zuXiEALpL8KQ/ljqzuIzpFdI4E6nWv2R9MmQD5b
 UHUkzHaVI3ZPyckNVvJggBPZdv+/IpGoMEXC34327Y7FGhdbe8IVj7shovz7YZtrSNccRN3
 nkxr5M78rB7mCDpcgLoBpPKuEBKx7lNXmGCmS3ypaHxhN/1e6Dm8qSD4yPQEDY+JmJfyQgA
 tJfxr4QdSXa9aAdK+orig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XvoJtvNxT80=:LA3NwHN2IhJ52yyXbxoNUo
 u/oKcFzWuZfM/kX5a2qlIz+q/ZcRTOybP66+e0sn7W0SaHVqRnd//QNIEKsONYXI0OrjCC1wD
 KXR0ObQ8FVOeJrVsty7pgh+P/t1Veji0KUJNdUDL+QxMC43QT+Zw1pLz4EZ1qZFJbxL7mT8G+
 NZLfOav/V5DA77h0dmVZqXvkC8Pr8l39sRqa891uGmt3Q6kcaJrIv1I0/+h/16pZrrqjebJkX
 00YEfNPIlkCdjEem7Sq4cciEJDC7WAVicd5ctRNJc0nFgsxtAIIyGtyKodYvYc8qCDTd6xItM
 FmAn53B1289YUFgZqkRIXXtBf66BC8fd0c28pfu1HJjU1kpknJDkLRJ6v0Xdor03ZisbvEI0p
 aKh9tVFQqufGy/8iP/742/SFxOPUffsE3uPMHLsoXW9HYoobhjGO9wORlBia7cHgJZsjlTUT9
 aeehwokNCRgEAT59c0dzDsX683ewexLWn1NM/41bPd0Y9vJhCi8uDDFsgEuxMzIfDMJT9ypjL
 iwAo3aNKhf8CdbKJoaxJhHnq+acZlp2mE8FX75sjlWfWiHU404+bKmPTMUUJzFv1gADpYbuUS
 IwOXGhiuOWOhMd9GDMZgwZOzjfEKPaNPGFZ0Or8jTz/h+Ng1aBelsYhlzwDdR6iuMl+uxsTf1
 tIqM/3MhuocTewl5L/pwuOMXWSy2nTLwbPiRNFoKgMHPJiNhrCKWR7TJXuusUx1lVE0c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes a spelling mistake.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Also fix up the one in nvidia,tegra210-pinmux.txt as suggested by Jon.

 Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt | 2 +-
 Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
index a62d82d5fbe9..85f211436b8e 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
@@ -44,7 +44,7 @@ Optional subnode-properties:
 - nvidia,tristate: Integer.
     0: drive, 1: tristate.
 - nvidia,enable-input: Integer. Enable the pin's input path.
-    enable :TEGRA_PIN_ENABLE0 and
+    enable :TEGRA_PIN_ENABLE and
     disable or output only: TEGRA_PIN_DISABLE.
 - nvidia,open-drain: Integer.
     enable: TEGRA_PIN_ENABLE.
-- 
2.14.4

