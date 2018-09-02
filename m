Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42174C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F3620841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F3620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeIBOYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:24:48 -0400
Received: from mout.perfora.net ([74.208.4.196]:36033 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbeIBOYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:24:47 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MTylj-1gMZ9f3Kfx-00Qv6Y; Sun, 02 Sep 2018 12:09:23 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 03/37] ARM: tegra: colibri_t20: iris: add missing aliases
Date:   Sun,  2 Sep 2018 12:08:32 +0200
Message-Id: <20180902100906.25792-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Sc+3WyJNCL8r4LXngrUNt8LQgQXdFy/8lsiLo6WI4RiwQTg1K3h
 yyCrj2L2FDmwFCYV1ojjPQpZ+l/ilIXDtB5WEAJd/oOvgKpAZfv9pTv0LVJeN/ZTFQ69UYz
 cYj4ApM9LKC6xEURU1PnhD5HK84S074pxVe1/aFlPReePpa+bS9I6PmEBtbm0VtpxBYJGap
 fnkJnexspGK/FoRpe4mwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yJ57BCTREmQ=:cNOiiyuxa5A1tU7STo9Ww1
 y1ijC1c6OcN+5xfsOBs/KM09Yb13XQ1qpvjPD9QD3cY/aqp4lXSnAsEFQ5lbv2HM5xI22CYRB
 aF4EwSQ1AtDS72si2P4EyGVkfTRCQSZB28J4phVe5l9R/U+a8HGFChIjrAKZ/gqlVtsH2hSLZ
 7OtUArVQIt39b7avOl9Tx7BiFgc21/40Ev45/e5QNO2msBZjdaihkUdGCerp2dcHG1jOir2sx
 adGqnzuDtwPZc7/jPe0OPOKB7+SZUNyQ99J/w04/82BVGHNWuVZwHivRH28xEFI28/5NCXFgn
 wsosWloIXPMjF40OrNJt1UpQHM9LRgPbUZJ+roiX5UeXNu3/ULB0ZQ6myh0IBq+7fm/RzK48q
 PV+iQ4tY4O4VdnrTnvUedNZOzrHu/TT90bXbV01EOiqzAWyXnNYgTMVgnfoJ0p1cL2K8ZcjOg
 lM39Di5znNR916HOZg2RXdzCoGDIHTORs61mpgQVPkyVqOEOEZTV7NPLu9NdB63KyJFQ2LVf7
 norzVnXz9ZsaFseY8v1XjSRodWlHBJu/jBJPBR8jRsuwi0XAiyCl9KqoPb6qV37JKCyqssULd
 ra+rJ4QMQh03XWLd9n1zYcDKugXAPK9dxZGnLTF4VW4t/hO0iZdRokEi0cNNGg5oLYy4DZcJ4
 Ttl/6E14pzJKRVixx/7XOmkq9MCSsmKggfNGUOYJ2rHeHh8JNrZJDO+nVZjeWrqmzzEk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add rtc0 being the ultra low-power I2C one as found on the carrier board
and the 3rd UART being NVIDIA's UARTB.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Fix commit message which was mixed up between "[PATCH 03/31] ARM:
  tegra: colibri_t20: iris: annotate i2c busses" and "[PATCH 04/31] ARM:
  tegra: colibri_t20: iris: add missing aliases".

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index b6d05da8c93c..cbf1f4d76813 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -8,10 +8,12 @@
 	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
 
 	aliases {
-		rtc0 = "/i2c@7000d000/tps6586x@34";
-		rtc1 = "/rtc@7000e000";
+		rtc0 = "/i2c@7000c000/rtc@68";
+		rtc1 = "/i2c@7000d000/tps6586x@34";
+		rtc2 = "/rtc@7000e000";
 		serial0 = &uarta;
 		serial1 = &uartd;
+		serial2 = &uartb;
 	};
 
 	chosen {
-- 
2.14.4

