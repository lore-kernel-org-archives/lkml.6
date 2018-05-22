Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeEVRFZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:05:25 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46055 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbeEVRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:05:24 -0400
X-Google-Smtp-Source: AB8JxZpaR366BKErg5VwaJnuYx5f/u0IQqsLD7TxylvgaAVHvzBeTlO2JoOw3FgJiF5KEcvoiD4boQ==
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 0/2] Improve Broadcom PAXC support
Date: Tue, 22 May 2018 10:05:07 -0700
Message-Id: <1527008709-20786-1-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves the Broadcom PAXC support by adding logic
to reject internally unconfigured physical functions from the embedded
network processor acting as endpoint. A change is also made to reduce
verbose print level in the outbound/inbound mapping code

This patch series is based off v4.17-rc5 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-paxc-v1

Ray Jui (2):
  PCI: iproc: Reject unconfigured physical functions from PAXC
  PCI: iproc: Reduce inbound/outbound mapping print level

 drivers/pci/host/pcie-iproc.c | 60 ++++++++++++++++++++++++++++++-------------
 drivers/pci/host/pcie-iproc.h |  5 ++++
 2 files changed, 47 insertions(+), 18 deletions(-)

-- 
2.1.4
