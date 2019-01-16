Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5449220866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfAPSiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:38:20 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:60285 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728404AbfAPSiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:38:20 -0500
X-IronPort-AV: E=Sophos;i="5.56,487,1539615600"; 
   d="scan'208";a="5151665"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Jan 2019 03:38:17 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.37.13])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 42BB640F10DB;
        Thu, 17 Jan 2019 03:38:11 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Majewski <lukma@denx.de>,
        Michal Simek <monstr@monstr.eu>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiharaml@si-linux.co.jp
Subject: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Date:   Wed, 16 Jan 2019 18:37:44 +0000
Message-Id: <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das@bp.renesas.com>

Add Silicon Linux to the list of devicetree vendor prefixes.

Website: http://www.si-linux.co.jp

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8..02a7037 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -344,6 +344,7 @@ sgx	SGX Sensortech
 sharp	Sharp Corporation
 shimafuji	Shimafuji Electric, Inc.
 si-en	Si-En Technology Ltd.
+si-linux	Silicon Linux Corporation
 sifive	SiFive, Inc.
 sigma	Sigma Designs, Inc.
 sii	Seiko Instruments, Inc.
-- 
2.7.4

