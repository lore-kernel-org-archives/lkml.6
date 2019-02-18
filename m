Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A477C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5EA2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550513704;
	bh=TIoIcT0AHcVjT0/AD3rYdzXunPYu8q1Dta0bt9ZKN18=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pQpENeuQeYym0dv4Rs86RcPhRuVGu3Xa7aXiMMYY60EksBXuU9eXbnghxaaGtcRMZ
	 zGGjtJKTvR50RKI892Al7t63BdQs8i7fXMUmg7f+bibBqWCPL0XiPoxzL30Y1A1fgb
	 27zJP/FIC39+2rueW+xncVDxZuDgQO9Xo9W6c4sM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390780AbfBRSPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732601AbfBRSPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:15:03 -0500
Subject: Re: [GIT PULL] Mailbox fixes for v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550513702;
        bh=TIoIcT0AHcVjT0/AD3rYdzXunPYu8q1Dta0bt9ZKN18=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WQzHhJV3Qm47I5oKYqQZ6MdZ4nmkJQrLGGPIaIFUQDH6qdc81d5hZOwwB1zgPZqGZ
         FIBIJY5dyac3dFmd3MtC4oR1K3tik2j/H+pTNBO/nJAVb54p9pbrB9fVzjfTUGWHsE
         55flB65S97lxcW373L1HE+gpDCT2mKlhG9tuARpU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY2SrgwFNgKa4+ossU3i3U76m2sa63r1=QsRg=PGGWAPxw@mail.gmail.com>
References: <CABb+yY2SrgwFNgKa4+ossU3i3U76m2sa63r1=QsRg=PGGWAPxw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY2SrgwFNgKa4+ossU3i3U76m2sa63r1=QsRg=PGGWAPxw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git
 tags/mailbox-fixes-v5.0-rc7
X-PR-Tracked-Commit-Id: d7bf31a0f85faaf63c63c39d55154825a1eaaea9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 301e361072e56a6d6afbf952ae5e746dc8bbb865
Message-Id: <155051370246.15678.3936601576340770886.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Feb 2019 18:15:02 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 18 Feb 2019 11:01:57 -0600:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-fixes-v5.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/301e361072e56a6d6afbf952ae5e746dc8bbb865

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
