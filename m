Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A9FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16AA20880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16AA20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbeITKAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:00:14 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34085 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeITKAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:00:14 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w8K4IkHn004536;
        Thu, 20 Sep 2018 06:18:46 +0200
Date:   Thu, 20 Sep 2018 06:18:46 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Olof Johansson <olof@lixom.net>
Cc:     Edward Cree <ec429@cantab.net>, Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180920041846.GA4418@1wt.eu>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

I expected not to participate to this boring discussion, but I think
I need to make a point below :

On Thu, Sep 20, 2018 at 02:16:40AM +0100, Olof Johansson wrote:
> Another common counter argument is that the code of conduct is
> imposing what's appropriate thoughts and opinions on everybody. I can
> see how that kind of environment _could_ be implemented with the same
> code of conduct as a base, but it doesn't have to be and I know I
> would fight strongly against that. I much prefer all be free to have
> their opinions, but at the same time be respectful of each other when
> we communicate. There are extreme edge cases but they're theoretical
> at this point.
> 
> Disagreements are fine to have, and in many cases they lead to better
> solutions in the end. What's not OK to me is when they veer off of the
> path of respectful and productive discussion.

The reason people are concerned is a matter of culture.

There simply is *no* way to have a completely respectful *and*
productive discussion which works fine around the globe because
people don't have the same emotional offsets when they send and
when they receive.

In some eastern Europe countries someone would naturally say "you're
completely wrong" without any mean intent. In western Europe, people
would instead say "I disagree with you" and in the US they will say
"let me think about it". All of these mean the same thing when they
speak to people of the same culture, but are taken as very slick or
even hypocrit sayings when going from one direction, or as abusive
when going the other direction.

Is this a problem and if so, what can be done about it ? It's a
temporary issue only which will continue to appear from time to time
in various discussions. However, the CoC should be used as a reminder
to both parties during strong arguments :

  - the sender should take a look at the CoC as a reminder and see
    the difference between insults and just having a strong
    argument, and sometimes say "OK excuse me for this one"

  - the receiver who feels he's not respected should take a look at
    the CoC and think that very likely the sender tries to comply
    with it and think twice considering that what he feels is an
    insult might just be a way of expressing oneself in another
    culture and should not be taken personal.

In my opinion there is a reason why a number of those who people
fear originate from Europe, and there's a reason why those who need
to invent CoC because they feel not respected come from US. It's
just a matter of different culture. None of them are wrong, but it
hurts more one way than the other one. The other way around also
exists (i.e.: "this person bores me") and can be detrimental to
productive code as well if contributors are not trusted by being
"too slick", but then nobody feels hurt and nobody complains about
it.

Personally I don't take the CoC as a rule but just as a guideline and
a reminder that there are people out there who could feel shocked by
my words without me understanding why. It's also these people's
responsibility to report this to me so that I can learn to better
communicate with them in a way that doesn't hurt their sensitivity.

I personally never felt hurt by the words of anyone here, including
Linus telling me things around "you're stupid" because that's the
natural way to express a disagreement in my culture and I understand
it in a way which other people would probably translate to "dear
willy, please listen to me more carefully because I think it might
be the third time I try a different approach to explain this to you".

For some people the latter is more appropriate, but I personally hate
its efficiency and I strongly prefer the former. However I can
understand that other people would prefer the latter and that's
where it seems to me that senders should make the effort to be half
ways between the two and receivers should make the effort to think
that a half-way sentence means one or the other depending on their
culture but that they are similar and not irrespectful.

I would not be surprised if most of the people having issues with
the CoC were mostly european and if the people who feel protected
by it are mostly US-based (please note that I'm saying "mostly",
I'm not cutting the world between two sides). It's just that the
document tries to address ones' sensitivity at the expense of the
ability to use natural ways to express oneself for other ones, and
some can feel a bit censored. I tend to think that the doc should
talk about cultural differences and translation issues when turning
natural language to English before starting to speak about insults
or attacks, but that's not very important IMHO.

Overall I'm not worried by what's in this file, people will make a
lot of noise about it for two weeks, will explain how hypocrit they
feel it is or how insufficient it is to protect their sensitivity,
nobody will change much the way they communicate, but over time
people will learn to think "maybe he didn't really mean this", and
that will already be a step forward. We'll see in Greg's next annual
report if this has a negative implication on the number of commits
per hour, since in the end it's all that matters (and I bet it won't).

Regards,
Willy
