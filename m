Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE647C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1A72190C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545948326;
	bh=jDY9T0CTaHOadaDdHeYjIdgqje9+0eCZ7ARChXtP5Z8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0AW3H9spo2dEibwUEe2iF8Y0CnRKGFx4dkYsIR4L6dKh/hzJYzpS0vOk8RPLXkKrp
	 iL7+a2TOtwLnTuYKCYC/rxPlqFQzsEwOikD6IutWAXFFdAoxxnXWq4J1gcfJibJe70
	 oj7I75DG1k9bWJy39rJtAftorFCrbMfrzFjaS7IA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbeL0WFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731538AbeL0WFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:05:05 -0500
Subject: Re: [GIT PULL] security: general updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545948305;
        bh=jDY9T0CTaHOadaDdHeYjIdgqje9+0eCZ7ARChXtP5Z8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OmI/dPHAfNsfZRiYdotNhe8UijVVIHvKt8g+26ZMi4uR2lF/coLhDKZqfoidFLrwD
         ZxU6hyNPKBz7mb0KCPICXbI0dLR0WCGLSnVhzWA2Z4uya3oJc55Jk1k4C02Sc3XgTQ
         2//AaFYmxctrOma+EE2NZ7/fu07z/gbVNRiGcXts=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1812250652420.2714@namei.org>
References: <alpine.LRH.2.21.1812250652420.2714@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1812250652420.2714@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-general
X-PR-Tracked-Commit-Id: b49d564344f773d8afee982153c8493e5f2eaf38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f03bf93947fa2a2b84fac56e93c65d4fffed7f1
Message-Id: <20181227220505.24636.49449.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 22:05:05 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Dec 2018 06:55:00 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f03bf93947fa2a2b84fac56e93c65d4fffed7f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
