Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeCMItQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:49:16 -0400
Received: from exmail.andestech.com ([59.124.169.137]:59226 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeCMIsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:48:39 -0400
From: Zong Li <zong@andestech.com>
To: <palmer@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong@andestech.com>, <zongbox@gmail.com>
CC: <greentime@andestech.com>
Subject: [PATCH 10/11] RISC-V: Enable module support in defconfig
Date: Tue, 13 Mar 2018 16:35:15 +0800
Message-ID: <c462c00dd7f259bff0c9540bf57aa067e2d39974.1520928420.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520928420.git.zong@andestech.com>
References: <cover.1520928420.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2D8Xk2U025163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 92ff23586c11..07326466871b 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -74,3 +74,5 @@ CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 # CONFIG_RCU_TRACE is not set
 CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
-- 
2.16.1
