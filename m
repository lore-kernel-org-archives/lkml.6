Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ECDC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A957A2084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549069208;
	bh=UEHwYjcDjznQcfUDUy9ckJmTn2WbWX+iCdoiKYuGG0E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dsEoM3s3MirVCzrNDLN0E072isMuDlkRLUtCGbn8/zeD07WMa82MJF6GXcNQdmdyk
	 wbSbG1ZmBzZJtNFHhRdpmN1RYhppBWpP6lKXmRYgKTKnqXtQC/4EynZ66NhghmriyC
	 ER/7OscJFO2S+W983202KgGpFeckS/+mlaVTPYjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfBBBAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:00:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfBBBAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:00:04 -0500
Subject: Re: [PULL 0/9] xtensa fixes for v5.0-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549069204;
        bh=UEHwYjcDjznQcfUDUy9ckJmTn2WbWX+iCdoiKYuGG0E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZFYiVtIgT+o3HmtmEJbijSq1/dmDTc7tghLiGxhm5S3VPOOv0WVVHTtCpu/h7hpwZ
         lV952xfpwXTSzduNPsxsRZpvl+ZceXd6q3e0+Z+ZIFwI9KkNVSc3FkJRrWj60f23Sx
         tG/Av68kpPOaJqO+p+02CD3aoE2b7wE3OP4lx3Tw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190201194047.13667-1-jcmvbkbc@gmail.com>
References: <20190201194047.13667-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190201194047.13667-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20190201
X-PR-Tracked-Commit-Id: 25384ce5f9530def39421597b1457d9462df6455
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd984a5be21549273a3f13b52a8b7b84097b32a7
Message-Id: <154906920456.30832.1949915395622977998.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Feb 2019 01:00:04 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  1 Feb 2019 11:40:47 -0800:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190201

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd984a5be21549273a3f13b52a8b7b84097b32a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
