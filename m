Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F7AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDF6222CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfBMRIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:08:47 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:59439 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfBMRIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:08:46 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gty1Y-00046g-Ce from Akash_Gajjar@mentor.com ; Wed, 13 Feb 2019 09:08:40 -0800
Received: from eyas.local (137.202.0.90) by SVR-IES-MBX-04.mgc.mentorg.com
 (139.181.222.4) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 13 Feb
 2019 17:08:34 +0000
From:   Akash Gajjar <Akash_Gajjar@mentor.com>
To:     <heiko@sntech.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] arm64: dts: rockchip: rk3399-rockpro64 dts cleanup
Date:   Wed, 13 Feb 2019 22:36:36 +0530
Message-ID: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patchset adds below various changes
- rename regulators name according to rockpro64 schematic.
- remove unused pinmux and regulator node
- rename LED name and set heartbeat default-trigger.
- add usb regulator.

schematic is available here:
http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf

Akash Gajjar (4):
  arm64: dts: rockchip: rockpro64 dts make regulator more readable
  arm64: dts: rockchip: rockpro64 dts remove unused node
  arm64: dts: rockchip: rockpro64 dts rename LED labels and default
    trigger
  arm64: dts: rockchip: rockpro64 dts add usb regulator

 .../boot/dts/rockchip/rk3399-rockpro64.dts    | 93 +++++++++----------
 1 file changed, 43 insertions(+), 50 deletions(-)

-- 
2.17.1

