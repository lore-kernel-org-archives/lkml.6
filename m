Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24413C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75F621924
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550422214;
	bh=LZnn+76Oys1XqofNmbGsg8Xy90/TMLlj6C0juvIDPKc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZNZqI5N/frvfelfNdiNRxuKRmglSBCqpsV0Bc034e+UjKy8ciTh0Rdok634itNZae
	 jYSKicz/f6WASPhep4Il1RRoXcaVAV57F240zGTr/jdwDMNPXzx9p17NqYtIae3H2g
	 LFRSGR+/Vr0V7Ny5MhbGrujwbZMxFGtAHtndxdNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfBQQuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfBQQuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:50:05 -0500
Subject: Re: [PULL REQUEST] i2c for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550422204;
        bh=LZnn+76Oys1XqofNmbGsg8Xy90/TMLlj6C0juvIDPKc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jVyV6EJYdftzr87aaQd7naCNak2c3TwJ53CsLaSygCVb+678judiDe/EqQRFL//l9
         6i9IKJecUlreEV5dDAVLsVDQOlyQnZRlFgIRFnaJt05UemuLJtWySG/R2jDs6H7toU
         3rw0yPsP7mv2UOng2S4IyqGW6eQmq0EYCe6MjNUs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190217101513.mmbztn2nopa4phif@ninjato>
References: <20190217101513.mmbztn2nopa4phif@ninjato>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190217101513.mmbztn2nopa4phif@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: f275a4659484716259cc46268d9043424e51cf0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1653c2f2da0153f386b3b7494dc077631ae982c8
Message-Id: <155042220483.16506.12203473687289796807.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Feb 2019 16:50:04 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Feb 2019 11:15:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1653c2f2da0153f386b3b7494dc077631ae982c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
