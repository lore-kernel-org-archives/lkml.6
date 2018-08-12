Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8CDC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74E5218CD
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74E5218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeHMBiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 21:38:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34846 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeHMBiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 21:38:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fozJs-0002Pf-DR; Sun, 12 Aug 2018 22:58:44 +0000
Date:   Sun, 12 Aug 2018 23:58:44 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git - misc stuff
Message-ID: <20180812225844.GQ6515@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

misc cleanups from various folks all over the place

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 7964410fcf135d7e76deef4e475816ec02482f7b:

  fs: dcache: Use true and false for boolean values (2018-08-05 15:52:44 -0400)

----------------------------------------------------------------
Al Viro (1):
      fold generic_readlink() into its only caller

Amir Goldstein (1):
      fs: shave 8 bytes off of struct inode

Gustavo A. R. Silva (1):
      fs: dcache: Use true and false for boolean values

Matthew Wilcox (2):
      fs: Fix attr.c kernel-doc
      fs: Add more kernel-doc to the produced documentation

Vasily Averin (1):
      removed extra extern file_fdatawait_range

 Documentation/filesystems/index.rst | 33 +++++++++++++++++++++++++++++++++
 fs/attr.c                           |  5 +++--
 fs/dcache.c                         | 12 ++++++------
 fs/namei.c                          | 36 ++++++++++++------------------------
 include/linux/fs.h                  |  7 +++----
 5 files changed, 57 insertions(+), 36 deletions(-)
