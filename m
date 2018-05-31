Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932598AbeEaAgg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 20:36:36 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34847 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932544AbeEaAge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 20:36:34 -0400
X-Google-Smtp-Source: ADUXVKKetmoeamt++NTvnG638gg9ZnscUv/cPnSG2G5c0wTA5+2MnWUWR2JJyEUDggyRnyM8KM2Uyg==
From: Ray Jui <ray.jui@broadcom.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 0/3] Update Broadcom Stingray clock entries
Date: Wed, 30 May 2018 17:36:17 -0700
Message-Id: <1527726980-11723-1-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series updates Broadcom Stingray clock entries so they match the
latest ASIC datasheet

This patch series is based off v4.17-rc5 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-clk-v2

Changes since v1:
 - Fix patch author to Pramod Kumar on all 3 patches
 - Fix patch subject spelling error on patch 2/3

Pramod Kumar (3):
  dt-bindings: clk: Update Stingray binding doc
  clk: bcm: Update and add Stingray clock entries
  arm64: dts: Update Stingray clock DT nodes

 .../bindings/clock/brcm,iproc-clocks.txt           |  26 ++--
 .../boot/dts/broadcom/stingray/stingray-clock.dtsi |  26 ++--
 drivers/clk/bcm/clk-sr.c                           | 135 ++++++++++++++++++---
 include/dt-bindings/clock/bcm-sr.h                 |  24 ++--
 4 files changed, 170 insertions(+), 41 deletions(-)

-- 
2.1.4
