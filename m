Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230A2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC52E2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfA2Ebg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:31:36 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:18763 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726762AbfA2Ebf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:31:35 -0500
X-UUID: a74a17bf7a134acc91b59f7f534fbdb4-20190129
X-UUID: a74a17bf7a134acc91b59f7f534fbdb4-20190129
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1413631223; Tue, 29 Jan 2019 12:31:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 12:31:23 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 12:31:23 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <roychl666@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/7] dt-bindings: arm: mediatek: remove unused "mediatek,mt7623a"
Date:   Tue, 29 Jan 2019 12:31:14 +0800
Message-ID: <53903e2e6d01978e5e5e9de4367042dc6749efa6.1548735271.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d1ab6c89b115ad0582815816490fa0c13ea83178.1548735271.git.ryder.lee@mediatek.com>
References: <d1ab6c89b115ad0582815816490fa0c13ea83178.1548735271.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F8CE962E8818BB62CFE66EEE70A012D5699458294B4204827DF00AEBF43FF6A02000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we fallback to use "mediatek,mt7623" for MT7623a, remove unused
root node property "mediatek,mt7623a" in the document.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 8f260e5..a3d1b4f 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -15,8 +15,7 @@ compatible: Must contain one of
    "mediatek,mt6795"
    "mediatek,mt6797"
    "mediatek,mt7622"
-   "mediatek,mt7623" which is referred to MT7623N SoC
-   "mediatek,mt7623a"
+   "mediatek,mt7623"
    "mediatek,mt8127"
    "mediatek,mt8135"
    "mediatek,mt8173"
-- 
1.9.1

