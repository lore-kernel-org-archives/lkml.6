Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E68ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB95E20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB95E20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbeGXCUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:20:39 -0400
Received: from hermes.aosc.io ([199.195.250.187]:58074 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388234AbeGXCUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:20:39 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 95AA29F64A;
        Tue, 24 Jul 2018 01:16:41 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/3] Add support for Pine H64 model B w/ Wi-Fi support
Date:   Tue, 24 Jul 2018 09:15:48 +0800
Message-Id: <20180724011551.49603-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pine H64 has made a new "model B", on which "Euler bus" and "EXP bus"
are dropped, one LED is stripped and the Wi-Fi become an on-board
RTL8723BS.

Add support for this board, with the Wi-Fi support.

Wi-Fi support is also introduced for model A, but disabled.

Icenowy Zheng (3):
  arm64: allwinner: dts: h6: add Pine H64 model B
  arm64: allwinner: dts: h6: add pinmux for MMC1
  arm64: allwinner: dts: h6: add Wi-Fi support for Pine H64 model A/B

 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-h6-pine-h64-model-b.dts  | 28 +++++++++++++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 34 +++++++++++++++++--
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  8 +++++
 4 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts

-- 
2.18.0

