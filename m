Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F909C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1C121927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545420643;
	bh=tfx6TsOZZrcYC0pWHcsvZ4T2gUUB51E22aIbP7xvsrQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sXQxGkWYPBZMI+lGQhmYIQvmcfUzRhRU5fE7BkfsQXopxcKI8Y44NW02iPKEQJihT
	 GRzvxuYwHHGVnH9m4e8E8fiRY4fYP4GqzxDjuqWdRiMgPHydpsiiOGZbWdKYYf4cJT
	 JvVq3SFK8dQlIeQ8c96pPtqPW7mnCWrIxXSD+sTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404539AbeLUTaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389784AbeLUTaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:30:03 -0500
Subject: Re: [GIT PULL] GPIO fixes for v4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545420602;
        bh=tfx6TsOZZrcYC0pWHcsvZ4T2gUUB51E22aIbP7xvsrQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HW2QhG7pyo6YIM28wDZwwvXRo36GwvteMlsmADD91bZjZzpkb8mmmaojUwNKfmehC
         UmoKtm5SiXJiKf5lT5KmvkaOHBOT0N4oYc5ZTYV9/rnvQf2KQ8dntxsLtoleLlLNv0
         YFUn2WqIgEhG6AVAqbQ1fDNXsIymLMKHfWsLiWAI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYn7hPt5Etb5oeD-pTW6ME4QAwnTZEXu8siGNxi-OgQew@mail.gmail.com>
References: <CACRpkdYn7hPt5Etb5oeD-pTW6ME4QAwnTZEXu8siGNxi-OgQew@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYn7hPt5Etb5oeD-pTW6ME4QAwnTZEXu8siGNxi-OgQew@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v4.20-3
X-PR-Tracked-Commit-Id: c8da642d41a6811c21177c9994aa7dc35be67d46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc380733a5e77ccc3b4d4622595e42f1b0902d66
Message-Id: <20181221193002.15695.824.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 21 Dec 2018 19:30:02 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hans de Goede <hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 09:59:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v4.20-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc380733a5e77ccc3b4d4622595e42f1b0902d66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
