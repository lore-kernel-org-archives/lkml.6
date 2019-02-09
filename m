Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F07C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4D521934
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549749005;
	bh=/COy41RRZoYU9k2fOsw8Jqvn7WKGapW1aTdaBHbxCcg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OWtJNhfOyHa4or+UU/1YFqknJl3e+o2C9Wb6Ghc1CLwzWiLyQezJM/XFQyYytcNo+
	 29JlbDHnn8V43VpOP1f0Pt7nJ811z+oYBnA7Rllfi6n3ADlsDJBQ7siM+QYX28oQl7
	 gfuvJ5SOoDKkuSqPuJ/3c7SQBlQCfwNYBL7oBufA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBIVuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfBIVuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 16:50:04 -0500
Subject: Re: [PULL REQUEST] i2c for v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549749003;
        bh=/COy41RRZoYU9k2fOsw8Jqvn7WKGapW1aTdaBHbxCcg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cZo9tlo8naHwv6qUbnX6NCXTePpqUr9Cv+7tqby0OOovQm9IhlTbhyHDZPslvLkqv
         Dq4oJXbBujd80VTPrz3USU6HxDNQqmDgCSDeegWQpbWNpO5GNZ+4h0BetG6vT3mnKB
         DbKVvneQUG6231f24o1vWTCLm2wSKHMm92UAFiH4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190209213255.b2udenonysi4hgca@ninjato>
References: <20190209213255.b2udenonysi4hgca@ninjato>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190209213255.b2udenonysi4hgca@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: 13c80dda84c4c0c0f52f8dc2e8f083ca3ccc2aa0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df3865f8f56879b7e9f0ca47fa7bc5f2252df6d3
Message-Id: <154974900342.7946.1188802153743519635.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 21:50:03 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Feb 2019 22:32:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df3865f8f56879b7e9f0ca47fa7bc5f2252df6d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
