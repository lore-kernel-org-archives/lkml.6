Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDDAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412942146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550685011;
	bh=FFPv45a+cZirvfi5mKshu6fOmLDEoGaK3aB1AFQw6WI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kvyyciTURbR0Ee/Z2B4hti7/EE+4KnRScptLcRr1PG4PZjyyp63k0k9PJX5DzCdGW
	 PU1LwGRsq4SraGoTXd9e6KmLDZbrk2nBCA9f1QVj6x04lsCYVaHAvjfbZ4cvcrq3Tv
	 NOsDa06b+in2AArzdMR63CmUXRrC041houB39PcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfBTRuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfBTRuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:50:04 -0500
Subject: Re: [GIT PULL] sound fixes for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550685004;
        bh=FFPv45a+cZirvfi5mKshu6fOmLDEoGaK3aB1AFQw6WI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SgPnwHFJfjASqkvggUv+NpihvjhIBzjrQA0QtGRdvSnTGlQfxWZDTwwbrHoOpTWzq
         f95Yhtqipks7jj/S/fq7I6m38zymEhmUfP0IMErF9xihNSrbTzb10gMVi4ChtfLx0g
         Uuq9hnz/nVrDVoA3YnhMjWsDXfufbzsZmB1jQYpc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hef82hhax.wl-tiwai@suse.de>
References: <s5hef82hhax.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hef82hhax.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.0
X-PR-Tracked-Commit-Id: 268836649c07e0d38866006b5e94294b5bbc9806
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2137397c92aec3713fa10be3c9b830f9a1674e60
Message-Id: <155068500409.4632.15274285185585443034.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Feb 2019 17:50:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 Feb 2019 11:42:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2137397c92aec3713fa10be3c9b830f9a1674e60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
