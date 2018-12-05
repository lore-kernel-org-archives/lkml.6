Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2077C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B893C20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544054103;
	bh=HUz82n8L2IJA3I0q6FgCBHa5c4WqqSiamfSOkU4KMD8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sXhaWqZARPc4X/Nr0XcaoM3cnnJlz8avxRzxuS/I+CZeJfxsZ9XKU6yp06G9UbuXe
	 KpgTTXGqcpPLhbGi1xdfWCD7t1g4qbMdxidUkdeNeo7vJxaGbCkh7BlxRxtRmY5zZ7
	 od2gWNCiv4BlwzoYnl1nGeDtoxEzM9/IaX9qu0rI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B893C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbeLEXzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:55:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbeLEXzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:55:01 -0500
Subject: Re: [GIT PULL] ARC updates for 4.20-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544054101;
        bh=HUz82n8L2IJA3I0q6FgCBHa5c4WqqSiamfSOkU4KMD8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X8UMnuioA40vIKzd7o3KNAA2rtjRdho0fqIqiDbiBbOZGh2zztXTw1s6QHgL7cZ2u
         IsxVd0sgRmdzSaz+ImQ+KM7/tCR6ZfUpfmNXGyZmdZLQ7y0ZjhZo8qv1DXJc5VwvSP
         f//EOgmjVmat+weTohuM0p/wio38GcV/aqUoJ4D4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c156a393-7f72-4606-b8fd-d976e8565f52@synopsys.com>
References: <c156a393-7f72-4606-b8fd-d976e8565f52@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c156a393-7f72-4606-b8fd-d976e8565f52@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-4.20-rc6
X-PR-Tracked-Commit-Id: 10d443431dc2bb733cf7add99b453e3fb9047a2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 369af92ce47a04b2523ec4feea1febcacf8419b1
Message-Id: <20181205235501.7141.36849.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Wed, 05 Dec 2018 23:55:01 +0000
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "Eugeniy Paltsev" <Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Dec 2018 15:46:35 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-4.20-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/369af92ce47a04b2523ec4feea1febcacf8419b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
