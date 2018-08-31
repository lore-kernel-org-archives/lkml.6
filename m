Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9F2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB51820658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB51820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbeHaUse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:48:34 -0400
Received: from mout.perfora.net ([74.208.4.196]:51523 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728947AbeHaUrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:47 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MSc3W-1gNAgt45pM-00RalN; Fri, 31 Aug 2018 18:39:20 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 28/34] ARM: tegra: apalis_t30: drop obsolete spidev nodes
Date:   Fri, 31 Aug 2018 18:38:10 +0200
Message-Id: <20180831163817.23970-29-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:rsvFreHSFJ4TVMARumAgpNSiLhxBPMJvKXamYsi8Q4c7UyJGuV5
 S858tfKYNB/BiFA1deu7EGK+EFkBOc2UXahd7ONNYmjYiccJ4r05/9Fq95LvmYat/SBznol
 UhcjX0TFsLAv1Z41VHMT/kcbmLsJzGiy6CFIZ//p2Z9mUTTg3PiNy3jSJXJXbAEoAkZ5C1E
 i3j72YNRPytJZIIms0CKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:34AIFXqn0hM=:9JkpQzHC0mayTgF90aZltA
 7jQ6oECUZFrXV+1qcRMTY6BLSOvAtg63/9fYuXR5F25vHS+wmsdUZ9sIwqSBYEvwhvnl7QnxK
 kBcHTtBccpF9aTMDjrRCC+lSUWp3aXT2mSsUqyQ1qLSyOkIC2xY+fbO9UZhS0+54abBFIrCT0
 XCA2VbU/E7G3c+kYqtVhmMRJfIsjeTyyiBLRoT4xENZnNDWYabwfM0TqaUrhUMhgkaXSV+ajr
 ThZ1J+kmQ/Yw/JVuVdbYq2BBoCUpx8xmJpcZBXb8WDGeSOKFweE96yHLtPo3L1Rx2U2GiUvP5
 t0Hz+33Ffq+aWlE0XtFBRszRXwTAcadxRHmpUebDp+ZXkhx9iRSewjYXrpGna8RRyvqzJCBIg
 e1OkzMle44R3su083ROZx2a6E5Wq4pDrqUD+XooS7pyv5DAtEKbqCWLe5WbZeMsdVn2hu3BUm
 P0qDvGXz4gd6sxMt/ET6egbbA3uoFT2EmPjJd+iJbMDRpPNUn1IN/ag+6DtPfNBcyHMdcoy61
 ycdeYcr75tpqy1ZzxBMNbU+FJia+jA4mxN8TsHsJNXYnQ2JBiNWOW0LYDt56ddirTZrfXKxBo
 P0Oy3AKL7+8v3h3nVhzCqZi5EX8yRGgxTXeLUwdnGlrHKqtgaplQ2ccLsXJqH3JRP0eAWkoKo
 ywXjYGYQQ/PjnDp1aZ37zdJVjNaesHrkYhTcHSnJDLQVKzDFo0AiJ5LOuQFqo5WkKA/Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop obsolete spidev device tree nodes as nowadays one should do this
by binding the spidev driver to specific instances/chip selects at
runtime.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 97e2f1822a94..bbde98fd9712 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -111,24 +111,12 @@
 	spi@7000d400 {
 		status = "okay";
 		spi-max-frequency = <25000000>;
-
-		spidev0: spidev@1 {
-			compatible = "spidev";
-			reg = <1>;
-			spi-max-frequency = <25000000>;
-		};
 	};
 
 	/* SPI5: Apalis SPI2 */
 	spi@7000dc00 {
 		status = "okay";
 		spi-max-frequency = <25000000>;
-
-		spidev1: spidev@2 {
-			compatible = "spidev";
-			reg = <2>;
-			spi-max-frequency = <25000000>;
-		};
 	};
 
 	hda@70030000 {
-- 
2.14.4

