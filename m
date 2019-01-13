Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B69C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9562064C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547402723;
	bh=U9/KxjgbLe107LgiUI5sG0iymdhPR+QUD06XXiNFpOQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AJaXcRM6uimYCm+pBV/b0lutB6bDSsZlvCY8OZx34bxhyy3VGDsqVO0eeiUY4EXwA
	 ByfudRMdTT+HvTAu4XTOmG7nEMpkgqTvujIwXVHD+fxB10rweyj7itri+I0IyGfv+p
	 70A8Rkr6uulawTkbq+JuZZC0EIEVb7xNtSEv+mro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfAMSFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 13:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfAMSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 13:05:03 -0500
Subject: Re: [GIT PULL] Driver core fixes for 5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547402702;
        bh=U9/KxjgbLe107LgiUI5sG0iymdhPR+QUD06XXiNFpOQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YJDuKldJJw5+k2gNab4d2ViBeh73rRr+piEh8x+IaTaELg//Yi8cY8xUTu7L2cqvg
         t2a++tqeHuuhWQ8hz7/ygI2bdIUihaEq4jt+yPZJrG0X73fq3DT/DsEQY3tmTNfVNc
         xRpGByKsYWPL/YRvelzWK9j+2RZ6rQALhiCdIAqQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190113102407.GA31034@kroah.com>
References: <20190113102407.GA31034@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190113102407.GA31034@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 driver-core-5.0-rc2
X-PR-Tracked-Commit-Id: 735df0ff6ece7b8759a744158f5d246fae4739f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72d657dd2115804b93bde4b77e426cc2de70eebf
Message-Id: <154740270249.11831.5681282157766374922.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Jan 2019 18:05:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Jan 2019 11:24:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72d657dd2115804b93bde4b77e426cc2de70eebf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
