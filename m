Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeEDBrZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 21:47:25 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:28611 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeEDBrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 21:47:24 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Yixun Lan <yixun.lan@amlogic.com>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] ARM64: dts: meson-axg: enable wifi driver
Date: Fri, 4 May 2018 09:45:31 +0000
Message-ID: <20180504094533.15588-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 These patches try to enable the WIFI module AP6255 in Meson-AXG S400
baord. First patch revert an error which was introduced in early commit.

Hi Kevin
 Please squash patch 1 into the commit[1] of your v4.18/dt64 branch,
which was the error introduced there.

Change since v1 at [2]:
  - fix wrong reset gpio pin

 [1] 7e1eee2ec496 'ARM64: dts: meson-axg: enable the eMMC controller'
 [2] https://lkml.kernel.org/r/20180423145729.14368-1-yixun.lan@amlogic.com

Yixun Lan (2):
  ARM64: dts: meson-axg: drop sdio pwrseq property
  ARM64: dts: meson-axg: enable AP6255 wifi module

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

-- 
2.17.0
