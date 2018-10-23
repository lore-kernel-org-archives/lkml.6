Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983AAC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8EE20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FBgQYxUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8EE20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeJWWpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:45:10 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:28966 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbeJWWpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 18:45:09 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 903BBA1384;
        Tue, 23 Oct 2018 16:21:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received; s=mail20150812; t=1540304483; bh=Qfo2bRgtem
        Ujy0Ap6khkurKheciiK/vsNtA7V4hvs3A=; b=FBgQYxUQbVJrnC27sW8o45aKSp
        FStyH4zOaxPx8Kql3HFkRe+snD3wLi+st4shPgxkmRiCnnvvaXyZAQAkSfbl1vlF
        TbxHFbtzgpTWidB8nnua5LdvIZSpEokgEkln05077P0xyNB548Ed2Vwi/U/dNlYM
        eReiGT2AT4+ZsSSTc/mWsk8atZKWPWFKyQ5cG/yg71XviY/xW4cOHocCCTlMDFD6
        jmlmLe2lbqUrq2+9RuosaSifLHOnsbat5CQWlF/TNGJgvIYoZuLE+KJfbg2YN85m
        ghOOY/FfQ7fmJrE6wuFNyU/ZWTYybY6gD6b18TrF57mN0P6VdeUKlFpOBlsA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id h2vbYSk7-cRt; Tue, 23 Oct 2018 16:21:23 +0200 (CEST)
From:   Rainer Fiebig <jrf@mailbox.org>
To:     linux-kernel@vger.kernel.org, t@thunk.org
Cc:     NeilBrown <neil@brown.name>, Al Viro <viro@zeniv.linux.org.uk>,
        Josh Triplett <josh@joshtriplett.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
Date:   Tue, 23 Oct 2018 16:22:54 +0200
Message-ID: <1917804.q5V88l7eEq@siriux>
In-Reply-To: <20181023081144.GN1617@thunk.org>
References: <20181020134908.GA32218@kroah.com> <87r2gh70ij.fsf@notabene.neil.brown.name> <20181023081144.GN1617@thunk.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 23. Oktober 2018, 04:11:44 schrieb Theodore Y. Ts'o:
> On Tue, Oct 23, 2018 at 03:25:08PM +1100, NeilBrown wrote:
> > Yes, you could, and you can.  But if it was Linus who was behaving
> > inappropriately, where did you go then?  This is why I think whatever
> > "code" we have should be overtly a statement Linus makes about his
> > behaviour, in the first instance.
> 
> You're still missing the point, and the problem.  The concern was not
> *that* a patch was rejected, it was in *how* the patch was rejected.

And to solve *this* problem a highly controversial and politically charged
CoC had to be introduced that has already begun to divide the wider
community? Seems like a bit of an overkill to me.

And whether that CoC does come with a political agenda or is just being
*perceived* so, is irrelevant: the perception *is* the reality. And by 
embracing this CoC, Linux is now being perceived as also supporting the agenda 
that comes with it. But perhaps that was intended?

In my view you now have a new, probably even bigger problem: namely that by
adopting *this* CoC and by unyieldingly clinging to it, you have alienated 
many, if not the majority of loyal Linux-users/supporters. 

Bad choice and bad timing, now that Linux seemed ready to also take off 
in the desktop-area.

> The "problem" has never been about how Linus was treating anyone other
> than core maintainers; i.e., most of the rants that I can think of (a)
> happened years of ago, and (b) were directed at the sort of people who
> were in the room at the Maintainer's Summit yesterday.  Who which, by
> the way, didn't have a complaint about Linus's recent behavior; in
> fact, there was general agreement that Linus's behavior has been
> getting *better* over the last few years.
> 
> One of the more important effects of the CoC is that newcomers have a
> fear about Linux's reputation of having extremely toxic community.
> There is a narrative that has been constructed that because Linus
> behaves badly to everyone; and this gives everyone "permission" to
> behave badly.  Regardless of how true it may have been in the past, I
> believe that it is largely obsolete today.  And so, the mere existence
> of a CoC has caused some newcomers to say that they have "already
> noticed a difference" --- which is IMO mostly the effect of CoC easing
> fears, as opposed to any real change in Linux community in the past
> four weeks.
> 

> I think how it will work out in practice is that the CoC will be more
> a commitment about what we are holding up as community norms.
> Unfortunately, for some poeple the term "CoC" apparently acts as
> trigger language and it brings to mind legal proceedings,
> unaccountable court-like entities, and hammering people with
> punishments for petty issues with no appeal or recourse.
> 

I think you're wrong here. It's not the term "CoC" as such that brings up the 
negative associations. It is the specific choice of the CoC and its wording 
that does. And quite a few people have pointed this out already. Mitigations 
and alternatives had been offered but were ignored.

> Perhaps this is why other communities have elected to use terms such
> as "How to do Samba: Nicely" and "GNU Kind Communication Guidelines".
> All of these are trying to solve the same issue, and so my suggestion
> is let's just wait and see how things go.  If people continue to see
> that the community has "changed" for the better, and other people see
> that we're not hammering people with sanctions, but rather reminding
> each other about the kind of community we aspire to be, it'll all be
> good.
> 
> 						- Ted

Those other communities have not just chosen other terms but also chosen other 
approaches and wordings. 

In my view, the Linux-CoC stands for exactly that sort of extreme "Political 
Correctness" that is infesting our societies and has proven its destructive 
nature in more than enough instances. For some examples see [1][2][3][4][5].   

To me it feels more and more like the dark times of witch-hunts are back or 
when it was politically in-correct to say that the earth revolves around the 
sun. In those days offenders like Galilei were at least offered the choice 
between recanting and the funeral-pile. Today you may recant but you get 
publicly burnt anyway.

To see Linux falling for this is a sorry sight.


Rainer Fiebig


***
[1] https://www.ibtimes.co.uk/sacked-nobel-prize-winning-scientist-sir-tim-hunt-gets-backing-eight-fellow-laureates-1507096
[2] https://www.telegraph.co.uk/news/science/science-news/12057365/Sir-Tim-Hunt-to-leave-Britain-for-Japan-after-sexism-row.html
[3] https://en.wikipedia.org/wiki/Tim_Hunt#The_toast
[4] https://www.bbc.com/news/world-europe-45703700
[5] https://www.bbc.com/news/world-us-canada-45789819


-- 
The truth always turns out to be simpler than you thought.
Richard Feynman
