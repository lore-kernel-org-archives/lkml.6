Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0B5C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC2620874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC2620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbeGVRro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:44 -0400
Received: from mout.perfora.net ([74.208.4.194]:45233 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbeGVRrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:43 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MK2aJ-1fgS512OZx-001RRy; Sun, 22 Jul 2018 18:50:11 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 13/28] ARM: tegra: apalis_t30: drop unused mmc1/sd1 labels
Date:   Sun, 22 Jul 2018 18:49:21 +0200
Message-Id: <20180722164936.20581-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:lKU62ac6M0jiEAec97uMIWxVYe2LsvIuRsaAbCUqEzlgcA6CDFX
 C572FSqIqJKTwSqQdk2IL2BQxNMSciS3N9CLNWnh2iYxgJkym6zWmYdCrTAPbIfXCDIFojK
 2GP0BuPnRBiNB7bBWXFRdvrts3k8DbjtHXgSLkILGc8JmGfEtgj1cUWA0pFTGW30RxQQMqs
 va5j/1P+1ct7ujm76F6Vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HTQKFBv7zF0=:5MSIyKlT5KRAQ1GktlfSNu
 tnubcpVoAZ774OvqdUaRIksGMSrm5xsxKhPsdFSXzqetRvAojgvlOImVsOEv+DHJLHsn9F1/4
 nEE9lfiyMmsmp/eo9uEt+4JzxmmenqaKKipksa7XOV5ODkkr43zmkiSDmYVNj0xFj2xxtPZ0s
 cM23PIYbaoEygHWecqX/Md72/igjl6XZ3ogDhc9JMNtvBPbISzSZUqr6uDAjojmY5hScXuPrN
 Z+qHkakpP/p4h+HAMHGjqinGZYaiUnXNIgfkBiNNciWRBrOQ9yRyPa2UdTG/IrCCMhNQaQwO3
 zzR1C9Pdn98G4IZcNdbiQZxu+NUAwKScQap1RWvI6AI211/ldaH6hlaWQE8yTqRA3N8fakwkQ
 CCE4d5L5BGTZdbgBxZbrwLLs8M+aq3QQlryVHIRqvKyobQ0clapUMQDWK+lCMs2IlIf43KaME
 +1OpwqKA1Yv+NYy1v9XLOp7VQndXLXNJqbmtIX2mYqBEpS35ffAA0JG8jZBxVcVrac2yV/Ce6
 eGheXkMx//CR6njnLNTRyaKzxKkPRgt3wAaL58zWkd0ZhZ87FZm+ul7w/HdVeJO/u4Yj+TZvO
 /fAOYFFennY5qFvKwUpRYAfZxbg5YaduaEAiIIrvn8v8Da/+YdG9xJNOArkR/AmhMc4qk0zFA
 O1jIbFotG8ypJucN1OlVOkNF+jPLiOjqYR+Ax4hhHG/ZdPAG5Jysh7FWhHEcAQWuyp+c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop unused mmc1/sd1 labels.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 74d588561d9f..078b1061fb26 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -142,7 +142,7 @@
 		status = "okay";
 	};
 
-	sd1: sdhci@78000000 {
+	sdhci@78000000 {
 		status = "okay";
 		bus-width = <4>;
 		/* SD1_CD# */
@@ -150,7 +150,7 @@
 		no-1-8-v;
 	};
 
-	mmc1: sdhci@78000400 {
+	sdhci@78000400 {
 		status = "okay";
 		bus-width = <8>;
 		/* MMC1_CD# */
-- 
2.14.4

