Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA00FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C12B21473
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C12B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeK2WFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:05:16 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:56476 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeK2WFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:05:16 -0500
Received: from droid15-sz.amlogic.com (10.28.8.25) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 29 Nov 2018
 19:00:28 +0800
From:   Jian Hu <jian.hu@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/2] i2c: meson: add support for Meson G12A SoC i2c controller
Date:   Thu, 29 Nov 2018 18:59:54 +0800
Message-ID: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1)Add G12A SoC i2c compatible string in dt-bindings.
2)Add compatible and data for G12A I2C controller driver.

Jian Hu (2):
  dt-bindings: i2c: meson: add Meson G12A SoC i2c compatible string
  i2c: meson: add support for Meson G12A SoC I2C controller

 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
 drivers/i2c/busses/i2c-meson.c                      | 5 +++++
 2 files changed, 6 insertions(+)

-- 
1.9.1

