Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A5FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A89121A27
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A89121A27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932561AbeGFIfC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:35:02 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:41018 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeGFIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:32:59 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 7LYr1y00B3XaVaC01LYrlA; Fri, 06 Jul 2018 10:32:57 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fbMAd-0004hC-6G; Fri, 06 Jul 2018 10:32:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fbMAd-0006ch-4j; Fri, 06 Jul 2018 10:32:51 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>,
        Chanho Min <chanho.min@lge.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 3/4] dt-bindings: display: amlogic: DT fix s/resets-names/reset-names/
Date:   Fri,  6 Jul 2018 10:32:48 +0200
Message-Id: <20180706083249.25399-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706083249.25399-1-geert+renesas@glider.be>
References: <20180706083249.25399-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 8cceda5349377e30 ("dt-bindings: Add bindings for the Amlogic Meson dw-hdmi extension")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
v5:
  - Add Acked-by,

v4:
  - Add Acked-by,

v3:
  - New.
---
 .../devicetree/bindings/display/amlogic,meson-dw-hdmi.txt       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
index bf4a18047309a5f8..d8f6268849f43621 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
@@ -43,7 +43,7 @@ Required properties:
   and the Amlogic Meson venci clocks as described in
   Documentation/devicetree/bindings/clock/clock-bindings.txt,
   the clocks are soc specific, the clock-names should be "iahb", "isfr", "venci"
-- resets, resets-names: must have the phandles to the HDMI apb, glue and phy
+- resets, reset-names: must have the phandles to the HDMI apb, glue and phy
   resets as described in :
   Documentation/devicetree/bindings/reset/reset.txt,
   the reset-names should be "hdmitx_apb", "hdmitx", "hdmitx_phy"
-- 
2.17.1

