Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDA4ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 22:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6982087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 22:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6982087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeIQDji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 23:39:38 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:42876 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeIQDji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 23:39:38 -0400
X-Greylist: delayed 1969 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Sep 2018 23:39:36 EDT
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1g1eoE-0002o1-LO; Sun, 16 Sep 2018 23:42:26 +0200
Date:   Sun, 16 Sep 2018 23:42:26 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [...] an apology, and a maintainership note
Message-ID: <20180916214226.nmjqk55cxobsjayd@angband.pl>
References: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 12:22:43PM -0700, Linus Torvalds wrote:
> This is my reality.  I am not an emotionally empathetic kind of person
> and that probably doesn't come as a big surprise to anybody.  Least of
> all me.  The fact that I then misread people and don't realize (for
> years) how badly I've judged a situation and contributed to an
> unprofessional environment is not good.
> 
> This week people in our community confronted me about my lifetime of
> not understanding emotions.  My flippant attacks in emails have been
> both unprofessional and uncalled for.  Especially at times when I made
> it personal.  In my quest for a better patch, this made sense to me.
> I know now this was not OK and I am truly sorry.
> 
> The above is basically a long-winded way to get to the somewhat
> painful personal admission that hey, I need to change some of my
> behavior, and I want to apologize to the people that my personal
> behavior hurt and possibly drove away from kernel development
> entirely.

Despite me being just among bottom-rung popcorn of kernel contributors, let
me says this:

No.  Just no.  You're so successful because you're one of few people who
don't waste time beating around the bush.  You call a spade a spade instead
of polite "professional" bullshit.

You often use rude words, but you don't do so without a reason.  IMO your
most striking quality is not technical ability (pretty high...) but the
ratio of times you open your mouth to the times you're right.  And even
if you're not right, you don't take offense at getting corrected and
immediately admit someone else was right.  

Sure, there are cases when both choices are right, but your approach avoids
wasting time making a decision.  For example: recently, you forced disabling
string truncation warnings despite many people feeling otherwise.  I for one
believe GCC's warnings even though sounding bogus are good for eliminating
strncpy -- what I would have done would be giving it an aliased version
named "fixedfieldncpy" or such that disables the warning, and fixing the
whole rest.  But what you did instead deprioritizes the issue: the kernel
doesn't work any worse than it did with gcc-7, thus there are indeed more
urgent matters elsewhere.  So even if I don't fully agree with you, you are
the boss and as long as your version is acceptable, let's stick to it.

And, it's _you_ who has proven merit, not me.

> I am going to take time off and get some assistance on how to
> understand people’s emotions and respond appropriately.
> 
> Put another way: When asked at conferences, I occasionally talk about
> how the pain-points in kernel development have generally not been
> about the _technical_ issues, but about the inflection points where
> development flow and behavior changed.

Too many projects get detracted by prolonged crap about social things, don't
let this pull you down.  There's a problem when people _without merit_ are
rude -- those indeed need to get a spanking.  A spanking not ADHD meds.
Short and to the point, letting them learn.

But you, you _earned_ the right to be rude to get your point across.
I watched a video about you getting shamed on a DebConf because of breaching
some "code of conduct" by using a naughty word.  I didn't like that and
believe it was you who was right (I don't recall the details though).

> I've talked to Greg to ask him if he'd mind finishing up 4.19 for me, so
> that I can take a break, and try to at least fix my own behavior.
> 
> This is not some kind of "I'm burnt out, I need to just go away"
> break.  I'm not feeling like I don't want to continue maintaining
> Linux. Quite the reverse.  I very much *do* want to continue to do
> this project that I've been working on for almost three decades.
> 
> This is more like the time I got out of kernel development for a while
> because I needed to write a little tool called "git".  I need to take
> a break to get help on how to behave differently and fix some issues
> in my tooling and workflow.

You do deserve a vacation.  By all means, do take a break and let the
community rehearse for "Linus got mauled by a bear".  But we want you back.

> And yes, some of it might be "just" tooling.  Maybe I can get an email
> filter in place so at when I send email with curse-words, they just
> won't go out.  Because hey, I'm a big believer in tools, and at least
> _some_ problems going forward might be improved with simple
> automation.

Please don't.  When you use curse words, they're _warranted_.  They're a
tool which, in my opinion, you don't overuse.

And it's fun to listen to a true master of words.  An example: how many
pages would https://lkml.org/lkml/2016/8/2/2062 take to say politely yet get
the same effect?

> I know when I really look “myself in the mirror” it will be clear it's
> not the only change that has to happen, but hey...  You can send me
> suggestions in email.

When you look yourself in the mirror, I want you to see that guy who codes
in a bathrobe instead of a sweet-talking lying politician.  Being honest
means sometimes saying non-nice things.


Meow!
-- 
Don't be racist.  White, amber or black, all beers should be judged based
solely on their merits.  Heck, even if occasionally a cider applies for a
beer's job, why not?
On the other hand, mass-produced lager is not a race.
