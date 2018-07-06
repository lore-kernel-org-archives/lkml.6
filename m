Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CB2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1E721A27
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1E721A27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932625AbeGFIfE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:35:04 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:35116 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932348AbeGFIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:32:59 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 7LYr1y00A3XaVaC06LYriN; Fri, 06 Jul 2018 10:32:57 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fbMAd-0004h3-4F; Fri, 06 Jul 2018 10:32:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fbMAd-0006cX-1r; Fri, 06 Jul 2018 10:32:51 +0200
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
Subject: [PATCH v5 0/4] DT: Fix spelling of standard properties
Date:   Fri,  6 Jul 2018 10:32:45 +0200
Message-Id: <20180706083249.25399-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series fixes misspellings of various standard DT properties
in DT binding documentation, DTS files, and examples.
While most of these are harmless, some of them may cause hard-to-debug
failures.

Changes compared to v5:
  - Add Acked-by.

Changes compared to v4:
  - Drop patches that have been applied already,
  - Add Acked-by.

Changes compared to v3:
  - Drop patches that have been applied already,
  - Add Acked-by,
  - Add new patches 5 and 6.

Changes compared to v2:
  - Drop patches that have been applied already,
  - Add Rob Herring's Acked-by,
  - Add new patch "[PATCH v2 3/6] arm64: dts: lg1313: DT fix
    s/#interrupts-cells/#interrupt-cells/".

Thanks for applying!

Geert Uytterhoeven (4):
  arm64: dts: lg1312: DT fix s/#interrupts-cells/#interrupt-cells/
  arm64: dts: lg1313: DT fix s/#interrupts-cells/#interrupt-cells/
  dt-bindings: display: amlogic: DT fix s/resets-names/reset-names/
  dt-bindings: net: btusb: DT fix s/interrupt-name/interrupt-names/

 .../devicetree/bindings/display/amlogic,meson-dw-hdmi.txt       | 2 +-
 Documentation/devicetree/bindings/net/btusb.txt                 | 2 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi                              | 2 +-
 arch/arm64/boot/dts/lg/lg1313.dtsi                              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
