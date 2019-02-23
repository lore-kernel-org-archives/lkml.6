Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B9EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C929F206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550886315;
	bh=ljyhGZtkpiMQJIHtoiEu60v1JPN+ojBQEG8rtAjW1eA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oVAyRkZ4PvoDTtLCU+4doevWvygI4gF6Tn3mU6/5FC72ThmePOgLCW3SY66+xOcJ6
	 9J0FyM1kkgK0MguGVscKpF/CdUQljn77REuDG+IuYfL1ha9zBfuosN38BGKCJ9zEPF
	 0cPU5ejjCI2BNxEDRJqldI2PX7OBiUMNBQTZN6D4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfBWBpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbfBWBpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 20:45:03 -0500
Subject: Re: [GIT PULL] ARC updates for 5.0 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550886303;
        bh=ljyhGZtkpiMQJIHtoiEu60v1JPN+ojBQEG8rtAjW1eA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bOb7epNYOumYIf5HqUNsrbkMNkdkaF6+Z2fg/5aTH2oqpAZP1N3SbO+pL/RMZF2Ys
         oaPxeuY4dYvE7B8FX4W2YMxIuFbiBf3a8F81FT51yPdavE4lBZj+zINNVdsXFW5Kp2
         6FyV+55RQZW9DFL5ByXKuWtQZAEhDC62vpO+a4CA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3c904d38-fba8-dfa7-fa56-4817abfd58de@synopsys.com>
References: <3c904d38-fba8-dfa7-fa56-4817abfd58de@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3c904d38-fba8-dfa7-fa56-4817abfd58de@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.0-final
X-PR-Tracked-Commit-Id: 7b2e932f633bcb7b190fc7031ce6dac75f8c3472
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cc63b39003913fdf564cde5c646ac8f174e3ac7
Message-Id: <155088630336.27298.18154293753292344819.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Feb 2019 01:45:03 +0000
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Feb 2019 09:42:38 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.0-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cc63b39003913fdf564cde5c646ac8f174e3ac7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
