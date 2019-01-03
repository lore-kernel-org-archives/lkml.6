Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811C4204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546484730;
	bh=GSgOVwzKOYW3rH0brvcUbRF5MfxLz7dB4cRuw+tJBOo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rKm5C/ElRKWcQhQ+PHVyWMLwcOOGg+xJyDohjOUTArzpTJhueAOYwz6xvVZnHLJNm
	 9ud66JLnVMZ1I/2upgbD4oeHipueV9GNo9NRE7c7Q04udpapQqfIqiz4TDJQmrMtvL
	 XZgXabU2mTcY0YPzg+2Qikrn5JnqNj72RnIM9y3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfACDFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbfACDFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:05:06 -0500
Subject: Re: [git pull] Input updates for v4.21-rc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546484706;
        bh=GSgOVwzKOYW3rH0brvcUbRF5MfxLz7dB4cRuw+tJBOo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G/JCqn5Jd2rVoVDDIo1ry4BofLcBXmlPymFJujwmKTEccWCxcQ5XJaFK51JUqu6CY
         lYERcjurGf2pH5lJnZQgwN98le3cfmAAhkUgKWzugYSo9fikZeN/fXYH4YZTDLuBj/
         p7aMrCUyIoEZBAI+Q1v+8Ym1/jCdZ1BvXPSh1sdI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190103010636.GA189500@dtor-ws>
References: <20190103010636.GA189500@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190103010636.GA189500@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 592b15ba7260f8dec8bfc71ef0ea1934801a35aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 645ff1e8e704c4f33ab1fcd3c87f95cb9b6d7144
Message-Id: <20190103030506.10885.12446.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 03 Jan 2019 03:05:06 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Jan 2019 17:06:36 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/645ff1e8e704c4f33ab1fcd3c87f95cb9b6d7144

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
