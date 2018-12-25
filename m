Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF8AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90196218C3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780028;
	bh=gtdLRstSu56PDKCr5V32OerUr7AMv3dAluMfELoJigA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mmjWdK5m317MAdEkW2F1XiB2gcZ91nQE5mK7laeM0mZau8FyKWTnwKaqndV2VYWNn
	 W67EesPb8RPlIVdMgwZlzU7BhdqyLxKViqfTFCqiJMDX/uKo6hsAo/10iBrdQmUmcO
	 ovJZXJeAuLJMyrRK6U3xXyv8+bjKgENSdxVtdi+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeLYXU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbeLYXUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:08 -0500
Subject: Re: [GIT PULL] SPI updates for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780007;
        bh=gtdLRstSu56PDKCr5V32OerUr7AMv3dAluMfELoJigA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M6c50q41tWpqaO/cLyydl4kGmCUDW1AqFzTNWLyxo7PfFV0yjEEfoHXRBHox7MBbv
         T3uv59tF9xFmsbyxESkBWYW/pTb/uselfHxsV50tjH5CC9GYg7yoBDgTjaKzLytv8i
         hpu3cOgJsJ6790Y9d2gXedirWbe6AeHneY/Yid6o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181224191047.GB1846@sirena.org.uk>
References: <20181224191047.GB1846@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181224191047.GB1846@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
 tags/spi-v4.21
X-PR-Tracked-Commit-Id: 74ff666bd7ba2da563f99f2a8af7bf9f20008bc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0051db82182bfd80d6c76982bcb36b09eb338a89
Message-Id: <20181225232007.23808.420.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:07 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Dec 2018 19:10:47 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4.21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0051db82182bfd80d6c76982bcb36b09eb338a89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
