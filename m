Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FC9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC4C20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC4C20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeHaUrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:10 -0400
Received: from mout.perfora.net ([74.208.4.197]:47755 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbeHaUrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:10 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MRE53-1gLEcs1BU7-00UbyE; Fri, 31 Aug 2018 18:38:45 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 10/34] ARM: tegra: apalis_t30: drop unused cami2c label
Date:   Fri, 31 Aug 2018 18:37:52 +0200
Message-Id: <20180831163817.23970-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:CVJRRcFkEHVVz6n2rr7rK1MwA0vo3EqYumcSDfKqv9xT56XkYVZ
 SJhiRjV/MY4puPkU5mB/FEYQcnxNAMFKEtJ6rxWwzDvh94vdLpJ4PiZdNm9vQz5ej5fSrD7
 0tbb0gLuY5kRZ94F5HfTzZUK/zHKO0YpN74CH08tQhjST3lJOO1YO9cTGIE/Nm30s/gnQRu
 wBNghGaP8NDnIZa0PnnSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WN5nSTPGN/M=:UVtBnQcyCRnPgtSMd7j8Z6
 leqm8p4d5ICNylAw3RVgjtJ9fPdFwL1gRpzQIO5ujd/AZsTwG7ZGJ2mNsG9jaELCrpu2m8kFa
 fY0qI8NyHjW3zBR9LEOr591AfPChfDJYDfrBL1yJdmCAV0OVBJ3dhEooV6LwzGSKWm68VpwzH
 qVb+9seWup46MfNDhphO4CTixH3Xc8SfoQewalFXM2yL79ijCld6b3pu3NI9sgoSiUKxIp34W
 vEaUOK+AHNEvfExanVgNsBO+zBnBdbNOJwG8SD++szmzmGolGuQwpl7suak5a/f+DSMZjZOjH
 u8amDbBqJuXY2zM6zNZmGzJY2YXGW76h8CMK9gfDbQJbkVGUAtiyV7bIM0QvTB6vUKGksCGQM
 JUtUmmBf/6I0hvU5B6SOLajWR6BcPuJLHIEBbGx5HOQGPO4C4KyG/DclYI5ElUrem7mAHFiQl
 bBqim8/bK47ppl+lU4xQx2aNZLmAyc3CYap/ZFOo4rPH11P1HF/pfK6iTKIsy79ICEBCyMQYg
 R6T0a9Blo76lJnVh6BhTpx+1rZYTfsexRDmLHO0k4I34c4nwb36g+/aEIjfYCFjvDi0v7/zep
 dWU4I7gdKcAI9ndPS1K4hujBu33LFOMMZ3xVwDLbFx9l1OZAzd2KTCmnKVuaQebygdbN505sp
 qP5ItIQr84uGETrjuFrv4Rd3DAuoJ4VJx1vIUepYW6fbuzodX6aiGUk8RlxKLXXj46w4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop unused cami2c label.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index cd4e45759ac8..3f15f327f293 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -95,7 +95,7 @@
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

