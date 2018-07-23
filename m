Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108E5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FD320881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FD320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389399AbeGWNjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:39:04 -0400
Received: from mout.perfora.net ([74.208.4.197]:58233 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388323AbeGWNjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:39:02 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LjcNC-1gIpj83LHk-00bZ6D; Mon, 23 Jul 2018 14:37:55 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 24/26] ARM: tegra: colibri_t30: annotate sd card detect
Date:   Mon, 23 Jul 2018 14:36:55 +0200
Message-Id: <20180723123658.980-25-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:exU52Rj6ZF5f4CXmOj3jRK8yIr/b3k0pvqkd1c4Sq5hPusfZjS9
 SpcRakMpEeFKagQMDSXwWTIs0Ts2xSImXExS81x4T38cCu2RfAdPlT9lX8nPqE6bP+f4REj
 8vsKj/vSBX0OA/PXwJdHBbz3enZX98FW/iFajQzzEyf5TxCb9dhd5NAVckaSb8dbCeTSdnZ
 Crib6fA/pqNp/lPxIWFpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y8pHl1p0MxU=:6U4ugUT5tmZ0ioOYb7jf8P
 dQAnXNTWFxeVz3m+B0gUXkSL4ozgE7wnQ+ugiC4TrBGqbylce7iKwtljVxrXQW2qjPk+mIKYq
 fxKt9fVf5ZnsExzVO7Aj/8bwEE8HFYVRXAz4b8Nvrv5Otw0fazSehKk+ngLoaoh13wmc7zA0C
 E8WfSY6AI21aFcpoVibxSUjXYswmiDPVvWbxC4y+zoq9KR2IJ3AYwapyO026o7020+bYp7dIw
 MV/XbO9D6bYSkalNuDV57XSiDLgzM8iKAxs16Ox4ZdapWQepLSw0hIFqmsGMYI5cJJ9yo1GG1
 zk3hvPRqxb44qg/WVWEY1cpIvtK0NBRgVbPWFrb634+JdPyV1p5UdsqQVIij2fPthjDsvdh9a
 ez4RrBwkVxhF8GwExcEWEJOFwL3NzovXgG5HrYxrGJR/wKsNz5xGwnX/B3zWjDX1quVjm9Dz+
 4g2LJhwiduZqv5ZAQJztHoyJDYXQg4y6AbWep7bv5Wdk8RFAX6xzs2GHCR6kFb5repjhvU0Zo
 4Mq7THm7e+lvCIZa2ycKCXdeLFwgf481psQNb8wVau9F+5ASBF0CKgLhkMg1dnLX/p6MqRjOh
 FB2TrZYh970UceaQNQqNSo2+u5B6eTY8+ib8mp24Tnpyr01RWLPcJvFh2Iyj5oqZs8E5hcHbW
 O+6dUV/TxiDGXHkEmRdxshyBLP9skyxQmjbgNtujGJjaGtXa0iPrKR8rwcZ6itv+Jv70=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate SD card detect.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 08ca7cc7e0db..c0b41faa4503 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -102,7 +102,7 @@
 	sdhci@78000200 {
 		status = "okay";
 		bus-width = <4>;
-		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>;
+		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>; /* MMCD */
 		no-1-8-v;
 	};
 
-- 
2.14.4

