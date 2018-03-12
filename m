Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeCLJ6c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:58:32 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:40932 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752472AbeCLJ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:58:31 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-m68k@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k/defconfig: Update defconfigs for v4.16-rc5
Date: Mon, 12 Mar 2018 10:58:28 +0100
Message-Id: <1520848708-18066-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be combined with "m68k/defconfig: Update defconfigs for v4.16-rc1".

 arch/m68k/configs/amiga_defconfig    | 1 -
 arch/m68k/configs/apollo_defconfig   | 1 -
 arch/m68k/configs/atari_defconfig    | 1 -
 arch/m68k/configs/bvme6000_defconfig | 1 -
 arch/m68k/configs/hp300_defconfig    | 1 -
 arch/m68k/configs/mac_defconfig      | 1 -
 arch/m68k/configs/multi_defconfig    | 1 -
 arch/m68k/configs/mvme147_defconfig  | 1 -
 arch/m68k/configs/mvme16x_defconfig  | 1 -
 arch/m68k/configs/q40_defconfig      | 1 -
 arch/m68k/configs/sun3_defconfig     | 1 -
 arch/m68k/configs/sun3x_defconfig    | 1 -
 12 files changed, 12 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index e7995c1e534a0b4a..37a8e5ab87285e7d 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -589,7 +589,6 @@ CONFIG_DLM=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_ATOMIC64_SELFTEST=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index dbbdac446b77f3b4..6a466266b852fb77 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -548,7 +548,6 @@ CONFIG_DLM=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_ATOMIC64_SELFTEST=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index ebe626eaf28a311a..c319a7712f736299 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -580,7 +580,6 @@ CONFIG_DLM=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_ATOMIC64_SELFTEST=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 7de712e4d32a547e..6f6470fa9a508552 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -540,7 +540,6 @@ CONFIG_DLM=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_ATOMIC64_SELFTEST=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index d8790a1461946836..31a1a2b5e86031e2 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -550,7 +550,6 @@ CONFIG_DLM=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_ATOMIC64_SELFTEST=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 2f19dff379b9b7ee..390d4a87441c3d11 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -572,7 +572,6 @@ CONFIG_DLM=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_ATOMIC64_SELFTEST=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 49ba135c4dc58144..77be97d82dc378a2 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -652,7 +652,6 @@ CONFIG_DLM=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_ATOMIC64_SELFTEST=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 3eecfaff5e92167a..2ca140757b0fd12d 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -540,7 +540,6 @@ CONFIG_DLM=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_ATOMIC64_SELFTEST=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 5c64b3c93f14f8f9..6a3b4dcc5aab9ca8 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -540,7 +540,6 @@ CONFIG_DLM=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_ATOMIC64_SELFTEST=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 9632ca33d8c8c17f..2a3e29c97652b0cd 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -563,7 +563,6 @@ CONFIG_DLM=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_ATOMIC64_SELFTEST=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index f4fb9f49babe8e08..cba2494c99b2da58 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -542,7 +542,6 @@ CONFIG_DLM=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_ATOMIC64_SELFTEST=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 5dce6f545e5020cd..d911561137fd79d8 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -542,7 +542,6 @@ CONFIG_DLM=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_WW_MUTEX_SELFTEST=m
-CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_SORT=m
 CONFIG_ATOMIC64_SELFTEST=m
-- 
2.7.4
