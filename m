Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251D7C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C9E218A6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549069206;
	bh=kWx3H46x+a2sypWT7SQYH7Di+jYJ/SYlWrlOxP2B0So=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PsTi9ACs3MkMO24iPgZqT3eRItqf0qBFGkr3/OO/TalcAT6+MTH/O1mHUjb1AAfF/
	 qbzz4gwO6//Fxm9kEXV4b4kYFRt1aaNfIqLTWqtg9YjkGBYMrGzc13xXRm1culJciP
	 f4Swo1WV3vY5t/Inj4KYIM/hPF6kUtHYMPQzOe8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfBBBAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:00:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfBBBAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:00:04 -0500
Subject: Re: [GIT PULL] apparmor fixes for 5.0-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549069203;
        bh=kWx3H46x+a2sypWT7SQYH7Di+jYJ/SYlWrlOxP2B0So=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rycokkUZIXEldfGucosvkKLz4nOccUeWr8Lr7+m15F/JlScFzItyY0jAu7H6C1qXC
         H3/tzXI3ZUmH96uWRL1DwlGePujp0XZIE3ejUAOm03y8QnGTCVoANquFYeZLovJGYp
         UFCQLa2HYF+InBGFjwAPNQlQP+0gcKpgc+UjCW7E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <86698171-0e86-bfee-741f-7fdb33015bd0@canonical.com>
References: <86698171-0e86-bfee-741f-7fdb33015bd0@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <86698171-0e86-bfee-741f-7fdb33015bd0@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
 tags/apparmor-pr-2019-02-01
X-PR-Tracked-Commit-Id: d6d478aee003e19ef90321176552a8ad2929a47f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7bd29b530b9e8c0456ef703e64e773830185724
Message-Id: <154906920373.30832.18171149622500012699.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Feb 2019 01:00:03 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Feb 2019 08:28:14 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2019-02-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7bd29b530b9e8c0456ef703e64e773830185724

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
