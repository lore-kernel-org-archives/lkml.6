Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF4DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8926206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550886306;
	bh=LnQak7QRZdp+bVRfOiqMpoBlikzabsBgf3jBzP+X/JI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Hk5dx7/VW0XgZqArjz3sn+zkN/4bB+4trmLZatQJAn/Y4QJZiKckK14Iy2hKtV3gZ
	 d1orQYgG8CGc8P17+aSONumkBgyojjL3I041zy/aOM3NXjJYHDxsIrkX0Mg/f4Vw7B
	 xpo5M83Gxcs5nyERmbe+xNzrQ8fiSVmsQqA2/XQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfBWBpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBWBpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 20:45:03 -0500
Subject: Re: [GIT PULL] Kbuild fixes for v5.0(-rc8)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550886303;
        bh=LnQak7QRZdp+bVRfOiqMpoBlikzabsBgf3jBzP+X/JI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zku7qG4Loho75b8o2d3qn1F7prgVwBZZOCoD3qw/7MLPmoDCiWQnIVUhVN9hoL6D3
         MBLYaJORb9FjOOaehmpHKOH0c+GEh6obOyuZ1E6TUkqqRRtku7Nmtzi9Rh4SlPmiFa
         omhE6Ld98SETSrmpWY7bn4JeR9w6Nmho5WfxHIeA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATwe3NwhApYFQyCob4+xSrr4a9zUY34EX-QN8pWoocvoA@mail.gmail.com>
References: <CAK7LNATwe3NwhApYFQyCob4+xSrr4a9zUY34EX-QN8pWoocvoA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATwe3NwhApYFQyCob4+xSrr4a9zUY34EX-QN8pWoocvoA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v5.0-2
X-PR-Tracked-Commit-Id: 207a369e3c085799e7836221f64e7a7329985fb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77dc1181d896c5c3f8e131e341993aef41e16505
Message-Id: <155088630302.27298.14941486919596278767.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Feb 2019 01:45:03 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Feb 2019 09:29:27 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77dc1181d896c5c3f8e131e341993aef41e16505

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
