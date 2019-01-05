Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEEDC43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55D72232C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546719625;
	bh=qsFgg6Q5ZEE8oGeGX73oGyL9bZVZK/WSIT9iakGREKU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ILawiTnh9iPd41kFzveRnRSrL/a8IHubygFiLnBr3gKO3h4CinbuOw6gvbLmwseiJ
	 6IbRLHKdHvt+XLMwePD9MwtmTF98LYk6MCjuaWNCt3jACa1hcUqXD5ZyknWgXrorjv
	 fuUO9ZEMGOfKt1yV1OizOf/Dr29FyiMHfDQycnDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfAEUUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfAEUUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:20:17 -0500
Subject: Re: [GIT PULL] arch/h8300 update
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546719617;
        bh=qsFgg6Q5ZEE8oGeGX73oGyL9bZVZK/WSIT9iakGREKU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A+Ceq7UlFnITyiwnR+KStM11wsoO6blVbr57I0gV5hBFYokgBdwuuzUtmGMrXDv9I
         uBrpldDgLdWtJJ36ymIH7p95CM4dxqJZ/M7Iwobkp7XlwUx53gZ/ydGMyFDMtJY3Qb
         g2ncs8olEMYBpgxpSocbs0CzZ4TzKWRuEr9uGkMc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878szzla6t.wl-ysato@users.sourceforge.jp>
References: <878szzla6t.wl-ysato@users.sourceforge.jp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878szzla6t.wl-ysato@users.sourceforge.jp>
X-PR-Tracked-Remote: git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git
 tags/for-4.21
X-PR-Tracked-Commit-Id: 21c7acc439b55d0569d7c2fc2eea5194b3910406
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 670b321f4150bfc8a2261f4db3fcdab21738506b
Message-Id: <20190105202017.12651.93182.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 05 Jan 2019 20:20:17 +0000
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 05 Jan 2019 18:34:34 +0900:

> git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git tags/for-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/670b321f4150bfc8a2261f4db3fcdab21738506b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
