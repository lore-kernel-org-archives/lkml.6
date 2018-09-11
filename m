Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9168C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AA12086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AA12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeIKVxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:53:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56699 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKVxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:53:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fzluX-0006rn-OZ; Tue, 11 Sep 2018 16:53:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: visorbus: fix spelling mistake "partion" -> "partition"
Date:   Tue, 11 Sep 2018 17:53:09 +0100
Message-Id: <20180911165309.1314-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in comment, re-jig comment block
to avoid checkpatch overly wide line warning.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 include/linux/visorbus.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/visorbus.h b/include/linux/visorbus.h
index 0d8bd6769b13..4a6abff20049 100644
--- a/include/linux/visorbus.h
+++ b/include/linux/visorbus.h
@@ -222,9 +222,9 @@ struct visorchipset_state {
  *				hypervisor requests.
  * @vbus_hdr_info:		A pointer to header info. Private use by bus
  *				driver.
- * @partition_guid:		Indicates client partion id. This should be the
- *				same across all visor_devices in the current
- *				guest. Private use by bus driver only.
+ * @partition_guid:		Indicates client partition id. This should be
+ *				the same across all visor_devices in the
+ *				current guest. Private use by bus driver only.
  */
 struct visor_device {
 	struct visorchannel *visorchannel;
-- 
2.17.1

