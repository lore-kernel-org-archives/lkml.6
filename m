Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A3BC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F1A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F1A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeIKOTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:19:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48188 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeIKOTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:19:43 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fzerE-0003BQ-Cd; Tue, 11 Sep 2018 09:21:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hpfs: fix spelling mistake "partion" -> "partition"
Date:   Tue, 11 Sep 2018 10:21:16 +0100
Message-Id: <20180911092116.28449-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in comments

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/hpfs/hpfs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/hpfs/hpfs.h b/fs/hpfs/hpfs.h
index 823a328791c0..302f45101a96 100644
--- a/fs/hpfs/hpfs.h
+++ b/fs/hpfs/hpfs.h
@@ -120,11 +120,11 @@ struct hpfs_spare_block
   u8 bad_sector: 1;			/* bad sector, corrupted disk (???) */
   u8 bad_bitmap: 1;			/* bad bitmap */
   u8 fast: 1;				/* partition was fast formatted */
-  u8 old_wrote: 1;			/* old version wrote to partion */
-  u8 old_wrote_1: 1;			/* old version wrote to partion (?) */
+  u8 old_wrote: 1;			/* old version wrote to partition */
+  u8 old_wrote_1: 1;			/* old version wrote to partition (?) */
 #else
-  u8 old_wrote_1: 1;			/* old version wrote to partion (?) */
-  u8 old_wrote: 1;			/* old version wrote to partion */
+  u8 old_wrote_1: 1;			/* old version wrote to partition (?) */
+  u8 old_wrote: 1;			/* old version wrote to partition */
   u8 fast: 1;				/* partition was fast formatted */
   u8 bad_bitmap: 1;			/* bad bitmap */
   u8 bad_sector: 1;			/* bad sector, corrupted disk (???) */
-- 
2.17.1

