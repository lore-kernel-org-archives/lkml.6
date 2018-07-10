Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA1DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F69B208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F69B208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeGJFTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:19:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39748 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751000AbeGJFTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:19:39 -0400
X-UUID: 092fffb9e9a94ad295e5f7e4b66fd9d0-20180710
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 754724719; Tue, 10 Jul 2018 13:09:30 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 10 Jul 2018 13:09:28 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 10 Jul 2018 13:09:28 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/2] dt-bindings: arm: mediatek: cleanup MT7623N reference boards
Date:   Tue, 10 Jul 2018 13:09:26 +0800
Message-ID: <99c1fce76e7ec4984c232bc0bdbd0fadbb86b0dc.1531199139.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
References: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup binding document to get rid of unsupported reference boards
for MT7623N.

Cc: John Crispin <john@phrozen.org>
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 7d21ab3..c07ddf4 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -59,9 +59,6 @@ Supported boards:
 - Reference board for MT7623n with eMMC:
     Required root node properties:
       - compatible = "mediatek,mt7623n-rfb-emmc", "mediatek,mt7623";
-- Reference  board for MT7623n with NAND:
-    Required root node properties:
-      - compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
 - Bananapi BPI-R2 board:
       - compatible = "bananapi,bpi-r2", "mediatek,mt7623";
 - MTK mt8127 tablet moose EVB:
-- 
1.9.1

