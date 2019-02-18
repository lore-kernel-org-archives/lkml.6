Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF670C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C1A2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfBRG12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:27:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfBRG11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:27:27 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 068B0C512C2F573CE908;
        Mon, 18 Feb 2019 14:27:26 +0800 (CST)
Received: from PEK1000233773.huawei.com (10.178.175.169) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 14:27:18 +0800
From:   Zeng Guangyue <zengguangyue@hisilicon.com>
To:     <jaegeuk@kernel.org>, <yuchao0@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     <zangleigang@hisilicon.com>, <kid.jin@hisilicon.com>,
        <zengguangyue@hisilicon.com>
Subject: [PATCH] f2fs: correct spelling mistake
Date:   Mon, 18 Feb 2019 14:26:41 +0800
Message-ID: <20190218062641.104401-1-zengguangyue@hisilicon.com>
X-Mailer: git-send-email 2.20.1.309.g16a465bc01
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.178.175.169]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

correct spelling mistake for "nunmber"

Signed-off-by: Zeng Guangyue <zengguangyue@hisilicon.com>
---
 include/linux/f2fs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d7711048ef93..4c25ab97107c 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -284,7 +284,7 @@ enum {
 
 struct node_footer {
 	__le32 nid;		/* node id */
-	__le32 ino;		/* inode nunmber */
+	__le32 ino;		/* inode number */
 	__le32 flag;		/* include cold/fsync/dentry marks and offset */
 	__le64 cp_ver;		/* checkpoint version */
 	__le32 next_blkaddr;	/* next node page block address */
-- 
2.20.1.309.g16a465bc01

