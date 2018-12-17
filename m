Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCBFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA7A217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbeLQEFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 23:05:10 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:53112 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbeLQEFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 23:05:09 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 5D3875FD0F; Mon, 17 Dec 2018 12:05:03 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 04/15] dt-bindings: net: broadcom-bluetooth: Add BCM4330 compatible string
Date:   Mon, 17 Dec 2018 12:04:38 +0800
Message-Id: <20181217040449.31437-5-wens@csie.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
References: <20181217040449.31437-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM4330 is a 802.11 a/b/g/n WiFi + Bluetooth 4.0 chip from Broadcom.
It is found in the Ampak AP6330 WiFi+BT module. The partiular one I have
identifies as BCM4330B1 for Bluetooth and BCM4330/4 for WiFi.

It is unclear if the AP6330 module uses this revision of the BCM4330, or
if there are multiple revisions. The module does not have revision
markings. This patch elects to use just BCM4330 for the compatible
string.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index d9d734a07faf..c26f4e11037c 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -11,6 +11,7 @@ Required properties:
 
  - compatible: should contain one of the following:
    * "brcm,bcm20702a1"
+   * "brcm,bcm4330-bt"
    * "brcm,bcm43438-bt"
 
 Optional properties:
-- 
2.20.0

