Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420B9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95A7218F9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95A7218F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeHRAmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 20:42:07 -0400
Received: from nautica.notk.org ([91.121.71.147]:37198 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeHRAmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 20:42:07 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 9C795C009; Fri, 17 Aug 2018 23:37:03 +0200 (CEST)
Date:   Fri, 17 Aug 2018 23:36:48 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [GIT PULL] 9p updates for 4.19
Message-ID: <20180817213648.GA31406@nautica>
References: <20180813012347.GA32555@nautica>
 <20180817023307.GA32726@nautica>
 <CA+55aFzLe7C03-53=0WrXXfZcfsJfTsvRqrrBNqnLvOxUiCJqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFzLe7C03-53=0WrXXfZcfsJfTsvRqrrBNqnLvOxUiCJqQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote on Fri, Aug 17, 2018:
> So this pull request confuses me, and that's not a good thing.

I'll hopefully do better next time! Thank you for taking the time to
explain.


> On Thu, Aug 16, 2018 at 7:33 PM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> >
> > Pull request for inclusion in 4.19 for 9p
> 
> So when I pull the tag, I get a different message, talking about
> 
>   This tag is the same as 9p-for-4.19 without the two MAINTAINERS patches
> 
> but I never saw a first version.

I thought the the same thing (that you never saw the first version) when
I wrote the request-pull email and adjusted the text -- I wasn't aware
the tag should have the same text as the mail but will pay attention to
that in the future, it does make sense.

For the background, I had used 9p-for-4.19 in a mail to v9fs-developer
asking for testing earlier this week, it is still in the repo as another
signed tag if you'd like to confirm.
I removed the "MAINTAINERS patches" when Andrew picked them up shortly
after the original mail and made the second tag back then.


> And it comes from a github address, with a pgp key that I've not seen
> before, and without me having been told about said maintainership
> updates. And while the  key has a lot of signatures, none of them are
> any that I have recognized previously from kernel development.

I agree on this point, and will have a different key with at least some
kernel developers signatures for 4.20 (which will be confusing again as
my key changes, but at least it shold have people you recognize).
I cannot say anything other than "I was not sufficiently prepared" for
4.19 and used whatever key I normally use after checking on pathfinder
that it was still "closeish" to you.

On the maintainership update, while it wasn't direct I believe Andrew
brought it up when adding me to the Cc of a 9p security report after you
added the current maintainers recently -- but, well, yes, it's not like
being told directly.
He has the MAINTAINER file update and am sure will send it to you
shortly so if preferable I can wait until he sends them to you and send
this PR (with a better tag) again at this point?


Thank you,
-- 
Dominique Martinet
