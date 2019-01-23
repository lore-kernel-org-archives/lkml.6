Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFF5C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0822D21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfAWXfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:35:31 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:37403 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfAWXf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:35:29 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0NNZRjm042371;
        Thu, 24 Jan 2019 08:35:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Thu, 24 Jan 2019 08:35:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0NNZRA8042365;
        Thu, 24 Jan 2019 08:35:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x0NNZRWw042364;
        Thu, 24 Jan 2019 08:35:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201901232335.x0NNZRWw042364@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH v3 1/2] mm, oom: fix use-after-free in
 =?ISO-2022-JP?B?b29tX2tpbGxfcHJvY2Vzcw==?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Date:   Thu, 24 Jan 2019 08:35:27 +0900
References: <20190123225747.8715120856@mail.kernel.org> <CALvZod5h7fSoZTA+3bDTn93JuFgY=SUGEq=gpDYE8rdSfuNcPQ@mail.gmail.com>
In-Reply-To: <CALvZod5h7fSoZTA+3bDTn93JuFgY=SUGEq=gpDYE8rdSfuNcPQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shakeel Butt wrote:
> > How should we proceed with this patch?
> >
> 
> We do want to backport this patch to stable kernels. However shouldn't
> we wait for this patch to be applied to Linus's tree first.
> 

But since Andrew Morton seems to be offline since Jan 11, we don't know
when this patch will arrive at Linus's tree.
