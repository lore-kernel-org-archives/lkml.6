Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbeEBJjm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:39:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48241 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeEBJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:39:40 -0400
From: Colin King <colin.king@canonical.com>
To: Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: fix spelling mistake: "initiailized" -> "initialized"
Date: Wed,  2 May 2018 10:39:37 +0100
Message-Id: <20180502093937.26748-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in ntfs_debug debug message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ntfs/mft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 32c523cf5a2d..8e76f64d9784 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1586,7 +1586,7 @@ static int ntfs_mft_bitmap_extend_initialized_nolock(ntfs_volume *vol)
 	ATTR_RECORD *a;
 	int ret;
 
-	ntfs_debug("Extending mft bitmap initiailized (and data) size.");
+	ntfs_debug("Extending mft bitmap initialized (and data) size.");
 	mft_ni = NTFS_I(vol->mft_ino);
 	mftbmp_vi = vol->mftbmp_ino;
 	mftbmp_ni = NTFS_I(mftbmp_vi);
-- 
2.17.0
