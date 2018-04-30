Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeD3PTY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:19:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54116 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752534AbeD3PTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:19:22 -0400
From: John Garry <john.garry@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/3] arm64: defconfig: Enable HISILICON_LPC
Date: Mon, 30 Apr 2018 23:15:40 +0800
Message-ID: <1525101342-27120-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
References: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver has been merged for the HiSilicon
LPC host, enable the relevant config.

Turning on this config will also enable config
INDIRECT_PIO, which would have not been enabled
previously - see config info for more details.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0d8ae1d..c959bc8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -171,6 +171,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
+CONFIG_HISILICON_LPC=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
-- 
1.9.1
