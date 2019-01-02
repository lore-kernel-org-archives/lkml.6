Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F23C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75801218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546389304;
	bh=4AeYZ+JtnO6gyyT23dJrkIjgkkH/ka92qBUACBMH3mg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uYOIhfLecBkvbfgf3DtWYH55TEJ72g0izui1Mjqc4TyfmzOX4kljqY5VUT3Er+/dX
	 NgbLFfB2thWQqbrquuuuTFXosYCwG7zdupkUmiPJiuXmwjEHVlYHKxRQV2qCXAKb18
	 387E2j5DA2LN7TRbjsfxKK4brGckC0yfv37afC2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfABAfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 19:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbfABAfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 19:35:03 -0500
Subject: Re: [GIT PULL] kgdb changes v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546389302;
        bh=4AeYZ+JtnO6gyyT23dJrkIjgkkH/ka92qBUACBMH3mg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DdVfnd18ZcYllfLx286hJofvxtxe55QgGvxAQa/bYpuD3cDSIokJMS8jM4hg5JQmW
         kWZs8KUa/tspuSAAIh/Xg7jcqUMBCyYJW0N+Ofilj5zVshTFFLNK19vDZmoB3zIuB8
         vaO+pj/pjnIrFuQZghlZXIeMu2BhPRe3KC/WTd6g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181230105131.GA30811@wychelm.lan>
References: <20181230105131.GA30811@wychelm.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181230105131.GA30811@wychelm.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/
 tags/kgdb-4.21-rc1
X-PR-Tracked-Commit-Id: cc0282975b3f887005c380adcf0af95915f0c1bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcf010449ebe1db0cb68b2c6410972a782f2bd14
Message-Id: <20190102003502.1457.12769.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 02 Jan 2019 00:35:02 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Dec 2018 10:51:31 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcf010449ebe1db0cb68b2c6410972a782f2bd14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
