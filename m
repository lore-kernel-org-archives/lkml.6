Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A597C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF8520837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544222409;
	bh=IVZmjs1z5nl6ewY6LXOOw5AyBU5p4b/8NKfXuyW4VbU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GSUK8+1le85F49Hh5oVkpnkbD+Ebn9ggPpSMMoi7hKaDs2DB6cmr3j2S0UtxZXde+
	 OUiHoSep3nuyC5TkW87mw7AA/sdm4PUxhl645VAetXis/6qCZ6VbLCoyLoYZsFbrQR
	 viLt8C8JdirhaXncxVNzY2J11KE7kdKM8SMeV+as=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF8520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLGWkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLGWkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:40:02 -0500
Subject: Re: [GIT PULL] gcc-plugin updates for v4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544222402;
        bh=IVZmjs1z5nl6ewY6LXOOw5AyBU5p4b/8NKfXuyW4VbU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gwul/c+XSTc5xSDEs/OAA4vXR+mKPnyxjF5q/ceYhsmDmkGx10YxNJTCt1pTtU8uM
         1LesVeTmqefV8i+BiVkcpdb9wvjeQWOFMRqTxOmQZPZM2aU25y7wS77ToLLKewwYFf
         axclmNRj71wtWjfxLv03mh4FSmH29qPLa20+gteg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181207170845.GA24251@beast>
References: <20181207170845.GA24251@beast>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181207170845.GA24251@beast>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/gcc-plugins-v4.20-rc6
X-PR-Tracked-Commit-Id: 8fb2dfb228df785bbeb4d055a74402ef4b07fc25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1cdc3624a1df5b10519481763ec7a2b2481495ca
Message-Id: <20181207224002.10788.98152.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 07 Dec 2018 22:40:02 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Dec 2018 09:08:45 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v4.20-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1cdc3624a1df5b10519481763ec7a2b2481495ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
