Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A20C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD30320843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD30320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeIARSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:18:00 -0400
Received: from mout.perfora.net ([74.208.4.196]:45355 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbeIARR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:59 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Mabjb-1gBpCA3HPF-00KCNL; Sat, 01 Sep 2018 15:05:52 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 19/19] ARM: tegra: apalis-tk1: drop unused hdmi_ddc label
Date:   Sat,  1 Sep 2018 15:05:04 +0200
Message-Id: <20180901130504.14318-20-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:DJ1FuYWrIxkid4BvW4wr66Zsnn0zVQSvC2i0TxQK6H84ELm4BF3
 mMBD0uxjZyUpbHdB90+0qet8E74Hat409DRr0Nr5yKftDGVrsV7bdwo8rfJ8F3BKz3ygjS4
 LKDeerOPT/Eh+aV+VmVhEUM82FmAfL+mSV6uBEdfAnLcNyjZFllA1Fw+Rbb8Syy7pCmBGKA
 bH3lPF/F/FcB0k+1lokSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iKe/b6ll7ig=:n9V1caElbjT9wfTyTNPiqT
 Qq8+lUgxe+gLLHhq6xueDeAJ+C4RtEC00tWQFEHurShtmUKqpPLSto6/OnxRsD08IP6WgCRut
 jjAbFZ5et2RNQZFwDUtX+AUOzECY1OAkxzjUEHE7Bzt5sXjMe7B7PYDfOdV+PCW7RAWhBxwfw
 TGhqet4cBlBhN6HcJFjDZhYAgvfuhMjzCuqWaX69DGk8Se0+ngwz2+EskICLRl8Jqr5YxL4gP
 qqv/2Mw7xkRRIDen/6y/aUDQhNaiMqv+/+kDNAgPP4SXq+AyA4NawVfiYOYIuf9zOqninpQkm
 c3SCldl3EGxOO6z8IgzkvXzT0I9eWobrkM+GMGkCy09ia8npFzjkyv7czotPmrSeTsu4qRtm1
 wZ25AzYcEsFLJqx5EPgyZRe6jWA9bCjq/pcwc+Flt2JbgIItG7DSMlwOfuMX2kwCY0L0WNdze
 x5CbLAC5vexL3nMpnppwH2pfqXodclrQrkHTEEzkV/mxlpvqywT6VXwN6TT0OkXPy3wR6cxbo
 +G98oYK7G1NT4N1N3VMD+GsD9xZY5LjyPM1eX7Ojm+eKZIj4EL+pmHwunXCRf2S7szK18vmRP
 bPlp5GEWnniUhDt0keQ1MIZDuUInPFGGTIOPduAhncIf/ODJk395qpS5TPfN7ds5X/5uXC6a4
 oPklRXCr8+OhEC3tRMrgBxd1PFJo7akzKpK6AH0QUMWQFRhV9x0aIKU6HJaTWc+aDj7M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop unused hdmi_ddc label.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra124-apalis-eval.dts      | 2 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index 0b4ac640e54f..eaee10ef6512 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -123,7 +123,7 @@
 	/*
 	 * GEN2_I2C: I2C2_SDA/SCL (DDC) on MXM3 pin 205/207 (e.g. display EDID)
 	 */
-	hdmi_ddc: i2c@7000c400 {
+	i2c@7000c400 {
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index 799382d04bba..7961eb4bd803 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -100,7 +100,7 @@
 	 * I2C4 (DDC): I2C4_SDA/SCL (DDC) on MXM3 pin 205/207
 	 * (e.g. display EDID)
 	 */
-	hdmi_ddc: i2c@7000c700 {
+	i2c@7000c700 {
 		status = "okay";
 	};
 
-- 
2.14.4

