Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2D0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C65A2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547789708;
	bh=dQt5zEWwA6J5XOwl1XHffbOD7E83CZeI+vu8q8NYu9s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lmpLmoFMeXVYtC0LhA7v5FvuxKYS9S99Eyej086cWfxvm24blBKirjD/5ByeI4SCg
	 kJdDni3lL00l3fCM/6hR5qFAStywaAmP06STs5d57cBOBJp6XP/QNSwVO6xsED72FD
	 Ke+K+XIRQwBPtp43t3tivcdv7W4aK+S66scr/na8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfARFfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbfARFfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:35:02 -0500
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547789702;
        bh=dQt5zEWwA6J5XOwl1XHffbOD7E83CZeI+vu8q8NYu9s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qbXj64ijMZlpWvjWsq4xvOS0bf+16BGjBdCcgYqqFkeNSift/uel7VJEcmLDGCaRP
         Czbf/U7FwsNSYuf7ySxVcKtdCbpJFRlS593nCufVnnMvMa3jaAZ8YjeM1QfuHvKTOF
         sx1F8Z2pr+X032NR9VcGaoM78L13gaQ7c4CgmIYI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190118035637.GA19600@ziepe.ca>
References: <20190118035637.GA19600@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190118035637.GA19600@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: d6f4a21f309dfe10a5693ad236358dd6fcc46f7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7393226d15add056285c8fc86723d54d7e0c77d
Message-Id: <154778970212.389.14339322718283306779.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jan 2019 05:35:02 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Jan 2019 03:56:44 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7393226d15add056285c8fc86723d54d7e0c77d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
