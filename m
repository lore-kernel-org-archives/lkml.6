Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeE1Fll (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:41:41 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42069 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753140AbeE1Flj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:41:39 -0400
X-Google-Smtp-Source: ADUXVKJxwHMQUOtKfbF0ncOb9AWxJZLTANEn/LtpvkAfzMbapSTz4yyVqopFA0M/IaIZU4u8PHPhFQ==
From: Srinath Mannam <srinath.mannam@broadcom.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 0/3] Stingray thermal driver support
Date: Mon, 28 May 2018 11:11:21 +0530
Message-Id: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches adds the stingray thermal driver and its
corresponding DT nodes with documentation.

Pramod Kumar (3):
  dt-bindings: thermal: Add binding document for SR thermal
  arm64: dts: stingray: Add Stingray Thermal DT support.
  thermal: broadcom: Add Stingray thermal driver

 .../bindings/thermal/brcm,sr-thermal.txt           |  45 ++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  37 +++++
 drivers/thermal/Kconfig                            |   3 +-
 drivers/thermal/broadcom/Kconfig                   |   9 ++
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/sr-thermal.c              | 151 +++++++++++++++++++++
 6 files changed, 245 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
 create mode 100644 drivers/thermal/broadcom/sr-thermal.c

-- 
2.7.4
