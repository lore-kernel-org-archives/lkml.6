Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68F4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C10D2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C10D2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbeGQJYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:24:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38628 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728624AbeGQJYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:24:16 -0400
X-UUID: 93497e1bf93441d0a73b934f57252650-20180717
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1996916908; Tue, 17 Jul 2018 16:52:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 17 Jul 2018 16:52:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 17 Jul 2018 16:52:34 +0800
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
CC:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, Mars Cheng <mars.cheng@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
Subject: [PATCH v5 02/11] dt-bindings: mediatek: Add smi dts binding for Mediatek MT6765 SoC
Date:   Tue, 17 Jul 2018 16:52:23 +0800
Message-ID: <1531817552-17221-3-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds MT6765 smi binding document

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Owen Chen <owen.chen@mediatek.com>
---
 .../memory-controllers/mediatek,smi-common.txt     |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
index aa614b2..0bf64f5 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
@@ -15,6 +15,7 @@ not needed for SMI generation 2.
 Required properties:
 - compatible : must be one of :
 	"mediatek,mt2701-smi-common"
+	"mediatek,mt6765-smi-common", "syscon"
 	"mediatek,mt8173-smi-common"
 - reg : the register and size of the SMI block.
 - power-domains : a phandle to the power domain of this local arbiter.
-- 
1.7.9.5

