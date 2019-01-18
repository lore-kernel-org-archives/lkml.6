Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EFDC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28F420883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfARTsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:48:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46264 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbfARTsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:48:31 -0500
Received: from hades.home (unknown [IPv6:2a00:23c5:58d:db00:68bb:47d:d5ca:9abd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: martyn)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5AB0127D9F6;
        Fri, 18 Jan 2019 19:48:29 +0000 (GMT)
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org,
        Christian Hemp <c.hemp@phytec.de>,
        =?UTF-8?q?Stefan=20Riedm=C3=BCller?= <s.riedmueller@phytec.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 1/2] dt-bindings: Add vendor prefix for Catalyst Semiconductor
Date:   Fri, 18 Jan 2019 19:48:11 +0000
Message-Id: <20190118194812.3319-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix "catalyst" for Catalyst Semiconductor which is
already in use but undocumented.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v2: None

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..d80b23b7771f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -65,6 +65,7 @@ bticino Bticino International
 calxeda	Calxeda
 capella	Capella Microsystems, Inc
 cascoda	Cascoda, Ltd.
+catalyst	Catalyst Semiconductor, Inc
 cavium	Cavium, Inc.
 cdns	Cadence Design Systems Inc.
 cdtech	CDTech(H.K.) Electronics Limited
-- 
2.20.1

