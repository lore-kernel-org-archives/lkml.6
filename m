Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2DEC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC2E20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC2E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeLKTnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:43:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49248 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeLKTnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:43:07 -0500
Received: from hades.home (unknown [IPv6:2a00:23c5:58d:db00:68bb:47d:d5ca:9abd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: martyn)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 28F1026D650;
        Tue, 11 Dec 2018 19:43:05 +0000 (GMT)
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>,
        Lukasz Majewski <lukma@denx.de>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <monstr@monstr.eu>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 1/2] dt-bindings: Add vendor prefix for Catalyst Semiconductor
Date:   Tue, 11 Dec 2018 19:42:50 +0000
Message-Id: <20181211194251.12988-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix "catalyst" for Catalyst Semiconductor which is
already in use but undocumented.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..bbc41483e81b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -65,6 +65,7 @@ bticino Bticino International
 calxeda	Calxeda
 capella	Capella Microsystems, Inc
 cascoda	Cascoda, Ltd.
+catalyst	Catalyst Semiconductor, Inc
 cavium	Cavium, Inc.
 cdns	Cadence Design Systems Inc.
 ceva	Ceva, Inc.
-- 
2.19.2

