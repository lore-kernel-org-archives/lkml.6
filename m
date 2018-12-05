Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3480C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A7B20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544034012;
	bh=3orrtxMYPTCt7x+Wku4tzYWGXQoWImMQqTEXl03RHbA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1NI63br4qIS77XscY0n7yXdNqT3CKQv6M8FDWTY9E1KqQoQpbecp6tIA75YgM62aT
	 SYNtx88V0WHgAQo1qotEEnIxd6Dt1rjD/65YCGHKabsa3G6/c/v9sygSZLtJTLPLAL
	 4eGEc4vlzis92V4b2ZypuBGVc8O/++mkM3ZaCd7w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A7B20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeLESUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeLESUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:20:03 -0500
Subject: Re: [git pull] Input updates for v4.20-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544034002;
        bh=3orrtxMYPTCt7x+Wku4tzYWGXQoWImMQqTEXl03RHbA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JdLZ5bhkq5fbB7HAUMuWy7Wh9Yp0eD1evr82e+P3mbyrnD23dA6F0VVXQ7CqPzr/B
         IMw+mtwic2M6mqV6vEyXnbOIxyXB2kAjV7rVrDncMaY1eok1pb1iz2ms4ngfp2ppWP
         spz0u9fBbgVLN3mpmdO9zx1cJiwokxpYVCKBIX3k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181204033746.GA235290@dtor-ws>
References: <20181204033746.GA235290@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181204033746.GA235290@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 6c3516fed7b61a3527459ccfa67fab130d910610
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adac0753c25217a2365b132c87cb2540b51fa89b
Message-Id: <20181205182002.5826.80954.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 05 Dec 2018 18:20:02 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Dec 2018 19:37:46 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adac0753c25217a2365b132c87cb2540b51fa89b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
