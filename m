Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432FDC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1C620880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1C620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeLMUTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:19:11 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:19790 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbeLMUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:19:10 -0500
X-IronPort-AV: E=Sophos;i="5.56,349,1539615600"; 
   d="scan'208";a="2765790"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2018 05:19:09 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.37.69])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8A99440F76B1;
        Fri, 14 Dec 2018 05:19:05 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: i2c: rcar: Add r8a774c0 support
Date:   Thu, 13 Dec 2018 20:19:02 +0000
Message-Id: <1544732342-6131-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/G2E (R8A774C0) I2C compatibility with the relevant driver
dt-bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index 30c0485..3ee5e8f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -7,6 +7,7 @@ Required properties:
 	"renesas,i2c-r8a7745" if the device is a part of a R8A7745 SoC.
 	"renesas,i2c-r8a77470" if the device is a part of a R8A77470 SoC.
 	"renesas,i2c-r8a774a1" if the device is a part of a R8A774A1 SoC.
+	"renesas,i2c-r8a774c0" if the device is a part of a R8A774C0 SoC.
 	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
 	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
 	"renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
-- 
2.7.4

