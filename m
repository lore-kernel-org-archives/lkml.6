Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeEQRVt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:21:49 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35209 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeEQRVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:21:47 -0400
X-Google-Smtp-Source: AB8JxZoeJO1yR8PcJtx8qxe79mPnuJjEkazvFbLLpUrj4prfsQJ3X1pbKCkYK4HmhSuhGE0nYQNOzg==
From: Ray Jui <ray.jui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH INTERNAL 0/3] Add Broadcom PAXC related quirks
Date: Thu, 17 May 2018 10:21:29 -0700
Message-Id: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds quirks to work around a few issues related to
certain revisions of Broadcom PAXC based PCIe root complexes

This patch series is based off v4.17-rc5 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-paxc-quirk-v1

Ray Jui (3):
  PCI: iproc: Activate PAXC bridge quirk for more devices
  PCI: iproc: Fix up corrupted PAXC root complex config registers
  PCI: iproc: Disable MSI parsing in certain PAXC blocks

 drivers/pci/host/pcie-iproc.c | 34 ++++++++++++++-
 drivers/pci/quirks.c          | 98 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 2 deletions(-)

-- 
2.1.4
