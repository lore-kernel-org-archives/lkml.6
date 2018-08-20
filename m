Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F909C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E004221735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E004221735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeHTWnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:43:41 -0400
Received: from fieldses.org ([173.255.197.46]:45002 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeHTWnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:43:40 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 7A4E4189; Mon, 20 Aug 2018 15:26:49 -0400 (EDT)
Date:   Mon, 20 Aug 2018 15:26:49 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH] signal: Don't send signals to tasks that don't exist
Message-ID: <20180820192649.GF5468@fieldses.org>
References: <87efft5ncd.fsf_-_@xmission.com>
 <20180724032419.20231-7-ebiederm@xmission.com>
 <87k1orgdoo.fsf_-_@xmission.com>
 <CACT4Y+bYFatW=CMgH4M6AjtjO297gbQ8xwnEV0_f7J64FLQ4QQ@mail.gmail.com>
 <87pnyg7rw3.fsf@xmission.com>
 <20180817122414.df0eee974434d170b1a54c31@linux-foundation.org>
 <87bma01aul.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bma01aul.fsf@xmission.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 12:51:14AM -0500, Eric W. Biederman wrote:
> I was dismayed when I saw the syzbot report triggered someone to remove
> themselves from MAINTAINERS.

You're talking about my patch?  I think you misread it, I'm not removing
myself from MAINTAINERS.

--b.
