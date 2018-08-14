Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE028C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7B32173D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7B32173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbeHNI5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 04:57:25 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:60107 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbeHNI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 04:57:25 -0400
Received: from droid10.amlogic.com (10.18.11.213) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 14 Aug 2018
 14:11:49 +0800
From:   Hanjie Lin <hanjie.lin@amlogic.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Hanjie Lin <hanjie.lin@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        <shawn.lin@rock-chips.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/2] add the Amlogic Meson PCIe phy driver.
Date:   Tue, 14 Aug 2018 02:12:12 -0400
Message-ID: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.213]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patcheset add the driver and dt-bindings for
the Meson-PCIE-PHY controller.

Yue Wang (2):
  dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe Phy
    controller
  PCI: meson: add the Amlogic Meson PCIe phy driver

 .../bindings/phy/amlogic,meson-pcie-phy.txt        |  31 ++++
 drivers/phy/amlogic/Kconfig                        |   8 ++
 drivers/phy/amlogic/Makefile                       |   1 +
 drivers/phy/amlogic/phy-meson-axg-pcie.c           | 160 +++++++++++++++++++++
 4 files changed, 200 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c

-- 
2.7.4

