Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390B3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04A720855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04A720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeIBOZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:13 -0400
Received: from mout.perfora.net ([74.208.4.194]:51329 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbeIBOZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:11 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MAOLs-1g2Qf047kA-00BjdJ; Sun, 02 Sep 2018 12:09:49 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 17/37] ARM: tegra: colibri_t20: iris: annotate uarts
Date:   Sun,  2 Sep 2018 12:08:46 +0200
Message-Id: <20180902100906.25792-18-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:GHhKGDsefZldAUNRYqw6jgB9Ye4Sy0ppLNrYu0u28LTZo4SlC8Y
 S9fjJ0E4aLQ3HMV/WKViS3LSG1h8RBEbOHj4kVrOWRBQlqDzUZs3ERhL4kXdldDZ/mENwwd
 ak2kZqvDeIDnc5SY9hO4H1tiYbquNj6jUCrxZGyyENoTaX45c/NO6IgcmlTa4BPMhZDGF4G
 eyrmnS9yvWyMZYpFSWRUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6XjaVSRkTLM=:TYk6ciAUzaCpeRnzEI/7iH
 Qi4NXW0Lsooam7Exj0Md7g3G6t8KTlfArq3ltWZEoFe6dDhgosRxcZHhjAbSCL/xLCseU5gOO
 C32KLWoF9TJ1oJhy5DbeW3zFsSUAFFC7WcSVK655KoMRMr7whFIIFJDEJJc5R4vbqdrB/zpSp
 1DIFSW8eiKG0B9eWU/1FvcyzphmDiAMaE9QD7W51Rhwh1JNgpZXZ81KpTaktO5A73g/XdHAjU
 wrsoM/y86TbjyrW15zS/yUMpLZ+f/1FpKkEUkT2QhmNy3GVELtUoWD2OtEmfrSYzJRwJ9ue4g
 IhzcNXKPs1UfrnF5tooYy1gnyS//jkhAqdZIEG5qUyeaaBlszU0WA9K6GHZtGB2qXy/p3v5Sd
 KQ4sd9pgtNFhzLPXmH+B2URqvTSEtXbj0C7H+RinOC6pkiQw8IjB2rRi/DgaPtwStiyJT5O0r
 TdpMCQD0iLDnGXh8VRliMmPD5ZnNWR14oAwSgnriRaaBWGs5CUBi6MnzB4twRlYJRmjN7pT8f
 z8h4verQH8TShdyjfosd8sCNXDeptllSDQfNCkZAuJXTGalqZx2Z0/99PYLQFb6k/KlsDMwQY
 XNxO/O/auNK3W5h2ostDxC15yudcxM0NrnqknVgS2D/bK69w5mZB8O4oRLbXrCRXOYPXCysYN
 Z76hUXEhweLIb3hTKGf0kT8+8rAEpuykPQYs0JtEx+8CIIlYJEhsM0h897dOWAabfb6k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate UART-A and UART-B.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 21713b7ae978..cb3c82287223 100644
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

