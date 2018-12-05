Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8329220879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544034026;
	bh=DdFOXFCd4hv2mRjj/Awx9NVpOh+sjYRQ+XlG5uw3jlg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qvCLiR9M8LzeRML9qyQbRnv6mrpvtBk8+KHPx5Akxgt8WhV7TqVx0+xyTRGlcy/sr
	 ROZF4Aof4laTeS+oVox+mmfDX/yVHlRD2KLT64McIbjJqGoR8uuVKpcsJV7/XucwtS
	 QAAg3c30KfFHs5PQZGsBcVxFVZqPdRFf9S69bNHU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8329220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeLESUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbeLESUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:20:03 -0500
Subject: Re: [GIT PULL] parisc architecture fix for kernel v4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544034002;
        bh=DdFOXFCd4hv2mRjj/Awx9NVpOh+sjYRQ+XlG5uw3jlg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SM3bgLqj4f/X8GaDLWnHwQMuoYXO5gF7stnYSGZQqQsP49Mt+vyE3bK+L7i+yHGQh
         tFdB+ucMjr3oERvsgVZSk25xub8+Pf53sdEjYM/u2ARvwF7haLsHOOPkbvVICAviNv
         nYx1ntYcfg/Ul9P+HlhcfMOwrccEReCXHmHVYNdU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181204150032.GA29884@ls3530.dellerweb.de>
References: <20181204150032.GA29884@ls3530.dellerweb.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181204150032.GA29884@ls3530.dellerweb.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-4.20-4
X-PR-Tracked-Commit-Id: 1e8249b8a4e960018e4baca6b523b8a4500af600
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a517af52cb57f972cee2378765e1c5dd10141f0d
Message-Id: <20181205182002.5826.67607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 05 Dec 2018 18:20:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Dec 2018 16:00:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.20-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a517af52cb57f972cee2378765e1c5dd10141f0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
