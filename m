Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C80FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 22:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E1F20850
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 22:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547419806;
	bh=f/MYeKrdd+LTFEKujv03Q0Aikv5tejg9xoutEqZs9ng=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1NMWEb1+E11P1/iCC7KEQjEujOzNUswy8gzEMg3NPGQtapbDPjTJOEX1ArFXl4rVe
	 WM/xXHj+7R5yVsksmrJPYFZ4JLYDZz1U1UZYYiBIkVqZpGcp5jRpKh0C5k2APyy7py
	 m39qy/dwoToNiZHesBLH4taI8motKs3jt9W8X1G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfAMWuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 17:50:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfAMWuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 17:50:02 -0500
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547419802;
        bh=f/MYeKrdd+LTFEKujv03Q0Aikv5tejg9xoutEqZs9ng=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xn3XtRStWn9vmV9caNYZiWqCHKwK481I6ETeedrsGj7PWK04O8EW/q6PWsgvo7618
         lIEDCLN1eY86OneHnIovG/vnje3irBavd45gfvTvommMqzcZSgIT8VvbU8EFqxgzcm
         WjsybrZbTHtwj0CS+4ARFP2lhKzKRdXxWTENuAPg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190113184825.ogv3cmshi63hxlgj@localhost>
References: <20190113184825.ogv3cmshi63hxlgj@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190113184825.ogv3cmshi63hxlgj@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
 tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 465612178b44840b2066e62c3bcfae80862011d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbc3c09b819f2bd42460b148e55ac5a9d83aaeaf
Message-Id: <154741980194.4214.897523899342173742.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Jan 2019 22:50:01 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Jan 2019 10:48:25 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbc3c09b819f2bd42460b148e55ac5a9d83aaeaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
