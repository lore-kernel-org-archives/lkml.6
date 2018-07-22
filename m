Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04261C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC61E20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC61E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbeGVRr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:29 -0400
Received: from mout.perfora.net ([74.208.4.197]:42897 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730084AbeGVRr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:29 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MFJUg-1fkWfQ1ddk-00EJTv; Sun, 22 Jul 2018 18:50:04 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 10/28] ARM: tegra: apalis_t30: annotate uarts
Date:   Sun, 22 Jul 2018 18:49:18 +0200
Message-Id: <20180722164936.20581-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:iGjWjcn2bmTDRpqnBqGydHf81h3gnh5Oxz51ZUGtlRgSteHD0jT
 yJ4LROO01IsN+0gn3Irgb0/bVBW3l+TD7kgYVsdO5gKpYSeUopUhA++JREq9nC2FBb/Kcnb
 IUjk05xU6qc78wjHRt1pXfF9Y7Uo0H+Sc9I1JyVQLvOkY/bsBs9n+oUCgqUQ9tkf3Yn+3ps
 0OUkN9fbMKwye7LrXMTcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ybvW120ljnQ=:H/IYxvekdkvL7sm80wuLjN
 PNTuoZE9RLOyQ9S1zrbmEnWJnvuX1wdx0KAtAJk/eVfL9n9Tnqr48SoEpCRgk/cu+TQisdUDh
 lgjb+YgdmnJsTaJbEUPzgVNVXt8AII6WtNlBIuONaID0rU8ySXmpaVCEDS341e9B/4Ul+X9Io
 pGAOJnFTXhtkoO5C6MOU/Uo26w+qMtJZ72m5LFEV3QRyB0GA49h4Y3kmVAycIs9bsFCvuofcZ
 cRnpfaR9OKVvqWwPDK4O6Ss8kGJEM5EddzmfX/1eYN0NBUi40+AV93wFZXi/+NFKBT2dEPptR
 fi3wZkGQHAOUCrKStbiK2yg4Lbvlk9+AOdCNPpN/7pqEsDUsIUos91levKIw5ZE8SaF72dSC6
 /y9iVpWPE1Ti93dF0nM2lU9bgTntKpCYfeXFvwfjiIZiYMgB63rILeqrQekIuI8FQrktOEJvW
 P8pwetcf59IHzk8vir+doA2k5xb1Elx38vQsLRnF28KHxXAzT0sQKvAdG2ixNFNy80y/f8nVy
 jHGEH3k7ErKinHB/bRBzSIuBB4GHKo/jMAnVWTb5WC1WXSyy99AW4J0vG2fmubnmNLm3/tA8F
 +GUuubn9ePUCFJRLXkh3nCO5vqNEOFXdpd7uTQpibeP+WS/hOqXX2p2LsuptB2NbiJjzZ1FyC
 PJWzmY59i6WAvBlofstLNishVj64RRmjGKMpi9Aol+mVNlML6xOYOWNYK/oCqfGu6DGw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate UARTs.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 05f3656c058c..37c7db35ab1f 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -51,20 +51,24 @@
 		};
 	};
 
+	/* Apalis UART1 */
 	serial@70006000 {
 		status = "okay";
 	};
 
+	/* Apalis UART2 */
 	serial@70006040 {
 		compatible = "nvidia,tegra30-hsuart";
 		status = "okay";
 	};
 
+	/* Apalis UART3 */
 	serial@70006200 {
 		compatible = "nvidia,tegra30-hsuart";
 		status = "okay";
 	};
 
+	/* Apalis UART4 */
 	serial@70006300 {
 		compatible = "nvidia,tegra30-hsuart";
 		status = "okay";
-- 
2.14.4

