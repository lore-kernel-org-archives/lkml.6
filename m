Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304C3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCFD21A80
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545948311;
	bh=0Dh5N4eQZ5AAMqgrcTpgPwvUtDtNsZyE6uxdWUl4Q84=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uoquy8ry3BI1tn/JEfLfAB4nsnG+v4T7xIMttmkTlGA1B7Ke2til10fUIorxz8RJR
	 fD2tUI49w6WAzHA7rTsTqd9Cy8tY3lEgKTDuBblw1ccdV5g0S8AOIlIHYwFC99pzXx
	 TM7UXxqT46MjxGLc41nupGqO9I6v8wAzleD57ENA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbeL0WFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:05:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731541AbeL0WFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:05:05 -0500
Subject: Re: [GIT PULL] Modules updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545948305;
        bh=0Dh5N4eQZ5AAMqgrcTpgPwvUtDtNsZyE6uxdWUl4Q84=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Vw34n94JQ3IjKMGLBvk6sufaSfMQibNlrTDH9o8RKOOqBgcULSFAhOXTfCGpKJeMu
         xJC4zqRfxT/HAg+SwGWeWFcUVK4m9WnC5ACwk/I6hOUxs9nmxXf0wt4EGGk4mocqao
         aQ9kEiQsBhQAlfh+kcpInISqWYZSw8Bea2Kt0gNM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181226190114.GA16407@linux-8ccs>
References: <20181226190114.GA16407@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181226190114.GA16407@linux-8ccs>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v4.21
X-PR-Tracked-Commit-Id: 93d77e7f1410c366050d6035dcba1a5167c7cf0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f9f852c75e7d776b078813586c76a2bc7dca993
Message-Id: <20181227220505.24636.70699.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 22:05:05 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Dec 2018 20:01:15 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f9f852c75e7d776b078813586c76a2bc7dca993

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
