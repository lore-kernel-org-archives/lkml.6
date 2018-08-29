Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70EFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C8A20897
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C8A20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeH2MKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:39 -0400
Received: from mout.perfora.net ([74.208.4.197]:34069 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbeH2MKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:38 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LyCFX-1fpmd22FJl-015anT; Wed, 29 Aug 2018 10:14:50 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 17/31] ARM: tegra: colibri_t20: iris: annotate uarts
Date:   Wed, 29 Aug 2018 10:13:53 +0200
Message-Id: <20180829081407.11304-18-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Qi5EbaMBr8lR5gtc7S7rWbth9c5oyyHzyImC88oiT0IZZ/4tYKp
 +JN5yssX4f4awn53sYhwHA774B91DbZo594CzWzYwR3KG6rjrd4CrLGrUp5JWCyJRavUmmf
 ZrT9o5USZJnIWxJogNT65BRY0jUi9INCxOhjqvkcRS986jToEjC5JiGSVqthKutgAnYGdaD
 qCcHhPh9sWWxM+XebnmfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NS5kyD3PG94=:qfQobOMX7uzn7PDvE6UrE+
 39JkPMdATMqJvhEg+VpTM5mAnP4YhhZggo6cnPnkayP0FaKNTe9NfC6XFweTR8pD07EjkmUIB
 0D+3kMV8xEJxyC2rytIbF0nupphM8JUoSrIrLdMWmzfUCYX62SLn7sTexl2HLNzReApO4Lges
 qShJiLdDqka633AHcQvGwae5ZbTHDV95c3RJyB4ghBd5IDMoIdt2rhLj21bgTQk4glfgqtFhT
 cgoNgZp2lBcCGS92PiQ6nGvG91zAWFBENVD5h/6KqX8fwRW0Th89h6jCXz+wvptqTLzvQzJsi
 q0eTLVcgRLJJmCCD/Ne934/+A8dbsqMxynzSPm0KeJzHym4KAOKwSJxpo9Y655LULpCQ7rVx3
 Q4YWPKcjQ4r1q81x90pm+lkw8SiaaphSr3Gx2dIiKPu1rZfIPk5DKtDOkLIIQsbOh5qYxoJTN
 hNEqF8DHQ4IfNml3oKevp+vEWWwb1LSEIyK4v2NPp3g3BTo119Jb8cIL8oXipmTffWZYRNC/s
 9Q261EyZxt1YiC8eERF5Bes+OkDbhA4ifj2cZIa6D4D4TqopQVej5pFOUEl+a/VZlC4gWQxw2
 icXygcGLEQZPtNEIdkcD1WMmG3KtHt/49DejM/Ua/o/u38rCqRvZyrcyjIGnq/hs4R9Lk1u73
 Wwg/7q1jhy/Keorr9e7nmal3wi58PKRA6E+ZwHV4ysKUBstTczZJcVwi8rv6V+crMKyU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate UART-A and UART-B.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index e5e26a6c2861..96d633622f94 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -98,10 +98,12 @@
 		};
 	};
 
+	/* Colibri UART-A */
 	serial@70006000 {
 		status = "okay";
 	};
 
+	/* Colibri UART-B */
 	serial@70006300 {
 		status = "okay";
 	};
-- 
2.14.4

