Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76516C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D771020685
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D771020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeKBFG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:06:29 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:45986 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeKBFG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:06:29 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 4FFF6BFA47;
        Thu,  1 Nov 2018 21:02:02 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id C88CDC1076; Thu,  1 Nov 2018 21:02:01 +0100 (CET)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id AAB26C1045;
        Thu,  1 Nov 2018 21:00:34 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 4/7] dt-bindings: Add bindings for the LeMaker BL035-RGB-002 LCD panel
Date:   Thu,  1 Nov 2018 21:00:42 +0100
Message-Id: <20181101200045.6078-5-contact@paulk.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101200045.6078-1-contact@paulk.fr>
References: <20181101200045.6078-1-contact@paulk.fr>
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
 .../bindings/display/panel/lemaker,bl035-rgb-002.txt       | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt

diff --git a/Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt b/Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
new file mode 100644
index 000000000000..22cff3eb1b8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
@@ -0,0 +1,7 @@
+LeMaker BL035-RGB-002 3.5" QVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "lemaker,bl035-rgb-002"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.19.1

