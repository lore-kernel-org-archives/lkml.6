Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF68C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C248D218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550685006;
	bh=d5dLoVWZqQ+D3fj2S4lo4ophPtpEZC69PFCI31HqM/I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ie+UEqQ/5WVV4AGLOOjUSZXsiXa8XfFwNP3jB9nnrxbA2LJGIeMW7uRUQsvuWBdPu
	 ZvDrtFuM4DSIzZge4uISIpwWt5P8i+IbQG3LF4nu3drSg1zUsSVGKDb0/YmcLCS98B
	 hV1o8pD/tt4JlFO7m2EZqT4vPab+VNOiXt34d+qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfBTRuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfBTRuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:50:04 -0500
Subject: Re: [GIT PULL] pin control fixes for v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550685003;
        bh=d5dLoVWZqQ+D3fj2S4lo4ophPtpEZC69PFCI31HqM/I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HD1UtgUUCujDsWi06R2CSDHaC+e6XIfzjNZUZING5aPnBrPtljF8bfqS2JJW9tdsp
         qkpaIqbOy96YKYsK7/AefoQ8rLHbY7dL54PQoTR7FnMEgu+t0hsYI4GRilDTFwZPpi
         XHiPA6elDedTv7eHx7YBAwrczvQXlJZSY4f2LY+U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYMDh-VLBcKsfrCV5wV0vUqGPujztkqTjyZPznJ2APhEQ@mail.gmail.com>
References: <CACRpkdYMDh-VLBcKsfrCV5wV0vUqGPujztkqTjyZPznJ2APhEQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYMDh-VLBcKsfrCV5wV0vUqGPujztkqTjyZPznJ2APhEQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v5.0-3
X-PR-Tracked-Commit-Id: c17abcfa93bf0be5e48bb011607d237ac2bfc839
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb83f15ef9dd984834bc60b380efbeffdf1ecc04
Message-Id: <155068500349.4632.4150873970219059471.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Feb 2019 17:50:03 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 Feb 2019 09:08:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.0-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb83f15ef9dd984834bc60b380efbeffdf1ecc04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
