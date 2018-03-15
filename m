Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCOIwT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:52:19 -0400
Received: from exmail.andestech.com ([59.124.169.137]:15464 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeCOIwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:52:16 -0400
From: Zong Li <zong@andestech.com>
To: <palmer@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong@andestech.com>, <zongbox@gmail.com>
CC: <greentime@andestech.com>
Subject: [PATCH v2 10/11] RISC-V: Enable module support in defconfig
Date: Thu, 15 Mar 2018 16:50:50 +0800
Message-ID: <9186b00165d84ee282f7387cfa27fe23b82e0590.1521103174.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1521103167.git.zong@andestech.com>
References: <cover.1521103167.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2F8mHNM081100
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
