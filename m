Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0037CC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A952D2196E
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549745106;
	bh=EVYCy6QS5YVZQv7jZl6zXGGo5jz2PnUNXUN8pSXSt0w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UXkkQewwwd49actJIfGn0lfXfSjMfJZhpcpo/53aRlJbd6S3J0FdDeeSue0qAWQSj
	 B8UHdZuabygqjKFDMwTbVVYLRkJi3zLbsBmWWz4GWYcRL//ZqrSBR+LBaA4Vcw617K
	 mXERK1c9c26fKjikQvPM31g1G+Naswg71WTco7e8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBIUpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfBIUpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 15:45:04 -0500
Subject: Re: [GIT PULL] mtd: Fixes for 5.0-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549745104;
        bh=EVYCy6QS5YVZQv7jZl6zXGGo5jz2PnUNXUN8pSXSt0w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W3CzS/3bjRBoqOtKTj5LwJvYWgsePq68ehnJlTEvK77ySiJBXnW3hbyZyh1nvkEVn
         oEgpzxNHvH6mgPWp103ye+HUtus4p9uEQrv0DqjV2/Wo1MJ91DDa6d4KuE4pa/8CfA
         vdSKy6bxC3nwef5ziQ4p4MnW9ZFEuKxldUn6UYP4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190209111454.21c8c23b@collabora.com>
References: <20190209111454.21c8c23b@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190209111454.21c8c23b@collabora.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-mtd.git
 tags/mtd/fixes-for-5.0-rc6
X-PR-Tracked-Commit-Id: d5d27fd9826b59979b184ec288e4812abac0e988
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5610789ad08dacfd96fd684b53d7acd9e628ca20
Message-Id: <154974510394.20101.11534030725064580087.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 20:45:03 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Feb 2019 11:14:54 +0100:

> git://git.infradead.org/linux-mtd.git tags/mtd/fixes-for-5.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5610789ad08dacfd96fd684b53d7acd9e628ca20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
