Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855FFECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2185E20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2185E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbeGWNjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:39:07 -0400
Received: from mout.perfora.net ([74.208.4.197]:37623 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388532AbeGWNjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:39:07 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M56zo-1fwEPK3vry-00zGM7; Mon, 23 Jul 2018 14:37:57 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 25/26] ARM: tegra: colibri_t30: annotate ehci instance 1
Date:   Mon, 23 Jul 2018 14:36:56 +0200
Message-Id: <20180723123658.980-26-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:ABY8J/aPScC5xQrlRGFYq+FLSIcSNrdhBNTAE6TBX4eYwW7cyO0
 xPf1ZNK0+/gplIeK+2J1+2D/xotjGw1mMy0V8xEgaFEUydjz/bjcpLcu0pjutDcyIqsxNJN
 wdDClmlqiGJ9k0P14Fk6B+gyi8WTZK1sma9hS0wGZP078daqgMjk128tKl9Kjz6IEkv97Vk
 aiiHTM/BnnUteulNJAQag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0QeaKN8hpkQ=:BEDpKpOtEdhPSmKp3IKEAk
 6cgwWEdbBJfYpfKko0dIXlz59SH1vXJDGtQNUEHZ2RwJ3euG/z4PmAxlO51EezVjFoWMHhV1H
 frcCUf1TZfLE5kGCooSPiZa+pix1Co3maW7d1JvOrQjZZqzW0euOuxHOyvI/apF8DLJScql1I
 emBl7NCzKZXp3uR90UCg47AEEm+5d43+6mnJTA6AyeQSkMsyGqUCSJdLSdgcQYwxxIosSCkzy
 CxXYxmYprS0PLN8p8iDsZnT8Mdib+WvqvNXw6YHG1UhKHOOM8IRO8Mcuu4IDThOAxpTP4oW4A
 54DZJoGsYFDGrcXMcMh9wbBZMBSP7qGyoyCRVDjgarOYF4O3gCE7YZV1vzdG/1MIi9Y0GIYej
 si0Cax2S5ZvYtymcTW0ZnMATdIlpMiOcanTZLZLxWcs6/Irroatok3vsMcnsTCmvQzMXWWbtp
 N0j4OUOCt3HCyLddxaR16eK7S3RboITXcTmkzekJRu2159RFkCtZ+1hIzN4cHwS21GrgtHa+Y
 vC/GFt3OcREyduK9ZVMkDxB3EsfrmGI9852F1dBVkgy17tQHQCIxn4IDCfJB2ySElYFt/FaxZ
 rgu2b3NievBNKJ3nRTnQlSEPZRZWlyM3q98c6/dylH7sYpVZZbQ1XkuiQZx6YdlfaPPTHS2Ye
 ADidbbEcNiPpKZHH0Mdut2stmGGsaMuSPrZRt77+t/2Q8ZgBIhx3xsOpI3fRaP7OP7K8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate EHCI instance 1 (USB2_DP/N) connecting to ASIX AX88772B USB to
Ethernet chip being on-module.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index d3f72e567d5a..e10e0f2b6034 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -939,7 +939,7 @@
 		};
 	};
 
-	/* EHCI instance 1: USB2_DP/N -> AX88772B */
+	/* EHCI instance 1: USB2_DP/N -> AX88772B (On-module) */
 	usb@7d004000 {
 		status = "okay";
 		#address-cells = <1>;
-- 
2.14.4

