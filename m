Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F50ECDFBB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7E720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7E720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389267AbeGWNiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:50 -0400
Received: from mout.perfora.net ([74.208.4.197]:33415 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389219AbeGWNit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:49 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MPnfw-1fdkbX2w54-004xJP; Mon, 23 Jul 2018 14:37:42 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 18/26] ARM: tegra: colibri_t30: rename clk to clock
Date:   Mon, 23 Jul 2018 14:36:49 +0200
Message-Id: <20180723123658.980-19-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:JhC0mb2SNdZxmswVLdvMdFRQIcyaiRPmKmD+5GFocUnSA8eoR+G
 umFBRCVt3wJLgoiemBk3kxoqxSkx5Ukpz0PtNxRfr0/waXcZAw1Hn/YXdiRSsdEFv+veLIp
 wxbis8jXhAUEV9NiOnef0HsbZGA+1PHjmr5AC1qWBS00Z7zDKzPMto3+zdQNuRzncuOXB9j
 vmkkd9GAejseSdUBsthcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MO+GjA6FhXk=:LRyt1lnubq/F2qRUJL6QCx
 LGBLRsPubj08SX1ziP9rAjI/lRSFmCVDHLemzkoHJWOgAKp4HtDELmiFaG6gwDpzrzJWnypwK
 o31lrbVKx0laGU2Hbw/3t7OMVFpv02pCEMwPjAMrT+hyo/YYVTmmhcE0YH5c2HuMN9ngKp0Xl
 ojFLZJ/1eJgkEEcY2KjY+iCcziPGEfQUvjH3aT0QT61un1rSxTP6sm62d/Iv2cw5j0obS1al8
 7WD0ffKjgadmo9vuvLvBNJ2o1W6Pavbz1hpUOTqELoF4LdgbO85ZFo0IbBb8AagDoEE+ISLCZ
 Vq57h9NY3IUZL8Nu0DdsRvYfHa0Hja5ZU1WzSrq+YcngVGjz1hxRK8Du+nVymEdMTAFO5qsXj
 uuVVVNb3bokji7IrrTTZTod8gxYpB9uCdVENbO+qfb3gOnNtlWcXsOogbjYiO2tP4dCoicA2t
 NRCSU4YGu9DpqzMjLu6k1uGVjKT8Ld3IX2zQBcqPrFzZfIs3YxC92zv/Sw+0175YoHYKoqJo9
 AJ8EDsxIX+fmhB/QxlCq3yiW6BYZiYIKbMiuRk9eGcQoL4Gxb1oNc1/GNn/YF+5Mh3ep7JVJ0
 ZzmX1OkjwRtl8nmR0rhxvqbKgRNB+UQs1OL06oGGj0pKomI6vvqvoLiYvoJREnH3ytaNd3EPB
 hDWYIwEzDY+CsWvGsh8hSfBRv+HiRlYSSwA4gwvFjVUaFK+fqr4TBbypXBXiQbJ/mHB8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename clk to clock.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 621cd15cdfd1..75373bf17b20 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -136,7 +136,7 @@
 	};
 
 	clocks {
-		clk16m: clk@1 {
+		clk16m: clock@1 {
 			compatible = "fixed-clock";
 			reg = <1>;
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 14ce77ebf4a5..27e81ffb35c3 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -959,7 +959,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk32k_in: clk@0 {
+		clk32k_in: clock@0 {
 			compatible = "fixed-clock";
 			reg = <0>;
 			#clock-cells = <0>;
-- 
2.14.4

