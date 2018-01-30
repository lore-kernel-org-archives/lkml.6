Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeA3MbF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:31:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751590AbeA3MbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:31:04 -0500
From: John Garry <john.garry@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] arm64: defconfig: enable IOSCHED_DEADLINE
Date: Tue, 30 Jan 2018 21:22:57 +0800
Message-ID: <1517318577-56430-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For certain workloads the deadline IO scheduler offers
particular advantages over other schedulers and has shown
to perform better, so enable it.

The default IO scheduler is unaffected by this change, and
currently is CFQ.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373..40c72e6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -31,7 +31,6 @@ CONFIG_PROFILING=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_BCM2835=y
-- 
1.9.1
