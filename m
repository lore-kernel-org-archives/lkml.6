Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30DBC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF8E20873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546121114;
	bh=epzUwYsXx/yC83ZQ6jJUpReZE5pJxDTOAfVM7W2LZoo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=r3+Ylr8spI69akXFHltm8o92JkGJqpiz1e+Nghh+t9HryWrk1ua7+5+A4kcfQHI+T
	 4puwGkyye/5kLDEVcgrH9T/xGFVYR5ICtoUe/bgxO6F9twFiwHXCv6lV5ulStBOd/F
	 VuhZF3eAd5aM9CnvnreOLNNKV5/1JXlo/ARC2k4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeL2WFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 17:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbeL2WFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 17:05:02 -0500
Subject: Re: [GIT PULL 3/4] Kconfig updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546121102;
        bh=epzUwYsXx/yC83ZQ6jJUpReZE5pJxDTOAfVM7W2LZoo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=scc03de23naodGJ2HKIawRpZsp812xtpDqtbSoQsr9ta7fw424rQ0+9Xwn9fUHwqc
         R19K4EDwXqwiI9hSjv/pX13DkGqbqig8P2djnpkzQMeBCS7NDy+PEOQTw2HzcWdZPU
         RjNXdGLUbT7rtbJzUkImgBrbtXrTY7KfxSyKyRdE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNASuG-TiivGrJ17jY_mTPT1SaZQw4DaCRY+49deF49ZaEQ@mail.gmail.com>
References: <CAK7LNASuG-TiivGrJ17jY_mTPT1SaZQw4DaCRY+49deF49ZaEQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNASuG-TiivGrJ17jY_mTPT1SaZQw4DaCRY+49deF49ZaEQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kconfig-v4.21
X-PR-Tracked-Commit-Id: f222b7f43661c3dddd44ee493c16e04e8f231542
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 769e47094dcc0ddc8fe8e04c13565a71134ec1a2
Message-Id: <20181229220502.27755.4312.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 22:05:02 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Dec 2018 01:04:29 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kconfig-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/769e47094dcc0ddc8fe8e04c13565a71134ec1a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
