Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ADDC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325312082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325312082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeLJHdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:33:14 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:12184 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726645AbeLJHdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:33:09 -0500
X-UUID: af72a445e5ac412a96216bf50737ab84-20181210
X-UUID: af72a445e5ac412a96216bf50737ab84-20181210
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1377767707; Mon, 10 Dec 2018 15:32:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Dec 2018 15:32:52 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Dec 2018 15:32:52 +0800
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
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v3 09/12] dt-bindings: soc: fix typo of MT8173 power dt-bindings
Date:   Mon, 10 Dec 2018 15:32:37 +0800
Message-ID: <20181210073240.32278-11-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210073240.32278-1-weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6A43E7A63ECA53F4A2635C1B06219AEAA90E4F553AE4C44779F796BF724976C22000:8
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

