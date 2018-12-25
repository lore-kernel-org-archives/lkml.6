Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72F5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D42218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780015;
	bh=MZ6mLb4Xro8cjYHtKhWcCzxIJq6JakbsiblyOZSI+Rk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FXdR87SJw9nsE74K41hv66JLN60g3eC5Y4O7iPbUDQk8gVD7qq/SoMhVuvEAtyMVb
	 5KeCOH9mxeqiBG2PAVtEL+VIMrsOwPCgHFek28x49+7ZRNeK1X6w2ISPKwJWO1uBdA
	 +VDNZwylUGTgZmICRq5hojwY1ShQdzPjrGKS+nqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeLYXUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbeLYXUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:06 -0500
Subject: Re: [GIT PULL] LED updates for 4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780006;
        bh=MZ6mLb4Xro8cjYHtKhWcCzxIJq6JakbsiblyOZSI+Rk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SOSh+OSTFWQNEZsocDYKfhTwt+8buSVD5VUr0BqPH//EZFFilLPrEg00elGLrEOm0
         wjXhqCZ8SmTPULUjhVJ3q94OV60qtyD72+KmnGFPthbV9+2G2ER9Ln9dIF4eGmAfiz
         jWr/0MaRnk2+sdn4x82PKLaa1isoP9UgbTpHnkQs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221155451.7024-1-jacek.anaszewski@gmail.com>
References: <20181221155451.7024-1-jacek.anaszewski@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221155451.7024-1-jacek.anaszewski@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git
 tags/leds-for-4.21-rc1
X-PR-Tracked-Commit-Id: 8146aace60c7409cc60a1598bc9647a5bbb12eb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e4390ad067a61ce4e7607bd0df31f19a4caa36a
Message-Id: <20181225232006.23808.8456.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:06 +0000
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        krzk@kernel.org, robh@kernel.org, tiny.windzz@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 16:54:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/leds-for-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e4390ad067a61ce4e7607bd0df31f19a4caa36a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
