Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A72CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25A9217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546121103;
	bh=pIXDuHOshjsbo6JtZDnY9KzoJozQ8GjI2P/1ZeybM9s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OXkL8PISWBVKbRzTf4QKjAsfS4XGKduAw/S62V8hvbcC3gYmSmj7LQs00Prnr0Tbt
	 PuUhv8ClLqoNIjIal4PLzdmxWpUxV1bY25XRLOuWznVJ5L3Vz0kc56SLn9c9BGRwbh
	 DGdBuAh00GqI1yCuMeCo9kzLwrRAPGlA80Lpf4Gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeL2WFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 17:05:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbeL2WFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 17:05:02 -0500
Subject: Re: [GIT PULL 1/4] Kbuild updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546121101;
        bh=pIXDuHOshjsbo6JtZDnY9KzoJozQ8GjI2P/1ZeybM9s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tKGlNat3HipkyJHfhwfL7RpaP58TPL2Nd4WWcYPvC3N6Mx7NVDtl4tBRz8JNTQH9b
         e3YTApeYfvblaYAZwcvoQ5Sn9zbO4RFn3/WZQWeAH3U1XNFWxpxYDGH0k8NGPuYiBP
         nJjcdSAxk/26NLXa2ospnNOUq+nx+vOxljt4Wtkw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQzEHv7Y69xFTPDEhyMP6JX4ghb96UMqMdxYyVyah6-VA@mail.gmail.com>
References: <CAK7LNAQzEHv7Y69xFTPDEhyMP6JX4ghb96UMqMdxYyVyah6-VA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQzEHv7Y69xFTPDEhyMP6JX4ghb96UMqMdxYyVyah6-VA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-v4.21
X-PR-Tracked-Commit-Id: dec28d8ea2f731b7ec68a2c9421e99a165d47b57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 668c35f69cc750aaf07bd5fe7710a47e2aed6e43
Message-Id: <20181229220501.27755.78252.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 22:05:01 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Dec 2018 00:58:38 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/668c35f69cc750aaf07bd5fe7710a47e2aed6e43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
