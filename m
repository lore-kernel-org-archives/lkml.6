Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF12C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B063220989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B063220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeK0Okn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:40:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52259 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728241AbeK0Ojv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:39:51 -0500
X-UUID: 3a12d454d3534ba38ac3d576d8a7f7f3-20181127
X-UUID: 3a12d454d3534ba38ac3d576d8a7f7f3-20181127
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 321124915; Tue, 27 Nov 2018 11:43:03 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 27 Nov 2018 11:43:03 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 27 Nov 2018 11:43:02 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 09/11] dt-bindings: soc: fix typo of MT8173 power dt-bindings
Date:   Tue, 27 Nov 2018 11:42:52 +0800
Message-ID: <20181127034254.24721-11-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181127034254.24721-1-weiyi.lu@mediatek.com>
References: <20181127034254.24721-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D0E5B96CE0538F7C4EF582CEF4019C7542A700D43E52788336DD3A7575BC658A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix incorrect IC name that will affect the MT8183 power dt-bindings

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 include/dt-bindings/power/mt8173-power.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/power/mt8173-power.h b/include/dt-bindings/power/mt8173-power.h
index 15d531aa6e78..ef4a7f944848 100644
--- a/include/dt-bindings/power/mt8173-power.h
+++ b/include/dt-bindings/power/mt8173-power.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _DT_BINDINGS_POWER_MT8183_POWER_H
-#define _DT_BINDINGS_POWER_MT8183_POWER_H
+#ifndef _DT_BINDINGS_POWER_MT8173_POWER_H
+#define _DT_BINDINGS_POWER_MT8173_POWER_H
 
 #define MT8173_POWER_DOMAIN_VDEC	0
 #define MT8173_POWER_DOMAIN_VENC	1
@@ -13,4 +13,4 @@
 #define MT8173_POWER_DOMAIN_MFG_2D	8
 #define MT8173_POWER_DOMAIN_MFG		9
 
-#endif /* _DT_BINDINGS_POWER_MT8183_POWER_H */
+#endif /* _DT_BINDINGS_POWER_MT8173_POWER_H */
-- 
2.18.0

