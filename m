Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A665DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C11721529
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C11721529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeHHQTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:19:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33309 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727081AbeHHQTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:19:34 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4BBC871ABF70F;
        Wed,  8 Aug 2018 21:59:39 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Wed, 8 Aug 2018 21:59:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <clm@fb.com>, <jbacik@fb.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCHv3 0/3] change some function to be void function
Date:   Wed, 8 Aug 2018 21:47:52 +0800
Message-ID: <1533736075-8691-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3->v2:
 - Repost the patches with detailed changelog.
v1->v2:
 - Fix v1 issue that forget to return after remove the variable "ret".

zhong jiang (3):
  fs/btrfs/disk-io: change btrfs_destroy_delayed_refs to be void
    function
  fs/btrfs/extent-tree: change btrfs_free_reserved_bytes to be void
    funtion
  fs/btrfs/tree-log: change btrfs_pin_log_trans to be void function

 fs/btrfs/disk-io.c     | 13 +++++--------
 fs/btrfs/extent-tree.c |  6 ++----
 fs/btrfs/tree-log.c    |  5 +----
 fs/btrfs/tree-log.h    |  2 +-
 4 files changed, 9 insertions(+), 17 deletions(-)

-- 
1.7.12.4

