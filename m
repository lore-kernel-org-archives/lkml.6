Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD35ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF6D20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF6D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389305AbeGWNiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:55 -0400
Received: from mout.perfora.net ([74.208.4.196]:46745 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388464AbeGWNiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:54 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MTQCf-1fXvCy3dBv-00SRhK; Mon, 23 Jul 2018 14:37:44 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 19/26] ARM: tegra: colibri_t30: line break long compatible property line
Date:   Mon, 23 Jul 2018 14:36:50 +0200
Message-Id: <20180723123658.980-20-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:4FmfPXe2zgNBk52XMR0aDnOIuLIP0sqouKOgRuLNJNU9+oq4BCL
 r3TsJcSTEl3eUUzzDahC6TpDLqBot8ilJ52FElPan3i8TfxBYK8OYPSRktvWzaykGzqxjtT
 n41UCrst3P9+DIYw4jwGh4gyV8Ce6HW33D9H6oVYWHBrfuGbW5kRYAQ2qYt7ap0wm7m/yPM
 3K1Refz8G/1vkpwkj6loQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eo3FzXOXZhc=:N2X9mrOYSBy5S8cFFbRq1b
 yaVuoh8UGLflxAPMIrNwHGFuu17tA2DnZEo0uquT/RYt2eXtBs6EPlEJdR0ZBL++AQwbNGQut
 I82+PknyctXedIvq4axaj6MA6Gy4OduFECpGRkpLN8PTpWfswwEaBa17qnBRdUIAyX1dfz/ar
 f/+gpFuTEkozRB336fh2vSwnUdbkT6gVpleeQlV7Vs+eqWH9RnC0LzQFgNhN5lZVQb1eNL4Ns
 aseEkk8E9CDzlUvJySMzfCVgZGB6bCYbwRQrh1rOWlraG13h9GCCbf8tidcPHZ755eh6LXGf0
 GpIWQpaFBadW6Fh6aW3LEzJ0hUnfHKR/shKwuvIslUHuXfsGVUTcq/H+pLUozaM6Bg/T8L5jM
 4mZdI6o+AWGg0pdT0CLD68RyWLptoITJhcYYozkCTO12aiaOh7d8hZT26Gi/S4+U/iDy1URL0
 NGAk+fdMbvw8kMOFhK2M130txYn6L/iB06V2clf9HMh28y2wxNU7f+wqYnbXQ9tKvmB7EFfwL
 W142oLo6ERKkUHaNpIcnNGsQudwC3Rd8n8cIuoGaUequiURN94QSDXG4urLnUWlQ/6WbnzX5d
 WJT52yxuZyDuhR7O3pG68vH/IeBGolUxPu18je5P+rY0umMGPCl9KcF6+8y6iHznzK3T5tXbH
 sKlgcZAquC/WQTIdXVCkX/ZVG+jDxSvnMnE+AxxtUoevAsMt82LNPg1sEslrmda7CsEo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Line break long compatible property line.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 75373bf17b20..d888180e0507 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -5,7 +5,8 @@
 
 / {
 	model = "Toradex Colibri T30 on Colibri Evaluation Board";
-	compatible = "toradex,colibri_t30-eval-v3", "toradex,colibri_t30", "nvidia,tegra30";
+	compatible = "toradex,colibri_t30-eval-v3", "toradex,colibri_t30",
+		     "nvidia,tegra30";
 
 	aliases {
 		rtc0 = "/i2c@7000c000/rtc@68";
-- 
2.14.4

