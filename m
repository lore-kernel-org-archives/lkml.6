Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F1C43444
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49DD222AB
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546742405;
	bh=O4Wv+JUWpVyq5+Q2l5TeBqMTwDtIoNfDUFW6WQoBTi8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=j5ViPkM5rsqe0mf4vth/JwnhsICeMZh82229TzM1wJ18rm3dkfKSo3BLiLpbjnmSy
	 LSk7n9BH9SUj1Zxx38Tldbr7VzDWLf4dDPhe1Rl5Dta7IEjtYJAavtwzlwg/sVS0hE
	 CBEb5H6gll126zf8ZRoePRh5OJwZSoxMFw8S0J5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfAFCkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfAFCkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 21:40:04 -0500
Subject: Re: [GIT PULL v2] HID for 4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546742403;
        bh=O4Wv+JUWpVyq5+Q2l5TeBqMTwDtIoNfDUFW6WQoBTi8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=czX1x/RzeEJhrGqOvAZQSnzwsq3zwJIRjcyZm+0XqU+nWbri9owrg2Vk+dgk8nrxT
         ct45lqvRGutew3B4Ph7lgKE1gULxHdWB+pU9zX4wyPPOlb2RQFLVWLR4JvbbPIKmK1
         hLbytssGZaXorYSwdKWWFn5GsZx2E43eCjxeUjrQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1901031300000.14047@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901031231040.14047@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1901031300000.14047@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1901031300000.14047@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: bd8879faafe6d057237461c4d58d8b0d37b9e3ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf26057a9441173ad552e90cea3344607075c9ad
Message-Id: <20190106024003.13237.35013.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 02:40:03 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Jan 2019 13:07:04 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf26057a9441173ad552e90cea3344607075c9ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
