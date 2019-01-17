Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F604C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540FC20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547750115;
	bh=SlNY+EnjJRdJutFEEbyOFU7ziZUt8D16qczuybllP74=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pSbHz6XiGKOK1KHm0LYf08EN1XutPxKzb/cmyrUMkpZLeuSPv2ycckXMK7mWXtjqD
	 p+S10XDZ0YzB7DPopzwlm8holK0U3KhyRjztuoImBHj1gBYA7OrUskvFW3yc6pYbAk
	 oAfiiVu1WCnraViyppdCD6xv4nH36Oy7+2ZgoKxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfAQSfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbfAQSfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:35:02 -0500
Subject: Re: [GIT PULL] Kbuild fixes for v5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547750102;
        bh=SlNY+EnjJRdJutFEEbyOFU7ziZUt8D16qczuybllP74=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s1CIxCVIy02kntUS0BFaut1DgmsSexSisVRdcXxpeMALQl/9q+h5XYwh214TqWHeY
         HC8SOjUCQ0g3/aqI3fQCxY+fIi0bLLhOB1fL+cj0x56gs0XR4P2tDvEepnsmlrpb3g
         jlBOvTVpCXYCS/saVs+hReOa2UGWUJev0dO1LElo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAS1ZHH6DdB5wvyBA3m2HFrnY6GRmQG+OX_Pd7t9CyJ6nQ@mail.gmail.com>
References: <CAK7LNAS1ZHH6DdB5wvyBA3m2HFrnY6GRmQG+OX_Pd7t9CyJ6nQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAS1ZHH6DdB5wvyBA3m2HFrnY6GRmQG+OX_Pd7t9CyJ6nQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v5.0
X-PR-Tracked-Commit-Id: e00d8880481497474792d28c14479a9fb6752046
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4484a495586dddf989380f89a7c16d43db6790b
Message-Id: <154775010234.11520.5164430259271044705.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Jan 2019 18:35:02 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Jan 2019 23:47:55 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4484a495586dddf989380f89a7c16d43db6790b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
