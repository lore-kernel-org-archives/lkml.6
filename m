Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECC7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D6021905
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546061777;
	bh=2CROIl1vguwSLK9zgkh/eqAR40o0+7K+mSddfDlXelg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0/V9I+gyNGA/P07yGaFfiOF1aDGEDchUXSCCEfe4aGzBdYduGEzXr4+RiXhNiJM44
	 Y+fGKaMBtDh0Kubs8zLeWQ7sgeF4QgEVZp9ZJFiY1Ml8YMuZdUnXG5LifmYJhJlaHN
	 7WDWa+h3qlCRb90fZwFkk/IcAz99qFxXolbRAXN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeL2FgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:36:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbeL2FfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:35:07 -0500
Subject: Re: [GIT PULL] hsi changes for hsi-4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546061706;
        bh=2CROIl1vguwSLK9zgkh/eqAR40o0+7K+mSddfDlXelg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k2BQ8zc26aZuzlihCMsYPtbbJE6fyN2Yk41r4yQHXYd2/qdjJQohOAbzLkqlKvXiu
         ieF6ujdv7aX1Ya52I2jJoBTqz+ZmMgK9i0lRWvWpq1yWelR9Yi5GSAfKwGLvX7gXd4
         R1e60ykRkKGPNl7UpjmGa4NqEjCgkvMzDXsXW9Wg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181228131003.5ncwdjazidyk3rgz@earth.universe>
References: <20181228131003.5ncwdjazidyk3rgz@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181228131003.5ncwdjazidyk3rgz@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git
 tags/hsi-for-4.21
X-PR-Tracked-Commit-Id: 3a658e09a215586918044d8f8b8358eb14fa3f7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d6ad6fba6b7af06143c67964f4095c74c9ce87c
Message-Id: <20181229053506.9301.81162.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 29 Dec 2018 05:35:06 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Dec 2018 14:10:03 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d6ad6fba6b7af06143c67964f4095c74c9ce87c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
