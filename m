Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4F7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BFA20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547573405;
	bh=kZo0tqjNlc0tQq1IS7d9IAsa+sMkcrICOJ8v/o/D7UU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SaZDoQgGDT5B/jgSa1jXwVDLvwbIsY8/4J2zNZSh5D5Kb5zreHoUcpBmyLgZyZeLA
	 98hDPaJKWiFLRydLAD7EXg6e7wvZ3soVV3yLpu5S/IgrpzCwuawXEBMAvs8yi5l40u
	 dz1/NHCz9na579PX9tY8HBzis5Iml6trqanAJ+oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfAORaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbfAORaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:30:03 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547573402;
        bh=kZo0tqjNlc0tQq1IS7d9IAsa+sMkcrICOJ8v/o/D7UU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wMWEdwUyY5kIzOgebSq/yXzsXrmIW2yVrl4uZ4GQp9rD8Dc+zTfOVYs//IwyF6fi5
         5AHcWYOcydOwiu5F7MbjJ8wd1vAB2PpvB3UHTndhxbwqjV5nB5qxO7ATgGElj9IdQu
         PaIiBXd5gxY65APy1TRgxE8m0vg/05eE8HsR2I0I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190113.133346.873105268319400703.davem@davemloft.net>
References: <20190113.133346.873105268319400703.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190113.133346.873105268319400703.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 master
X-PR-Tracked-Commit-Id: 2f960bd0564081ff85d2eea54890b0d2356934f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8746440bf68212f19688f1454dad593c74abee1
Message-Id: <154757340241.2458.14594436318355477581.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Jan 2019 17:30:02 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Jan 2019 13:33:46 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8746440bf68212f19688f1454dad593c74abee1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
