Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeEKRDi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:03:38 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:62508 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeEKRDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:03:37 -0400
From: Suman Anna <s-anna@ti.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/6] hwspinlock: Convert to use SPDX license identifiers
Date: Fri, 11 May 2018 12:03:15 -0500
Message-ID: <20180511170321.2452-1-s-anna@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

The following series switches over the current licensing text in
various HwSpinlock drivers to the SPDX licensing format. Please
let me know if you need any changes. If you are ok with the changes,
I will make similar changes to the remoteproc and rpmsg drivers and
post them at the earliest so that they can be picked up for 4.18.

regards
Suman

Suman Anna (6):
  hwspinlock/core: Switch to SPDX license identifier
  hwspinlock/omap: Switch to SPDX license identifier
  hwspinlock: qcom: Switch to SPDX license identifier
  hwspinlock/sirf: Switch to SPDX license identifier
  hwspinlock/u8500: Switch to SPDX license identifier
  hwspinlock: sprd: Switch to SPDX license identifier

 drivers/hwspinlock/Kconfig               |  1 +
 drivers/hwspinlock/hwspinlock_core.c     | 10 +---------
 drivers/hwspinlock/hwspinlock_internal.h | 10 +---------
 drivers/hwspinlock/omap_hwspinlock.c     | 10 +---------
 drivers/hwspinlock/qcom_hwspinlock.c     | 10 +---------
 drivers/hwspinlock/sirf_hwspinlock.c     |  3 +--
 drivers/hwspinlock/sprd_hwspinlock.c     | 10 +---------
 drivers/hwspinlock/u8500_hsem.c          | 10 +---------
 include/linux/hwspinlock.h               | 10 +---------
 9 files changed, 9 insertions(+), 65 deletions(-)

-- 
2.17.0
