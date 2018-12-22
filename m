Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C9BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0360F2192C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545520206;
	bh=Hz6vHKUsfRGEe8759J7nRYyCIMJAaRyzyOPwuZP2XYw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fnApjx7LX6hRzjy3BLAdXDfjfZ5yWDvbJANcAlE6K2gmWTqG7aEPLqKDmhrlGyJFW
	 Jdsvie40xFuF2/dhDqIumIsjMldqsod1jFRvUnOZEBa6kNfiBo73ImsMP9Bxt4TULb
	 56OHzIex4/LWqJfZEkdTMYchE7YYkWHhkmB33Myc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405082AbeLVXKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404402AbeLVXKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 18:10:02 -0500
Subject: Re: [GIT PULL] compiler-attributes for v4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545520202;
        bh=Hz6vHKUsfRGEe8759J7nRYyCIMJAaRyzyOPwuZP2XYw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OJIpGPF34FQbfPXgmHk9vr8CqOr1OC/Q+W65fYe5c4bEkkXvnZiz2SATNGKlm49Nm
         anOD+DRn/1Rz38PfJvG/AvQUb/3Sn6scW98UcmtpBRJzvqqxj+Zmsx5SiLtMy4K/09
         Tw5kNQj/pgD9g7mnU8pJhdY+7gdHn2jA8Acx/jWQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181221212922.GA14646@gmail.com>
References: <20181221212922.GA14646@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181221212922.GA14646@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/compiler-attributes-for-linus-v4.20
X-PR-Tracked-Commit-Id: 71391bdd2e9aab188f86bf1ecd9b232531ec7eea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1104bd96eb2af9707dce69a22c63bd432a41380a
Message-Id: <20181222231002.28463.61321.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 22 Dec 2018 23:10:02 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Xiaozhou Liu <liuxiaozhou@bytedance.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 22:29:22 +0100:

> https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v4.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1104bd96eb2af9707dce69a22c63bd432a41380a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
