Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeFCNXN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 09:23:13 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40296 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeFCNXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 09:23:12 -0400
X-Google-Smtp-Source: ADUXVKKXcC1bznvV7ROgI7VxNchJryVc5m9Vt2YlDu/bcS1sBsBrfYn69ZQ05bEmGjFrdf9JN+b4iw==
From: Varsha Rao <rvarsha016@gmail.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH 3/3] message: fusion: Fix line over 80 characters
Date: Sun,  3 Jun 2018 18:52:57 +0530
Message-Id: <ae9327e821e82a9c9e6a41c1fa12ec02496189f2.1528031458.git.rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1528031458.git.rvarsha016@gmail.com>
References: <cover.1528031458.git.rvarsha016@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line over 80 characters is split to fix the following checkpatch issue:

WARNING: line over 80 characters

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 drivers/message/fusion/mptbase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 2e5e5487f193..49e5d1ae9ea9 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -5690,7 +5690,8 @@ mpt_inactive_raid_volumes(MPT_ADAPTER *ioc, u8 channel, u8 id)
 		    buffer->PhysDisk[i].PhysDiskNum, &phys_disk) != 0)
 			continue;
 
-		if (!(component_info = kmalloc(sizeof(*component_info), GFP_KERNEL)))
+		if (!(component_info = kmalloc(sizeof(*component_info),
+		      GFP_KERNEL)))
 			continue;
 
 		component_info->volumeID = id;
-- 
2.17.0
