Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEDEC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84B120844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458413;
	bh=JR3z9YLr10yBN/UqBqD14L7IgYdTEFjM27AdLW6vhJQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KDLWB/D0tFeKveZ/4AWIrBn8q0Gmb2CvI/JWH6QSqiOb9pefW4GHFhOXIeiUHsaOe
	 7SIpmV5JYr7i6I+exSzN1tSNi00uCBt2ZTwRAl8W8scAVKWAWsctIa1JfH7uqKXkhT
	 RVNSrE2pKPlFU7Djkt/D8AwEliFtgf6TRiFRm10U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfAYXUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbfAYXUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:20:06 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.0-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458405;
        bh=JR3z9YLr10yBN/UqBqD14L7IgYdTEFjM27AdLW6vhJQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gV/IM1qRpflUx8BCSCwFs0NHiWnILYsCxnhKeDgyf/NdJ/Y7ZSXa0bWCkYB/TrEtU
         aXAxjb6Pi4Ea+xXPF45U6X/B2q2X6CRQSkUpp0eQwIB12T0cdet2A1nyAuK36HA9me
         QPVJDHMtGVJoQX20pkliQy26p28sr0wt/xLaV5mo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190125122319.GA7685@kroah.com>
References: <20190125122319.GA7685@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190125122319.GA7685@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.0-rc4
X-PR-Tracked-Commit-Id: 52768f324241b2d9624d32787cff63ec3e0e420a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d488bd21a4b2bf6b3f236f22ed213c61e74c878b
Message-Id: <154845840565.30665.3833484683855676581.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Jan 2019 23:20:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jan 2019 13:23:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d488bd21a4b2bf6b3f236f22ed213c61e74c878b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
