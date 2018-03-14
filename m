Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeCNNkg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:40:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbeCNNke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:40:34 -0400
From: John Pittman <jpittman@redhat.com>
To: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org, John Pittman <jpittman@redhat.com>
Subject: [PATCH] scsi: scsi_dh_alua: Correct comment for alua_alloc_pg()
Date: Wed, 14 Mar 2018 09:40:25 -0400
Message-Id: <1521034825-26467-1-git-send-email-jpittman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the comment for function alua_alloc_pg() the argument '@h' is
mistakenly referred to.  Fix this by replacing it with the correct
argument reference, '@tpgs', and provide a short description.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 drivers/scsi/device_handler/scsi_dh_alua.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 4b44325..ab89e42 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -214,8 +214,8 @@ static struct alua_port_group *alua_find_get_pg(char *id_str, size_t id_size,
 /*
  * alua_alloc_pg - Allocate a new port_group structure
  * @sdev: scsi device
- * @h: alua device_handler data
  * @group_id: port group id
+ * @tpgs: target port group settings
  *
  * Allocate a new port_group structure for a given
  * device.
-- 
2.7.5
