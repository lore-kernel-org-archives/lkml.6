Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFB7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6256420862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6256420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeKHDvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:51:39 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:48980 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbeKHDvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:51:39 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id C2FDEBFA47;
        Wed,  7 Nov 2018 19:20:04 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 39EE6C108D; Wed,  7 Nov 2018 19:20:04 +0100 (CET)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 0CF9AC106B;
        Wed,  7 Nov 2018 19:17:58 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v3 5/8] dt-bindings: Add bindings for the LeMaker BL035-RGB-002 LCD panel
Date:   Wed,  7 Nov 2018 19:18:40 +0100
Message-Id: <20181107181843.27628-6-contact@paulk.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107181843.27628-1-contact@paulk.fr>
References: <20181107181843.27628-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the device-tree bindings for the LeMaker BL035-RGB-002 3.5"
QVGA TFT LCD panel, compatible with simple-panel.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 .../bindings/display/panel/lemaker,bl035-rgb-002.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt

diff --git a/Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt b/Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
new file mode 100644
index 000000000000..74ee7ea6b493
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
@@ -0,0 +1,12 @@
+LeMaker BL035-RGB-002 3.5" QVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "lemaker,bl035-rgb-002"
+- power-supply: as specified in the base binding
+
+Optional properties:
+- backlight: as specified in the base binding
+- enable-gpios: as specified in the base binding
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.19.1

