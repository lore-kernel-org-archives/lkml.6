Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755947AbeEaRM7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:12:59 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:60793 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755719AbeEaRL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:11:26 -0400
From: Suman Anna <s-anna@ti.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/5] rpmsg: Convert to use SPDX license identifiers
Date: Thu, 31 May 2018 12:10:58 -0500
Message-ID: <20180531171103.8703-1-s-anna@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

The following series switches over the current licensing text in
various rpmsg drivers to the SPDX licensing format. I see that you
have already picked up my series for the HwSpinlock drivers, so this
series does the same for the rpmsg drivers. Please pick these as well
for 4.18. Patches done on top of latest upstream kernel.

regards
Suman

Suman Anna (5):
  rpmsg: Switch to SPDX license identifier
  rpmsg: virtio_rpmsg_bus: Switch to SPDX license identifier
  rpmsg: smd: Switch to SPDX license identifier
  rpmsg: glink: Switch to SPDX license identifier
  rpmsg: char: Switch to SPDX license identifier

 drivers/rpmsg/Kconfig             |  2 ++
 drivers/rpmsg/qcom_glink_native.c | 10 +---------
 drivers/rpmsg/qcom_glink_native.h | 10 +---------
 drivers/rpmsg/qcom_glink_rpm.c    | 10 +---------
 drivers/rpmsg/qcom_glink_smem.c   | 10 +---------
 drivers/rpmsg/qcom_smd.c          | 10 +---------
 drivers/rpmsg/rpmsg_char.c        | 10 +---------
 drivers/rpmsg/rpmsg_core.c        | 10 +---------
 drivers/rpmsg/rpmsg_internal.h    | 10 +---------
 drivers/rpmsg/virtio_rpmsg_bus.c  | 10 +---------
 include/linux/rpmsg.h             | 27 +--------------------------
 include/linux/rpmsg/qcom_glink.h  |  2 ++
 include/uapi/linux/rpmsg.h        |  9 ---------
 13 files changed, 14 insertions(+), 116 deletions(-)

-- 
2.17.0
