Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeEKWDE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 18:03:04 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40168 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeEKWDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 18:03:03 -0400
X-Google-Smtp-Source: AB8JxZoeGp9b+UEDx0ALW1hcb02V0ntZ9gyQafsQiEnkxvFCQfqXALkQ1FbSMTf3g3bYEqRco/AyDA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        Doug Berger <opendmb@gmail.com>, Justin Chen <justinpopo6@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] soc: bcm: brcmstb: Updates to support newer controllers
Date: Fri, 11 May 2018 15:02:40 -0700
Message-Id: <20180511220242.837-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series adds support for newer reveisions of the memory controller
which is necessary to make sure we do use the right programming sequence to
enter S2 and S3 suspend/resume modes.

Doug Berger (1):
  soc: bcm: brcmstb: pm: Add support for newer rev B3.0 controllers

Florian Fainelli (1):
  soc: bcm: brcmstb: Add missing DDR MEMC compatible strings

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt         |  4 ++++
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                      | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.14.1
