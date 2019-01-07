Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B23C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 01:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDAC20838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 01:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546823722;
	bh=KuvH6GLvIHgHFuf4IjxBHBWuSSXsSZZmzfHthspPViY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TPRK6omdMsAV+i0K0GbRbjHw5XppEH3YldY6F1pg6a0MdT0murVzR1GoeVGPza0l+
	 MMRR7RPkkCDyjWD4+W12w/kg88PhlxiFVPSS2Ti0jpkn1LwC2HQoiCXc6LCBpKyIfO
	 K3vCAoNkaSYEcuwaMWc94A/Mxg8pX6pLhrJCyIkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfAGBPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 20:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfAGBPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 20:15:03 -0500
Subject: Re: [GIT PULL] more Kbuild updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546823703;
        bh=KuvH6GLvIHgHFuf4IjxBHBWuSSXsSZZmzfHthspPViY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=O5S6p2aaMSIu9ellAP9oJFQZPDm/2aaUdPA+X236NxykMEhmO13evkH5ecRQxp83A
         JTokPv0SZxocIBoBJebh9lbYGv1324G9CL4nq4FD6Fz+addnwXQKKxHt5k6kK4vc9M
         4eQ1iX2krlPn6Eo3B9nItv3tv5hTd12V8KZ6/rZo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATMD=sNLMpc=2V8Xenk0jLKQDf3E-EgTKyRYzv53pSAfg@mail.gmail.com>
References: <CAK7LNATMD=sNLMpc=2V8Xenk0jLKQDf3E-EgTKyRYzv53pSAfg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATMD=sNLMpc=2V8Xenk0jLKQDf3E-EgTKyRYzv53pSAfg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-v4.21-3
X-PR-Tracked-Commit-Id: d86271af64602e7c86c003b27f27c7216706ff96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85e1ffbd42f664965dc05f6e9851c06379f27fb2
Message-Id: <20190107011503.21485.8221.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Mon, 07 Jan 2019 01:15:03 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Jan 2019 10:59:02 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v4.21-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85e1ffbd42f664965dc05f6e9851c06379f27fb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
