Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C052C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E16320870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfAVF0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:26:38 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:38686 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVF0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:26:38 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43kH302yZ4z1qvCY;
        Tue, 22 Jan 2019 06:26:36 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43kH302gYfz1qqkg;
        Tue, 22 Jan 2019 06:26:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id UULMISGJVZdX; Tue, 22 Jan 2019 06:26:35 +0100 (CET)
X-Auth-Info: SOuLqJEXdl99UU2ut3HRh9RTIVAcbLZpdmP7MkbbOoQ=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 22 Jan 2019 06:26:35 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 420F6180759;
        Tue, 22 Jan 2019 06:26:25 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 11A6A37A6; Tue, 22 Jan 2019 06:26:24 +0100 (CET)
From:   Heiko Schocher <hs@denx.de>
To:     devicetree@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/2] ARM: dts: am335x-shc.dts: small updates for shc board
Date:   Tue, 22 Jan 2019 06:26:21 +0100
Message-Id: <20190122052623.1779840-1-hs@denx.de>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

small updates for am335x based shc board:
- switch DTS to SPDX identifier
- fix wrong gpio level for mmc1 cd pin


Heiko Schocher (2):
  ARM: dts: am335x-shc.dts: Switch to SPDX identifier
  ARM: dts: am335x-shc.dts: fix wrong cd pin level

 arch/arm/boot/dts/am335x-shc.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.17.2

