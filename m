Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753087AbeCTMXx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:23:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751084AbeCTMXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:23:51 -0400
To: <xuwei5@hisilicon.com>
CC: <arnd@arndb.de>, <james.morse@arm.com>, <tbaicar@codeaurora.org>,
        <gengdongjiu@huawei.com>, <xiexiuqi@huawei.com>,
        <zhengqiang10@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
From: Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH]arm64:defconfig:enable ACPI_APEI_SEA
Message-ID: <aa732187-e12a-68e5-d15e-84090855d2c5@huawei.com>
Date: Tue, 20 Mar 2018 12:23:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.52]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ACPI APEI SEA option for arm64, to handle
ARMv8 SEA(Synchronous External Abort).

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: James Morse <james.morse@arm.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Xie XiuQi <xiexiuqi@huawei.com>
Cc: Qiang Zheng <zhengqiang10@huawei.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373..5ddf25c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -574,6 +574,7 @@ CONFIG_ACPI_APEI_GHES=y
 CONFIG_ACPI_APEI_PCIEAER=y
 CONFIG_ACPI_APEI_MEMORY_FAILURE=y
 CONFIG_ACPI_APEI_EINJ=y
+CONFIG_ACPI_APEI_SEA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
1.9.1
