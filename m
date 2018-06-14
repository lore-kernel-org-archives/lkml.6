Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3186EC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E504E208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E504E208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964879AbeFNLEO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:04:14 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:17555 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755159AbeFNLEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:04:12 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie2.idc.renesas.com with ESMTP; 14 Jun 2018 20:04:11 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 7B249753C4;
        Thu, 14 Jun 2018 20:04:11 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,222,1526310000"; 
   d="scan'208";a="282525731"
Received: from unknown (HELO be1yocto.ree.adwin.renesas.com) ([172.29.43.62])
  by relmlii1.idc.renesas.com with ESMTP; 14 Jun 2018 20:04:06 +0900
From:   Michel Pollet <michel.pollet@bp.renesas.com>
To:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Cc:     phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Carlo Caione <carlo@endlessm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/3] dt-bindings: cpu: Add Renesas R9A06G032 SMP enable method.
Date:   Thu, 14 Jun 2018 11:58:56 +0100
Message-Id: <1528973943-28132-2-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528973943-28132-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1528973943-28132-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a special enable method for second CA7 of the R9A06G032

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 29e1dc5..b395d107 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -219,6 +219,7 @@ described below.
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
 			    "renesas,apmu"
+			    "renesas,r9a06g032-smp"
 			    "rockchip,rk3036-smp"
 			    "rockchip,rk3066-smp"
 			    "ste,dbx500-smp"
-- 
2.7.4

