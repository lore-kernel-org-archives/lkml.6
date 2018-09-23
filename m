Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660B4C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A27C20989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A27C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thyrsus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeIXC6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 22:58:40 -0400
Received: from thyrsus.com ([71.162.243.5]:52128 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbeIXC6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 22:58:40 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Sep 2018 22:58:40 EDT
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 59F8B3A42A5; Sun, 23 Sep 2018 16:50:52 -0400 (EDT)
From:   esr@thyrsus.com (Eric S. Raymond)
To:     linux-kernel@vger.kernel.org
Subject: On holy wars, and a plea for peace
Message-Id: <20180923205052.59F8B3A42A5@snark.thyrsus.com>
Date:   Sun, 23 Sep 2018 16:50:52 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of you know that I have spent more than a quarter century
analyzing the folkways of the hacker culture as a historian,
ethnographer, and game theorist. That analysis has had large
consequences, including a degree of business and mainstream acceptance
of the open source way that was difficult to even imagine when I first
presented "The Cathedral and the Bazaar" back in 1997.

I'm writing now, from all of that experience and with all that
perspective, about the recent flap over the new CoC and the attempt
to organize a mass withdrawal of creator permissions from the
kernel.

I'm going to try to keep my personal feelings about this dispute
off the table, not because I don't have any but because I think
I serve us all better by speaking as neutrally as I can.

First, let me confirm that this threat has teeth.  I researched the
relevant law when I was founding the Open Source Initiative. In the
U.S. there is case law confirming that reputational losses relating to
conversion of the rights of a contributor to a GPLed project are
judicable in law.  I do not know the case law outside the U.S., but in
countries observing the Berne Convention without the U.S.'s opt-out of
the "moral rights" clause, that clause probably gives the objectors an
even stronger case.

I urge that we all step back from the edge of this cliff, and I weant
to suggest a basis of principle on which settlement can be negotiated.

Before I go further, let me say that I unequivocally support Linus's
decision to step aside and work on cleaning up his part of the process.
If for no other reason than that the man has earned a rest.

But this leaves us with a governance crisis on top of a conflict of
principles.  That is a difficult combination. Fortunately, there is
lots of precedent about how to solve such problems in human history.
We can look back on both tragic failures and epic successes and take
lessons from them that apply here.

To explain those lessons, I'm going to invite everybody to think like
a game theorist for a bit.

Every group of humans trying to sustain cooperation develops an ethos,
set of norms.  It may be written down. More usually it is a web of
agreements that one has to learn by observing the behavior of others.
The norms may not even be conscious; there's a famous result from
experimental psychology that young children can play cooperative games
without being able to articulate what their rules are...

Every group of cooperating humans has a telos, a mutually understood
purpose towards which they are working (or playing). Again, this
purpose may be unwritten and is not necessarily even conscious. But
one thing is always true: the ethos derives from the telos,
not the other way around. The goal precedes the instrument.

It is normal for the group ethos to evolve. It will get pulled in one
direction or another as the goals of individuals and coalitions inside
the group shift. In a well-functioning group the ethos tends to evolve to
reward behaviors that achieve the telos more efficiently, and punish
behaviors that retard progess towards it.

It is not normal for the group's telos - which holds the whole
cooperation together and underpins the ethos - to change in a
significant way.  Attempts to change the telos tend to be profoundly
disruptive to the group, often terminally so.

Now I want you to imagine that the group can adopt any of a set of ethoi
ranked by normativeness - how much behavior they require and prohibit.
If the normativeness slider is set low, the group as a whole will tolerate
behavior that some people in it will consider negative and offensive.
If the normativeness level is set high, many effects are less visible;
contributors who chafe under restriction will defect (usually quietly)
and potential contributors will be deterred from joining.

If the normativeness slider starts low and is pushed high, the
consequences are much more visible; you can get internal revolt
against the change from people who consider the ethos to no longer
serve their interests.  This is especially likely if, bundled with a
change in rules of procedure, there seems to be an attempt to change
the telos of the group.

What can we say about where to set the slider?  In general, the most
successful - most inclusive - cooperations have a minimal ethos.  That
is, they are just as normative as they must be to achieve the telos,
*and no more so*.  It's easy to see why this is. Pushing the slider
too high risks internal factional strife over value conflicts. This is
worse than having it set too low, where consensus is easier to
maintain but you get too little control of conflict between
*individuals*.

None of this is breaking news. We cooperate best when we live and let
live, respecting that others may make different choices and invoking
the group against bad behavior only when it disrupts cooperative
success. Inclusiveness demands tolerance.

Strict ethoi are typically functional glue only for small groups at
the margins of society; minority regious groups are the best-studied
case. The larger and more varied your group is, the more penalty there
is for trying to be too normative.

What we have now is a situation in which a subgroup within the Linux
kernel's subculture threatens destructive revolt because not only do
they think the slider been pushed too high in a normative direction,
but because they think the CoC is an attempt to change the group's
telos.

The first important thing to get is that this revolt is not really
about any of the surface issues the CoC was written to address.  It
would be maximally unhelpful to accuse the anti-CoC people of being
pro-sexism, or anti-minority, or whatever. Doing that can only inflame
their sense that the group telos is being hijacked.  They make it
clear; they signed on to participate in a meritocracy with reputation
rewards, and they think that is being taken way from them.

One way to process this complaint is to assert that the CoC's new
concerns are so important that the anti-CoC faction can be and
should be fought to the point where they withdraw or surrender.
The trouble with this way of responding is that it *is* in fact
a hijacking of the group's telos - an assertion that we ought to
have new terminal values replacing old ones that the objectors
think they're defending.

So a really major question here is: what is the telos of this
subculture?  Does the new CoC express it?  Have the objectors
expressed it?

The question *not* to get hung up on is what any individual's
choice in this matter says about their attitude towards, say,
historically underepresented minorities.  It is perfectly
consistent to be pro-tolerance and pro-inclusion while
believing *this* subculture ought to be all about producing
good code without regard to who is offended by the process.
Not every kind of good work has to be done everywhere. 
Nobody demands that social-justice causes demonstrate
their ability to write C.

That last paragraph may sound like I have strayed from neutrality into
making a value claim, but not really.  It's just another way of saying
that different groups have different teloi, and different ethoi
proceeding from them.  Generally speaking (that is, unless it commits
actual crimes) you can only judge a group by how it fulfills its own
telos, not those of others.

So we come back to two questions:

1. What is our telos?

2. Given our telos, do we have the most inclusive (least normative)
   ethos possible to achieve it?

When you have an answer to that question, you will know what
we need to do about the CoC and the "killswitch" revolt.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

The spirit of resistance to government is so valuable on certain occasions, 
that I wish it always to be kept alive.  It will often be exercised when 
wrong, but better so than not to be exercised at all. I like a little 
rebellion now and then.	-- Thomas Jefferson, letter to Abigail Adams, 1787
