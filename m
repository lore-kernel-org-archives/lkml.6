Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeC1DB4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 23:01:56 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:62686 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeC1DBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 23:01:55 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Yixun Lan <yixun.lan@amlogic.com>, Carlo Caione <carlo@caione.org>,
        Rob Herring <robh@kernel.org>, Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/3] ARM64: dts: meson-axg: add AO clock driver
Date: Wed, 28 Mar 2018 11:01:27 +0800
Message-ID: <20180328030130.240336-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  These patches try to add AO clock driver for the Amlogic's
AXG SoC, while adding this driver, we found the pclk for uart AO
controller was wrong, so fix it here.
  Note, this patch actually depend on AO clock driver[2]
Please take these patches untill AO clock driver is merged.

changes since v2 at [1]: 
 - previous the DTS patches sit in two seperate series, merge them
   into one patch set.
 
changes since v1 at [0]: 
 -

[0] https://lkml.kernel.org/r/20180209070026.193879-1-yixun.lan@amlogic.com
[1] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan@amlogic.com
  https://lkml.kernel.org/r/20180326081809.49493-4-yixun.lan@amlogic.com
[2] https://lkml.kernel.org/r/20180328025050.221585-1-yixun.lan@amlogic.com


Qiufang Dai (1):
  arm64: dts: meson-axg: add AO clock driver DT info

Yixun Lan (2):
  ARM64: dts: meson-axg: add an 32K alt aoclk
  ARM64: dts: meson: fix clock source of the pclk for UART_AO

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 23 +++++++++++++++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  4 ++--
 3 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.15.1
