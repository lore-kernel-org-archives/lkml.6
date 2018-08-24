Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50AAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFCF2157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFCF2157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeHXKcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:32:31 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:51232 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbeHXKcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:32:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id C5F7D180210FD;
        Fri, 24 Aug 2018 08:59:13 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] ubifs: Remove empty file.h
Date:   Fri, 24 Aug 2018 08:59:05 +0200
Message-Id: <20180824065905.30492-1-richard@nod.at>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This empty file sneaked into the tree by mistake.
Remove it.

Fixes: 6eb61d587f45 ("ubifs: Pass struct ubifs_info to ubifs_assert()")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/file.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 fs/ubifs/file.h

diff --git a/fs/ubifs/file.h b/fs/ubifs/file.h
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.18.0

