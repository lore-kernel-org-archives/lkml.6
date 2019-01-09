Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65D3C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D232070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbfAIPDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:03:04 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:55580 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731992AbfAIPDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:03:03 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 468DA5FCC8; Wed,  9 Jan 2019 23:03:00 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/5] ARM: dts: sunxi: Enable Broadcom-based Bluetooth w/ serdev
Date:   Wed,  9 Jan 2019 23:02:52 +0800
Message-Id: <20190109150257.12602-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is the second batch of patches enabling Bluetooth for Broadcom
(AMPAK) modules using the new serdev bindings.

The patches are self-explanatory, so I won't go into the details here.

This pretty much covers all the boards I have that have AMPAK modules.
The only ones missing are the A80-based boards, which I haven't gotten
working yet.

Chen-Yu Tsai (5):
  ARM: dts: sun8i: r40: Add pinmux settings for UART3 on PG pingroup
  ARM: dts: sun8i: r40: Add pinmux setting for CLK_OUT_A
  ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix WiFi regulator
    definitions
  ARM: dts: sun8i: r40: bananapi-m2-ultra: Add Bluetooth device node
  ARM: dts: sunxi: bananapi-m2-plus: Add Bluetooth device node

 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 41 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 15 +++++++
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 16 +++++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.20.1

