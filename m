Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206C720672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbeLQMhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:37:23 -0500
Received: from gloria.sntech.de ([185.11.138.130]:57710 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732604AbeLQMhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:37:20 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gYs8r-0003o4-7Y; Mon, 17 Dec 2018 13:37:01 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org, hjc@rock-chips.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, mark.rutland@arm.com, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 01/15] clk: rockchip: add clock ids for dphy rx and tx channels on rk3368
Date:   Mon, 17 Dec 2018 13:36:36 +0100
Message-Id: <20181217123650.6773-2-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217123650.6773-1-heiko@sntech.de>
References: <20181217123650.6773-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock ids so that they can be exported from the clock driver
and referenced in the rk3368 devicetree.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/dt-bindings/clock/rk3368-cru.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/rk3368-cru.h b/include/dt-bindings/clock/rk3368-cru.h
index a0063ed7284a..a4ed1f094da8 100644
--- a/include/dt-bindings/clock/rk3368-cru.h
+++ b/include/dt-bindings/clock/rk3368-cru.h
@@ -157,6 +157,8 @@
 #define PCLK_VIP		367
 #define PCLK_WDT		368
 #define PCLK_EFUSE256		369
+#define PCLK_DPHYRX		370
+#define PCLK_DPHYTX		371
 
 /* hclk gates */
 #define HCLK_SFC		448
-- 
2.19.2

