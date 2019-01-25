Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F91C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA32520844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458417;
	bh=+AYF21v0BQrdahCcWyulloM3ISiWEJGLakP4/CmI8zQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Clt9h2veul0AkEVesSb+QzNxG1UDH3Ux4SuctA1dRSEy/Dcy2+6smesWEF/dv0cSC
	 TCm+SIfuNQKD47guGtKvte+zFDIxvjtMd2qjaVB6YD0+fRd7RSUKQZy5fHPNmnAY5m
	 rmiXNYrs71ipIbr6ILwY3wbAxHdx2pE46G5H/6hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfAYXUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730060AbfAYXUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:20:06 -0500
Subject: Re: [GIT PULL] MMC fixes for v5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458406;
        bh=+AYF21v0BQrdahCcWyulloM3ISiWEJGLakP4/CmI8zQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j4AJB8yPj+J3+U8STHFcy6hfRtU0EEaNzWdNrRe7cCqma+ZBIl97voMwSya1otZX0
         orW/d+SjVgZRCiZjE3zT5+0ZR1EGi+Ym2IB2ZsIqYs4lsUS9RMaJVY2yKKAKt8X+OT
         7v6Rx/JwE0297a7HbRFp2UTyF30EwdQaxSOxvxVc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190125135043.22286-1-ulf.hansson@linaro.org>
References: <20190125135043.22286-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190125135043.22286-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc2
X-PR-Tracked-Commit-Id: f3716b8ae9347797b73896725f192c3a7b0069b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba606975938179b1e893e44e190d0001de8e5262
Message-Id: <154845840612.30665.3305176793326452490.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Jan 2019 23:20:06 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jan 2019 14:50:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba606975938179b1e893e44e190d0001de8e5262

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
