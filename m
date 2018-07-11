Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EEEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275D920652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275D920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbeGKN2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:28:44 -0400
Received: from hermes.aosc.io ([199.195.250.187]:56080 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387881AbeGKN2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:28:39 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id F3F8864316;
        Wed, 11 Jul 2018 13:24:08 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/2] Misc function enhance to Banana Pi M2 Zero board
Date:   Wed, 11 Jul 2018 21:22:31 +0800
Message-Id: <20180711132233.42301-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds two device-tree based function enhancements to the
Banana Pi M2 Zero board.

PATCH 1 adds the HDMI output. (Note: although the connector type is set
to "c" in the device tree, currently sun8i-dw-hdmi doesn't check it and
still set the type to HDMI-A).

PATCH 2 adds VDD-CPUX regulator, and link it to DVFS.

Icenowy Zheng (2):
  ARM: sun8i: h3: enable HDMI output on Banana Pi M2 Zero
  ARM: sun8i: h3: add SY8113B regulator on Banana Pi M2 Zero board

 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

-- 
2.17.1

