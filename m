Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2256FC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2DD20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2DD20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeILGSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:18:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52267 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbeILGSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:18:32 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D2587119EE298;
        Wed, 12 Sep 2018 09:16:26 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Wed, 12 Sep 2018 09:16:21 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: add SPDX license identifiers
Date:   Wed, 12 Sep 2018 09:16:07 +0800
Message-ID: <20180912011607.62860-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the verbose license text from f2fs files and replace them with
SPDX tags.  This does not change the license of any of the code.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/acl.c           | 5 +----
 fs/f2fs/acl.h           | 5 +----
 fs/f2fs/checkpoint.c    | 5 +----
 fs/f2fs/data.c          | 5 +----
 fs/f2fs/debug.c         | 5 +----
 fs/f2fs/dir.c           | 5 +----
 fs/f2fs/extent_cache.c  | 5 +----
 fs/f2fs/f2fs.h          | 5 +----
 fs/f2fs/file.c          | 5 +----
 fs/f2fs/gc.c            | 5 +----
 fs/f2fs/gc.h            | 5 +----
 fs/f2fs/hash.c          | 5 +----
 fs/f2fs/inline.c        | 4 +---
 fs/f2fs/inode.c         | 5 +----
 fs/f2fs/namei.c         | 5 +----
 fs/f2fs/node.c          | 5 +----
 fs/f2fs/node.h          | 5 +----
 fs/f2fs/recovery.c      | 5 +----
 fs/f2fs/segment.c       | 5 +----
 fs/f2fs/segment.h       | 5 +----
 fs/f2fs/shrinker.c      | 5 +----
 fs/f2fs/super.c         | 5 +----
 fs/f2fs/sysfs.c         | 5 +----
 fs/f2fs/trace.c         | 5 +----
 fs/f2fs/trace.h         | 5 +----
 fs/f2fs/xattr.c         | 5 +----
 fs/f2fs/xattr.h         | 5 +----
 include/linux/f2fs_fs.h | 5 +----
 28 files changed, 28 insertions(+), 111 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 1f35f4e9f0d6..f9a7987ad3a1 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/acl.c
  *
@@ -7,10 +8,6 @@
  * Portions of this code from linux/fs/ext2/acl.c
  *
  * Copyright (C) 2001-2003 Andreas Gruenbacher, <agruen@suse.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/f2fs_fs.h>
 #include "f2fs.h"
diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index 2c685185c24d..b96823c59b15 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/acl.h
  *
@@ -7,10 +8,6 @@
  * Portions of this code from linux/fs/ext2/acl.h
  *
  * Copyright (C) 2001-2003 Andreas Gruenbacher, <agruen@suse.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #ifndef __F2FS_ACL_H__
 #define __F2FS_ACL_H__
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index fb1db60e587d..bd9e20bed6ae 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/checkpoint.c
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/fs.h>
 #include <linux/bio.h>
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 878bf17071f3..9a2a0777a25a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/data.c
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ebe649d9793c..d3c402183e3c 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * f2fs debugging statistics
  *
@@ -5,10 +6,6 @@
  *             http://www.samsung.com/
  * Copyright (c) 2012 Linux Foundation
  * Copyright (c) 2012 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/fs.h>
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index bd0348cc860f..c77a58038709 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/dir.c
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index a70cd2580eae..904ad7ba5a45 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * f2fs extent cache support
  *
@@ -5,10 +6,6 @@
  * Copyright (c) 2015 Samsung Electronics
  * Authors: Jaegeuk Kim <jaegeuk@kernel.org>
  *          Chao Yu <chao2.yu@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/fs.h>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4e4fd5fcaf39..1f9e6171a581 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/f2fs.h
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #ifndef _LINUX_F2FS_H
 #define _LINUX_F2FS_H
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 61f95731c858..357422a4c319 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/file.c
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5c8d00422237..a4c1a419611d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/gc.c
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/fs.h>
 #include <linux/module.h>
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index c8619e408009..bbac9d3787bd 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/gc.h
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #define GC_THREAD_MIN_WB_PAGES		1	/*
 						 * a threshold to determine
diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
index eb2e031ea887..cc82f142f811 100644
--- a/fs/f2fs/hash.c
+++ b/fs/f2fs/hash.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/hash.c
  *
@@ -7,10 +8,6 @@
  * Portions of this code from linux/fs/ext3/hash.c
  *
  * Copyright (C) 2002 by Theodore Ts'o
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/types.h>
 #include <linux/fs.h>
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 115dc219344b..425d740f87fd 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/inline.c
  * Copyright (c) 2013, Intel Corporation
  * Authors: Huajun Li <huajun.li@intel.com>
  *          Haicheng Li <haicheng.li@intel.com>
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/fs.h>
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 959df2249875..86e7333d60c1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/inode.c
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 1f67e389169f..9ad451ac2cec 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/namei.c
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index dd2e45a661aa..fa2381c0bc47 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/node.c
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 0f4db7a61254..1c73d879a9bc 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/node.h
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 /* start node id of a node block dedicated to the given node id */
 #define	START_NID(nid) (((nid) / NAT_ENTRY_PER_BLOCK) * NAT_ENTRY_PER_BLOCK)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 313b6b703d00..8f5b5d07a6c2 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/recovery.c
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 187c848a65b8..9a8d7d415a74 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/segment.c
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b3d9e317ff0c..086150028c6d 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/segment.h
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 36cfd816c160..9e13db994fdf 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * f2fs shrinker support
  *   the basic infra was copied from fs/ubifs/shrinker.c
  *
  * Copyright (c) 2015 Motorola Mobility
  * Copyright (c) 2015 Jaegeuk Kim <jaegeuk@kernel.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c36ebae96c58..73f2cd3a2b39 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/super.c
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 81c0e5337443..c8924c02accd 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * f2fs sysfs interface
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
  * Copyright (c) 2017 Chao Yu <chao@kernel.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/compiler.h>
 #include <linux/proc_fs.h>
diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index a1fcd00bbb2b..ce2a5eb210b6 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * f2fs IO tracer
  *
  * Copyright (c) 2014 Motorola Mobility
  * Copyright (c) 2014 Jaegeuk Kim <jaegeuk@kernel.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
diff --git a/fs/f2fs/trace.h b/fs/f2fs/trace.h
index 67db24ac1e85..e8075fc5b228 100644
--- a/fs/f2fs/trace.h
+++ b/fs/f2fs/trace.h
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * f2fs IO tracer
  *
  * Copyright (c) 2014 Motorola Mobility
  * Copyright (c) 2014 Jaegeuk Kim <jaegeuk@kernel.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #ifndef __F2FS_TRACE_H__
 #define __F2FS_TRACE_H__
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 77a010e625f5..7261245c208d 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/xattr.c
  *
@@ -13,10 +14,6 @@
  *  suggestion of Luka Renko <luka.renko@hermes.si>.
  * xattr consolidation Copyright (c) 2004 James Morris <jmorris@redhat.com>,
  *  Red Hat Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/rwsem.h>
 #include <linux/f2fs_fs.h>
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index dbcd1d16e669..67db134da0f5 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/f2fs/xattr.h
  *
@@ -9,10 +10,6 @@
  * On-disk format of extended attributes for the ext2 filesystem.
  *
  * (C) 2001 Andreas Gruenbacher, <a.gruenbacher@computer.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #ifndef __F2FS_XATTR_H__
 #define __F2FS_XATTR_H__
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 6a879a865343..aaca9f5d5f5c 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * include/linux/f2fs_fs.h
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #ifndef _LINUX_F2FS_FS_H
 #define _LINUX_F2FS_FS_H
-- 
2.18.0.rc1

