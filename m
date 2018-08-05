Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84831C46473
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F7C21885
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F7C21885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbeHERTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 13:19:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbeHERTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 13:19:30 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C22EE4D8885F3;
        Sun,  5 Aug 2018 23:14:32 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Sun, 5 Aug 2018 23:14:30 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <clm@fb.com>, <jbacik@fb.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Remove uneeded variable "err"
Date:   Sun, 5 Aug 2018 23:02:48 +0800
Message-ID: <1533481371-21349-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


zhong jiang (3):
  fs/btrfs/disk-io: Remove unneeded variable "err"
  fs/btrfs/extent-tree: remove redudant variable "err"
  fs/btrfs/tree-log: remove the unneeded variable "err"

 fs/btrfs/disk-io.c     | 12 ++++--------
 fs/btrfs/extent-tree.c |  6 ++----
 fs/btrfs/tree-log.c    |  5 +----
 fs/btrfs/tree-log.h    |  2 +-
 4 files changed, 8 insertions(+), 17 deletions(-)

-- 
1.7.12.4

