Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C8EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B74222ED
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550411464;
	bh=Lo3QpywMng51BAjfQRQk60HHBjYxTP5sjQLhwW86Ncg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R7RMEh2O90GZR1J5pbedATiS1DDiRNrZFGtf0+6rAUaOS5149Pio00/qNdmKUJr7D
	 5ZvEawDH42QmJRFhpXn+DbRBupFwytBgdV/qg863Ak9k1Fch+3xhQtXPPDlFCSTSqd
	 6ol/AeuTujiFLF86qhy9/SwlRGLgtqUWA+tkCs3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfBQNvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:51:02 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:7305 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726202AbfBQNvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 08:51:01 -0500
X-UUID: e57001a667c74394a1eaf8482b308ce4-20190217
X-UUID: e57001a667c74394a1eaf8482b308ce4-20190217
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@kernel.org>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1235803234; Sun, 17 Feb 2019 21:50:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 21:50:52 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 21:50:52 +0800
From:   Ryder Lee <ryder.lee@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Weijie Gao <weijie.gao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/3] dt-bindings: soc: fix a typo for MT7623A
Date:   Sun, 17 Feb 2019 21:50:31 +0800
Message-ID: <4dc5366741758441388ffd4c976135d28d2ed652.1550233614.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
References: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

This fixes a typo for MT7623A

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index 9a88d418..876693a 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -35,7 +35,7 @@ Required properties:
 	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
 	Required clocks for MT6797: "mm", "mfg", "vdec"
 	Required clocks for MT7622 or MT7629: "hif_sel"
-	Required clocks for MT7622A: "ethif"
+	Required clocks for MT7623A: "ethif"
 	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
 
 Optional properties:
-- 
1.9.1

