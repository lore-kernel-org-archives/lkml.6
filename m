Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbeE2JOe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:14:34 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:32903 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932711AbeE2JO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:14:27 -0400
From: avifishman70@gmail.com
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        mathias.nyman@linux.intel.com, bjorn.andersson@linaro.org,
        jhogan@kernel.org, albeu@free.fr, chunfeng.yun@mediatek.com,
        tony@atomide.com, baolu.lu@linux.intel.com, elder@linaro.org,
        digetx@gmail.com, kstewart@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, davem@davemloft.net,
        mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        rdunlap@infradead.org, Avi Fishman <AviFishman70@gmail.com>
Subject: [PATCH v1 0/3] USB host: Add USB ehci support for nuvoton npcm7xx
Date: Tue, 29 May 2018 11:35:32 +0300
Message-Id: <1527582935-31175-1-git-send-email-avifishman70@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Fishman <AviFishman70@gmail.com>

This patch adds support for ehci controller for the Nuvoton npcm7xx platform.
Most of the code was taken from ehci-spear.c + specific initialization code

Avi Fishman (3):
  USB host: Add USB ehci support for nuvoton npcm7xx platform
  USB: DT probing support to ehci-npcm7xx
  MAINTAINERS: add subfolders for nuvoton *npcm*

 .../devicetree/bindings/usb/npcm7xx-usb.txt        |  18 ++
 MAINTAINERS                                        |   3 +
 drivers/usb/host/Kconfig                           |   8 +
 drivers/usb/host/Makefile                          |   1 +
 drivers/usb/host/ehci-npcm7xx.c                    | 212 +++++++++++++++++++++
 5 files changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
 create mode 100644 drivers/usb/host/ehci-npcm7xx.c

-- 
2.14.1
