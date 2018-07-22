Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCACAECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A339C20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A339C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbeGVRra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:30 -0400
Received: from mout.perfora.net ([74.208.4.197]:57453 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730084AbeGVRra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:30 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MUFcK-1fZ4MW1iqY-00R2fl; Sun, 22 Jul 2018 18:50:06 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 11/28] ARM: tegra: apalis_t30: drop unused cami2c label
Date:   Sun, 22 Jul 2018 18:49:19 +0200
Message-Id: <20180722164936.20581-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:lhOY7CXOfJRQi0q2aVwlOZs0HgThAudrOBuVfbRiUajkzjqzu0S
 t7ULmW7oRf9lstNsa+GymMpXoNhJbL6OFqW7t9m9h3gRIf4fcvXJ2u85PlEyjZFEzmfwZ9V
 jUZf/+urCHCBYuoOMFRSWWCYL0omN1KzfAIjUvKtAIGJpIHLLZUIgC81BcMEOnSAE9EScEf
 a/S7Yru68UGYEb/hAuBCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ob2XaxO/54M=:UHc0iaJB2cWBFLG4VjFVVW
 fqJ9EIHNIfIee5cgZLI7AmVMRR1kU1xIOvBlZ9YGumzwW1r2UZhsHr/O8KcHWvNSaMS+Ic/GT
 7cTNJIKjCfsW+3lpEIiZJ4uHURAjbCZlp4uCbpjuxzABJTshzjrl+EtW1bgXqx9SNJCEONMzL
 pcVP0MovXRIgpVh44HFTQtNixFZgYf4K7p60FKIA/GcdnQpCMkYILNYHTGcOPFohUqp8pw0Lk
 Qct67kSpuwtWGyOly7MpHLguDzs/Pmnq0d6bC0rzCPFkTNp0q1ZaYoJLx3U7xThdIbigxoe/I
 oXwdLR9SMIUmeXGzPnq586uFGg70lP6zvkBlKq3jnrjNVQwmx8cnIh05tb4mQxZH63dDFqk6e
 S9L4U4wevv4L2tLQgHTCRNBpw12ISreYhBqFtiuREmd845XcAdaY24On16eJE3X+ue41zopjv
 2ZyBbIfHdin4vn0iLQb+FhY2Nb9SfPjcd4vrKQqwoqGFATr2M0cx55TNC2E6eXDHCekCfR77v
 5kMXq7O7jhyUuQrMKIPNLTIy20zc+1cyGkBSZMLxD2THCLMvxLhX2ocZdkr5U/3i0RGScmVfa
 e888iR3b51FVT5NEtzRiIAv3g49ejHYtspyQiegFNl8ryLOPCPAkbTlndLMNLZ/8cFKytc/Tb
 Z0KmIu30z6wALXDTx6IVkpRlG0U7ALvvi/fZedyj/KWs45DajGWOwm/ZLqvtTAkekZNE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop unused cami2c label.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 37c7db35ab1f..ba178632d82c 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -104,7 +104,7 @@
 	 * CAM_I2C: I2C3_SDA/SCL on MXM3 pin 201/203 (e.g. camera sensor on
 	 * carrier board)
 	 */
-	cami2c: i2c@7000c500 {
+	i2c@7000c500 {
 		status = "okay";
 		clock-frequency = <400000>;
 	};
-- 
2.14.4

