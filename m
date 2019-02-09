Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B182C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E577021841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549672845;
	bh=iuB1hrzKqonE67OPTY4bsWXBLdMrXxYfcAFc2Ofptkg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JHG5+wagttmsnWd8BzgZU28l7V0KOisEGvPKXZrgKz9vexjJwH5jvRA3L7dks+hIR
	 UQpiPDNI7LA9dn2WROxtqB7lNVWlMNX3sBHQlofWC8lRdQ3k8kN1hSYEtkRM+vjOc7
	 4kFHEyxN09BRMsFxQxi8bH/ff4AluhXEOAa6PkNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfBIAkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:40:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfBIAkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:40:05 -0500
Subject: Re: [GIT PULL] signal fixes for v5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549672804;
        bh=iuB1hrzKqonE67OPTY4bsWXBLdMrXxYfcAFc2Ofptkg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=T38fpc0Y3pyag3PoYlP/aQ0bou7ExioyfY0XCWtBS6oQqKXnn05sQdQHHpyD6aVyi
         NZjfAhajd3ys+FAT/KThzOd6UdQfBy/JwBKAvevzSsj/WD4fI5rxVVeWdChpWHl8Vu
         XIy3r4HJSG76kCdSJaEOzN8JD+hmA5QaRkHEWwuk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87mun6nuql.fsf@xmission.com>
References: <87mun6nuql.fsf@xmission.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87mun6nuql.fsf@xmission.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 for-linus
X-PR-Tracked-Commit-Id: 7146db3317c67b517258cb5e1b08af387da0618b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b2912cedc238c984e6a4039836ed9c911121076
Message-Id: <154967280484.26526.9947869539158481559.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 00:40:04 +0000
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jack Andersen <jackoalan@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Feb 2019 09:52:02 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b2912cedc238c984e6a4039836ed9c911121076

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
