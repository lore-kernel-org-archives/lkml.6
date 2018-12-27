Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC448C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C5221909
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545948380;
	bh=b2BVIKlFRXdJmOpS+AaDQfn7x1EFqPTnqvqcFAwv9MA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Y2WEHJGmIOkzu0mFgAV7o53/NQazlfTJcyYl2XhIk+wY9mo0q8UJZLQn/1dkcaG0n
	 DJ8uEAfsiUZCoVWNFdFGL5/HQhEg4pSpXA4fU78UfJKgzh5XdwKMncYcG5sN+yhTvD
	 K9EMGAVtl4l2306V6rQr9MyDoDTnRo14T+ghMmZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbeL0WGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:06:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731504AbeL0WFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:05:03 -0500
Subject: Re: [GIT PULL] gcc-plugins update for v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545948302;
        bh=b2BVIKlFRXdJmOpS+AaDQfn7x1EFqPTnqvqcFAwv9MA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MRyW/A46FUnSqYmUHGnlS51mft/sq3L1HCsRwFLJiwE5HmrOMAP5s/cPskwiXi5/H
         5gmS6yEUQI8XKGmOcLpbS/E88m2GcMbsc8HzkUwY8CGLDsFDy+lsEjEFSxaRzKSetA
         okOJHcHt8mggfz9Y8lcnpkIwsGyMjn/kphjow3U8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181218000132.GA19073@beast>
References: <20181218000132.GA19073@beast>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181218000132.GA19073@beast>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/gcc-plugins-v4.21-rc1
X-PR-Tracked-Commit-Id: 189af4657186da08a2e79fb8e906cfd82b2ccddc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6f1b355d451680a45d63ce66cea67057c938a87
Message-Id: <20181227220502.24636.44214.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 22:05:02 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Emese Revfy <re.emese@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Nicolas Pitre <nico@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Dec 2018 16:01:32 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6f1b355d451680a45d63ce66cea67057c938a87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
