Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF65ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7DC20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7DC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbeGWNiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:54 -0400
Received: from mout.perfora.net ([74.208.4.196]:58457 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388464AbeGWNix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:53 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LpdRY-1gBhue0JPy-00fO3f; Mon, 23 Jul 2018 14:37:46 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 20/26] ARM: tegra: colibri_t30: move input include to carrier board
Date:   Mon, 23 Jul 2018 14:36:51 +0200
Message-Id: <20180723123658.980-21-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:obvhwgP8639JVnPJ+TLr6aY8Z7n9ZIifNSsw8+hzd2tuJph6RRz
 aXoQCty2yjsyV1Apldne5GMU6nvDAoIEUWKYT5NsEm6Y7KZgyL8K+Nu0pqPnxVdTWQkR0r7
 nyPbgtGo6zQoS/pgiqk4uIzP/L7mURSQ/z26s4+8jInUfce2ov6kYPiPINF2XCPrtpydivY
 +svEEpOnKlfDJORjYdlbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zZn/RRUleek=:/mFL4E8+vbx5gtCfSpR99y
 7lLnsNursKp7oXtzEi+HVRxnM5wtXMdN9rBXVWTUZp7jXBWu4rHWuU3grp97uAE7XQ9N8voT/
 MflBAls3AzwxMd2O0QSjmI38DKiSHToHGkgs18nFuSDvrXf9ePo+Gn3O8ia44BL7mYAFOPAng
 o7aDG7M2NpfI3HrciMufSraJp03QyLWsW+awB/JcC9V1ZxgAJZY4kLrHBlr+CEdqQNSRYqwVC
 69NGDB/wQsXnmiKgA3P2l6r9B53mI3sasW8Oa9xJcfMjFe/yP0v/AVmp1zQGKI4eghmph8hBn
 QfFrapRjhHLLfFHpExw1crd/YaxUpb6hud+uF61PjaOx53HM4usiJmbGYlKS97RhuIgowlXct
 LBOxEqtZKdphnW+akgevn4PIkcQcKOX3uMzBFW6OIeCAbNtZF1dkId0gCTeo9HQ3GVvY4qzbo
 U0GGVp8t92PraKnRB2OqUdOnetnEobs657Iz025WsazyIHadUzh0LsOT27ZMloKxbg2prINTh
 i3EdBXost9wUwEeoPEDGSSQ4/qzujr28q9VUBfC8+KVgM+G7607c4Okfey+WC1fCkvuahT200
 X8f7fPs5QyjegyODd8i79kz0PaqTOvwYRCPyiUCuxL5Q9aHldUPUjCBBgbDajremYqd45TGY5
 p7AHVWOpWULKPj6SI44MXUSSRagBv3gIgPcf/G41PTCoGimK+GGPB9XdFQngECWyV5P4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move input include to carrier board.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 1 +
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index d888180e0507..08ca7cc7e0db 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
 #include "tegra30-colibri.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 27e81ffb35c3..211457ea0b72 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/input/input.h>
 #include "tegra30.dtsi"
 
 /*
-- 
2.14.4

