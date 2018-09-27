Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F20DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC00216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC00216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeI1BoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:44:07 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:41229 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeI1BoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:44:07 -0400
X-IronPort-AV: E=Sophos;i="5.54,311,1534834800"; 
   d="scan'208";a="20642242"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Sep 2018 12:24:18 -0700
Received: from validation1-HP-EliteBook-8540p.mchp-main.com (10.10.76.4) by
 chn-sv-exch04.mchp-main.com (10.10.76.105) with Microsoft SMTP Server id
 14.3.352.0; Thu, 27 Sep 2018 12:24:18 -0700
From:   Yuiko Oshino <yuiko.oshino@microchip.com>
To:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <f.fainelli@gmail.com>,
        <andrew@lunn.ch>
CC:     <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <m.felsch@pengutronix.de>, <Markus.Niebel@tqs.de>,
        <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH v2 net-next 0/2]  Add support for Microchip Technology KSZ9131 10/100/1000 Ethernet PHY
Date:   Thu, 27 Sep 2018 16:15:44 -0400
Message-ID: <1538079344-6152-1-git-send-email-yuiko.oshino@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the initial driver for Microchip KSZ9131 10/100/1000 Ethernet PHY

v2:
- Creating a series from two related patches.

Yuiko Oshino (2):
  net: phy: micrel: add Microchip KSZ9131 inital driver
  dt-bindings: net: add support for Microchip KSZ9131 Ethernet PHY

 .../devicetree/bindings/net/micrel-ksz90x1.txt     | 29 +++++++++++++++++++-
 drivers/net/phy/micrel.c                           | 32 ++++++++++++++++++++--
 include/linux/micrel_phy.h                         |  1 +
 3 files changed, 58 insertions(+), 4 deletions(-)

-- 
2.7.4

