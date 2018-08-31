Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83747C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FB820658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FB820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeHaUrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:16 -0400
Received: from mout.perfora.net ([74.208.4.196]:51649 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbeHaUrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:16 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Mg6RH-1gIXzL48Ht-00NU9I; Fri, 31 Aug 2018 18:38:51 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 13/34] ARM: tegra: apalis_t30: annotate mmc1/sd1
Date:   Fri, 31 Aug 2018 18:37:55 +0200
Message-Id: <20180831163817.23970-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:adX78dha9RwThS7mHkHI70nXHLy+5sD7wgg5OKprSdkpucrNOMl
 uBZXyNwDKW5nCjtXgvIEK4SypScGT5EPPfVWPHR38mCTuXQ2R7HyCWSVs04WC0R/RrylS6k
 GO5NtVtLd0HMIOa5YQmNmWwAesPAKU5oBrphXieFlqTejwK5vyTaurq/tAvTvXDdOu3K+qe
 hV96MAKiznpTNcJNE1Slg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BxeI22J9sqw=:2srT0mu9A8fmlj3d5w5kwo
 jchoKafudhkZCLcs/dsrR63TAq5xXz67kfNoEBeBkCj9ky2GKQeeseLDzkxClKAjFy7VQdCyA
 RRmyncV0+g8OSE1BuctMEe9jxmSUvGLbnp/xjJmGpNQvs1FqVKGoTrv3HWe3j7EkRbMspkonX
 ObHtS+bPk3jgmxUUpbNkfYAQG28l+3zfpCHxmtEz2WrkldI197Nvf+ApkeeG9UogXMrUiknnX
 +bmQN8rkLq1ZpqbSrfwclDuqgtug9KVvHtcnE6emKmyQkyDR0jfxDRkpPb95cg9ViFRq64qbS
 3He2BPrB04neDLWC4qT9WFv0nKENV4gB9swZnx6zBnPE0zD1TiDgq6+6eXQ0kvG/6y2Fl5HMR
 OuIo9JocMhn4mTSkXKzilYBJp1d9sBtb2fsTFDs/FM/lxcEatkDiXZvZqqW2DVWA0q2KTQTAr
 g18WZUo2GVnrENh12NWt8+5hk3UcopUn/r9NmNqSvjKShzzZEMgwBgDsK6FKwvca9WplCpISS
 7lbs5uXhe4x56al7Hbl3KpFo7/iFiJA2EJacl9i9t18YqEFP1iCemM0z3kPvV12CThT5Sw5+x
 p2u0Kj4B/BEJtYWKGlGFgAZjUxoJwcgLpwQBV8bQVCQIz+5JxsRCnXqw05EgaPDVR3mBw/F9u
 ABjTksCTHpv3ZJ68L9dH862bXCRCsV+2PrSQnOrNeOrCmee1rgZU8fCLfJROcTMBovQQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate MMC1/SD1.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 3f25bb307397..15e9de06c59a 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -134,6 +134,7 @@
 		status = "okay";
 	};
 
+	/* Apalis SD1 */
 	sdhci@78000000 {
 		status = "okay";
 		bus-width = <4>;
@@ -142,6 +143,7 @@
 		no-1-8-v;
 	};
 
+	/* Apalis MMC1 */
 	sdhci@78000400 {
 		status = "okay";
 		bus-width = <8>;
-- 
2.14.4

