Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeDDDO7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 23:14:59 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32893 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbeDDDO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 23:14:58 -0400
X-Google-Smtp-Source: AIpwx48wK3JWS1ZrEUJWRSWenC/FCzvcgQOMZBzyXj2CCD0sgm/SM+YmP2OR/MPIqmsYpv8CeqOSRw==
From: Leo Yan <leo.yan@linaro.org>
To: Wei Xu <xuwei5@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Leo Yan <leo.yan@linaro.org>, Kaihua Zhong <zhongkaihua@huawei.com>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: [PATCH 0/5] Hi3660: enable power management features
Date: Wed,  4 Apr 2018 11:14:30 +0800
Message-Id: <1522811675-12741-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since hi3660 drivers have been merged into Linux kernel (mailbox driver is in
Linux-next branch and other drivers are existed in Linux mainline kernel), so
this patch series is to enable power management features on hi3660.

This patch series includes device tree binding for mailbox, stub clock and CPU
OPPs, and has one patch to consolidate the Kconfigs for driver modules.

This patch set have been tested on Hikey960 and also verified the patch 'hisi:
Consolidate the Kconfigs for the CLOCK_STUB and the MAILBOX' for Hikey620.


Daniel Lezcano (1):
  hisi: Consolidate the Kconfigs for the CLOCK_STUB and the MAILBOX

Kaihua Zhong (2):
  dts: arm64: hi3660: Add mailbox node
  dts: arm64: hi3660: Add stub clock node

Leo Yan (1):
  dts: arm64: hi3660: Add CPU frequency scaling support

Tao Wang (1):
  dts: arm64: hi3660: Add thermal cooling management

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 145 ++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig              |   1 -
 drivers/clk/hisilicon/Kconfig             |  13 +--
 drivers/mailbox/Kconfig                   |  12 ++-
 4 files changed, 161 insertions(+), 10 deletions(-)

-- 
1.9.1
