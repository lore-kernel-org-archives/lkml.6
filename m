Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF464C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C40B222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550007926;
	bh=CEnIu5l/jxUqfAHmkwHbc2lU1WaHsmnJqE/GpqHD3fk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Nj3V3FaEdBkWwX3YCQPqrEROtUe1MwiRR5pxJvZeQRFjXru5aSk3oPp9x7hY65woC
	 jJXN0t69JpJBwcxF99G+FEhTjX5kOLyR0vLGuKhr8OEmQwFWX2Ml6uRL9/s6CMn2Bm
	 lFcOntc/3zeDZJDIGpBhuw4FrzpGBWeP+kxlbnMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbfBLVpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732625AbfBLVpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:45:04 -0500
Subject: Re: [GIT PULL] sound fixes for 5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550007903;
        bh=CEnIu5l/jxUqfAHmkwHbc2lU1WaHsmnJqE/GpqHD3fk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j3kncDe3Hdx+/jYFwshtjngYTngNDbwPpbuiardpb7c+AJS3MR65cV7hhlKg5GFuz
         0+PEvwO/zkGIYIMdwFoTKWAHQ/1ZvDaVJ57kSfu7xs9RdvuS+qaF1ZTShi7Y2JS8yQ
         JqWGI45ko9+lPDm6hSJFWBmtffmkCwDATlruY2VE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hbm3h3wdc.wl-tiwai@suse.de>
References: <s5hbm3h3wdc.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hbm3h3wdc.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.0-rc7
X-PR-Tracked-Commit-Id: 00a399cad1a063e7665f06b6497a807db20441fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d110257c290a2c825d83ff6d12fef9732429dd2
Message-Id: <155000790368.22230.5747614181870175647.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Feb 2019 21:45:03 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Feb 2019 15:38:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d110257c290a2c825d83ff6d12fef9732429dd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
