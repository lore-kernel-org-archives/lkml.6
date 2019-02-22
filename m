Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D9BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06574206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550860809;
	bh=4/mV5hCwLrzCZ5EKe5M9+1vYRLx7Zm+c0z9/7ClkDWQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xVBNh8IIKK7qnIBrJF4phFJjd/CjNj+rG4BeZq3xIdrUJmMLO/3I/PW8LY+M9wPa8
	 0feFT3UfYU+y3Q9u7JdAB6SWmZy7211TF2YsJoHjEw+nRQ0IumQkc0lRW6ThQlF0Oa
	 9/A64Obk8Eae27bHjlbYJQ65KQOqrplyqXqvFHlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfBVSkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbfBVSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:40:03 -0500
Subject: Re: [git pull] drm fixes for 5.0-rc8 (or final)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550860803;
        bh=4/mV5hCwLrzCZ5EKe5M9+1vYRLx7Zm+c0z9/7ClkDWQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j8P7md2Kh3AKabRD2qBjO2JUjaIl93APYP6oRgBCU0QaDw+27TS9pBwFQYosBvn01
         iQnx1J3KHnaeklDGtz+BIH9TwfuiTdzKzJElZYwUwNTQK4wXLJVVp0NKRuCcbkMsHu
         IWbRN+Imn4qrLd+X1xnQ/OCc1OFv1ddRiryQJhgM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz=yygXZqjnR=VwOmZ+BPjohjsHSv+i-LU+rX7zDkK90A@mail.gmail.com>
References: <CAPM=9tz=yygXZqjnR=VwOmZ+BPjohjsHSv+i-LU+rX7zDkK90A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tz=yygXZqjnR=VwOmZ+BPjohjsHSv+i-LU+rX7zDkK90A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-02-22
X-PR-Tracked-Commit-Id: 019276ed65f364de27b929da4e083bb86ce7d1ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ee2846cb4e7c6e8acdcb265299ad1c6de42b437
Message-Id: <155086080337.14712.8270624982637144893.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Feb 2019 18:40:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Feb 2019 10:13:42 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ee2846cb4e7c6e8acdcb265299ad1c6de42b437

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
