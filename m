Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753888AbeE3QBp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:01:45 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36901 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753757AbeE3QBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:01:43 -0400
X-Google-Smtp-Source: ADUXVKIotNhvgMgNYX3Rmlq5qD4nxX2W6fgE/+VYOFZ2o3SkOgLbFPjXjjlwYaS/+XR/mISnjLRCEYi0ZS9nQbIJZik=
MIME-Version: 1.0
In-Reply-To: <1527582935-31175-1-git-send-email-avifishman70@gmail.com>
References: <1527582935-31175-1-git-send-email-avifishman70@gmail.com>
From: Avi Fishman <avifishman70@gmail.com>
Date: Wed, 30 May 2018 19:01:40 +0300
Message-ID: <CAKKbWA5zu2ty-OapQMiYXWg6wk0UisPq56gow7_1Tti_fg7fkw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] USB host: Add USB ehci support for nuvoton npcm7xx
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stern@rowland.harvard.edu
Cc: Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        mathias.nyman@linux.intel.com, bjorn.andersson@linaro.org,
        jhogan@kernel.org, albeu@free.fr, chunfeng.yun@mediatek.com,
        tony@atomide.com, baolu.lu@linux.intel.com, elder@linaro.org,
        digetx@gmail.com, kstewart@linuxfoundation.org, hdegoede@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>, davem@davemloft.net,
        mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
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
