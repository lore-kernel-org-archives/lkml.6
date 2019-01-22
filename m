Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0440C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE51D21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfAVNWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:22:12 -0500
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:59196 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728583AbfAVNVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:21:55 -0500
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1glvzx-000IW3-1a; Tue, 22 Jan 2019 14:21:49 +0100
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1glvzw-0001Dy-TG; Tue, 22 Jan 2019 14:21:48 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     marcel.ziswiler@toradex.com, stefan@agner.ch,
        max.krummenacher@toradex.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 0/2] Adding DTS to support STMPE811 ADC on Toradex Boards
Date:   Tue, 22 Jan 2019 14:21:33 +0100
Message-Id: <20190122132135.5012-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Hello,

Recently the STMPE811 driver got pulled by MFD (for 5.1).
This patches I'm sending are now adding support for STMPE811 ADC in
devicetree. These patches have been in the STMPE811 ADC driver patchset
but were not pulled by Lee, as they had no reviews and I also corrected
some minor comment errors.


Philippe Schenker (2):
  ARM: dts: Add stmpe-adc DT node to Toradex iMX6 modules
  ARM: dts: Add stmpe-adc DT node to Toradex T30 modules

 arch/arm/boot/dts/imx6qdl-apalis.dtsi      | 22 ++++++++++++++--------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi     | 22 ++++++++++++++--------
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi | 22 ++++++++++++++--------
 arch/arm/boot/dts/tegra30-apalis.dtsi      | 22 ++++++++++++++--------
 arch/arm/boot/dts/tegra30-colibri.dtsi     | 22 ++++++++++++++--------
 5 files changed, 70 insertions(+), 40 deletions(-)

-- 
2.20.1

