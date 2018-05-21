Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbeEURfS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:35:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35369 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbeEURfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:35:13 -0400
X-Google-Smtp-Source: AB8JxZpTHYEEcYRasF8FdnjvRIWb7OP+6MExqvks1FWpRBx/eHDoLPVKakSZRkHDBeBnzjZhurqpbw==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org, jsimmons@infradead.org,
        andreas.dilger@intel.com, oleg.drokin@intel.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 3/4] staging: lustre: Fix "unsigned"->"unsigned int"
Date: Mon, 21 May 2018 19:34:29 +0200
Message-Id: <20180521173430.9759-3-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180520124408.GA10692@kroah.com>
References: <20180520124408.GA10692@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING:UNSPECIFIED_INT: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 .../staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h
index f5214dc33c60..d375a476f5ea 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h
@@ -51,7 +51,7 @@ static inline size_t fiemap_count_to_size(size_t extent_count)
 				       sizeof(struct fiemap_extent);
 }
 
-static inline unsigned fiemap_size_to_count(size_t array_size)
+static inline unsigned int fiemap_size_to_count(size_t array_size)
 {
 	return (array_size - sizeof(struct fiemap)) /
 		sizeof(struct fiemap_extent);
-- 
2.17.0
