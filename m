Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA8AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A5F2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfAXQf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:35:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:39102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727690AbfAXQf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:35:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC9AAAC86;
        Thu, 24 Jan 2019 16:35:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 66D231E0880; Thu, 24 Jan 2019 17:35:27 +0100 (CET)
Date:   Thu, 24 Jan 2019 17:35:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Inotify fix for v5.0-rc4
Message-ID: <20190124163527.GA10165@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.0-rc4

to get a fix of fd refcount leak in inotify error path.

Top of the tree is 125892edfe69. The full shortlog is:

Tetsuo Handa (1):
      inotify: Fix fd refcount leak in inotify_add_watch().

The diffstat is

 fs/notify/inotify/inotify_user.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

							Thanks
								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
