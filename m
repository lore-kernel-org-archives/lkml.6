Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2BFC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500CE20841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500CE20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeIAMZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:25:17 -0400
Received: from mout.perfora.net ([74.208.4.197]:58719 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbeIAMZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:16 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MBDd5-1g6EKD2sQH-00ACov; Sat, 01 Sep 2018 10:14:01 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 31/34] ARM: tegra: colibri_t30: remove unused mcp2515 can0 label
Date:   Sat,  1 Sep 2018 10:12:45 +0200
Message-Id: <20180901081248.22639-32-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:OTU9zE9pMefYQ6oOXGiuWKuF4sAr4cqPacT+wo9twFVKLtRSBXl
 0j3ur3cje/fbpTZyOxI1QRd65n3JWChv46Bl7P+LRz0uG2R+IOWIo6z2+18pkMK3RSRPTf2
 uZ9qx6rhsj8DBazwcmrrj8LnBxfAADGhaDq9XzIeYITmSrhzRkl7IPcogV7Ys3Kgi6JFMmR
 MAfQX5VoaekTKOk1iVbTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OI20C8RrbHg=:hfU2ACtyQ6gc2rky+SLFU6
 fHa6XkjkNgfNFkWsSQLTW97KhW2ezLqZBI7Vsgg4oTLHYm7Qk6jSNzmWlVwkdrT4ctH3BEzDy
 Icl4S9muD6TblklRJqeWJCizS3UvQcR/TPbkjzX8LLbpiGXA/9eVsa9dFFnf9PZVJKbzmolhC
 kwn71RkcOh8tUQXNSLrSMGFVcL3M6qzR98o0hHqj4qEwlboLhN5QH+5DZQhjJWo+j8tjsZUKr
 VbJYrd+tLFQ145wUVTWIODzHNDkZRLQb+sb/aMYyO8VlBppkPHnfADwA7cp2+7mf5X8wquAqr
 DbtyqVLKocdg4CpjkXKvPlXcH1YQzEtvsWHjT2O0ZT11WMgdi754t22CZ+i/Za6rDaLQ+v49u
 Ry8JsS7lqVWNA8LXoRzfXr5BajIc0h0/xJLqy4oaO2e2HjQ1bay+tJ54FSaoxXXw5KiJJOQTt
 4ZmKR90QLAMwtJAnt9nMk76ALENZYW3uOA2WUFW3IEe5otvxlOXeI0It9JBT5pHBTawSGjZJU
 jrRcKMh7NhkoB7dnmmZJRq5H4xRXsWmqiguZ6gFryFmsH06JNSJx1FnMszX7N3Mmxlxbxf7lr
 WPdhYnDDL+7RDIkBdjX6J0TYMSDVFmt93KydcFrBOMYgUtVxLiUzf+WXUjOLq1ZNI+YuI5Xbp
 bBUTHL7Sr6CvqS4o+sNmVSV9EYmvKvP45YfGQWTVc2zDY3qMZR3OvUNc87F4Znv05SXk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Get rid of the unused MCP2515 SPI CAN controller can0 label.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index ee0a3e5df5b8..618a4b3b6bc8 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -80,7 +80,7 @@
 		status = "okay";
 		spi-max-frequency = <25000000>;
 
-		can0: can@0 {
+		can@0 {
 			compatible = "microchip,mcp2515";
 			reg = <0>;
 			clocks = <&clk16m>;
-- 
2.14.4

