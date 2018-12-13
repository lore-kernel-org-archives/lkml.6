Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979AAC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4AA20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544735718;
	bh=jzsPF9CA5QbLJYoIduCUHb9/pZfctol1vncWFDleD3M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Dy8o+Uqd9CCUyr6jLBxMAc5VAMz3iELNsB5ehjFhEejPxYpWSZjMSVo9uoijE704p
	 EuOmG0cjm5wYsykEF2U8Fws7V4Y9FjqHLOlSAOgdGicCXmbyJuTp52/0CselRes2wY
	 ypmy+EoLrUzp3yFevaF7Hrql+UUj3TstrQQLT2/w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4AA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeLMVPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbeLMVPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:15:03 -0500
Subject: Re: [GIT PULL] sound fixes for 4.20-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544735702;
        bh=jzsPF9CA5QbLJYoIduCUHb9/pZfctol1vncWFDleD3M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LEv6zaEXxlRqNvydg87rwjkoDupGbFc9RBWb8NlKfBfZMVDbaRi5N717KZbMUmfKh
         zQhRMevmB6/hnXTDSma9dTCt0wrrZZL2B93JTJBeFjy+w+OOO8fQtr0fu5FgIzq4Gp
         m+mhHizZBHu7EYDH1izS9hN7Ygs7TAHVmyNpMaic=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hefalu8q7.wl-tiwai@suse.de>
References: <s5hefalu8q7.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hefalu8q7.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-4.20-rc7
X-PR-Tracked-Commit-Id: 0bea4cc8383519f78f3f74caca7bdebdfb346d3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52a7dc28a7b01cdd9ec349a943944dc49d20fc26
Message-Id: <20181213211502.3163.61358.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 13 Dec 2018 21:15:02 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Dec 2018 09:33:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-4.20-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52a7dc28a7b01cdd9ec349a943944dc49d20fc26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
