Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeEPSXv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:23:51 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39735 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeEPSXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:23:50 -0400
X-Google-Smtp-Source: AB8JxZp0ScCLFR+4Jck5N6RaB4/KRevBAYRpl94M6RAe7ld6b3G1NHo5AFvPYyJwbEgCX3K3b8EVRg==
From: Ray Jui <ray.jui@broadcom.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 0/2] Add Broadcom Stingray PCIe PHY support
Date: Wed, 16 May 2018 11:23:28 -0700
Message-Id: <1526495010-2478-1-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds PCIe PHY support for both PAXB and PAXC root complex in
Broadcom Stingray SOC

This patch series is based off v4.17-rc5 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-pcie-phy-v1

Ray Jui (2):
  dt-bindings: phy: Add binding doc for Stingray PCIe PHY
  phy: bcm-sr-pcie: Add Stingray PCIe PHY driver

 .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   |  39 +++
 drivers/phy/broadcom/Kconfig                       |  10 +
 drivers/phy/broadcom/Makefile                      |   2 +
 drivers/phy/broadcom/phy-bcm-sr-pcie.c             | 306 +++++++++++++++++++++
 4 files changed, 357 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-pcie.c

-- 
2.1.4
