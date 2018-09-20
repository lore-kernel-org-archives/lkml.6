Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467E1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B5A214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B5A214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=christoph-conrads.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbeIUDDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:03:40 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58695 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeIUDDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:03:40 -0400
Received: from theta ([94.223.0.147]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N7zJj-1fiBTU1pg3-0155nz for
 <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 23:18:11 +0200
Date:   Thu, 20 Sep 2018 23:18:23 +0200
From:   Christoph Conrads <contact@christoph-conrads.name>
To:     linux-kernel@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
Message-Id: <20180920231823.46d282ce40c91f39988bd34e@christoph-conrads.name>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DY+wAwerHXGlJvqucxUEZ0EUHeeBkqf2SK1gXZdJ4LUqpSiX5mW
 TwEV0Mj5kK1yRP6ZP21ozDNI5O6rWrplYUnJ5siidZb2/oE1D9SdRYpChzMFWq5pc2Mw4mF
 n3aFeUS2cXB7UO5B0znt51M6JyuIMXba2M0tw2kbj0kXImXb9yYBei0fl2iNHGss9yJcOqJ
 MxXEXjpCI3OiULUfbLi4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F1rWcGr6M2U=:E1AfiG2XfoE8GmGHqfaRP8
 s2n22/2g5EynMVZhpukrUNkn/TEJOaqnq3teN/fuIYsV5rIBETYdo5+WAEFybtTu0hLExSjbE
 vO4JSmye7pZPm0r0lS+F+MXzn4pOrdWcXo5CeyqP8H3DjI3jt9P7/hlkIeCwide7fj10YA14K
 Hdn+NYXH3oTQaZnW3lVmm+rF8WwgZSnNULeyL+Z0PdHtIssJricMPOKHooingqGt24V20Hzmx
 AFO0WptA26MpqpC9emjw3J6EFeWaJ1ldQ8fGgiIeHxOGZI/lcU6P/FlmZUgoxAZkiROnOr9w4
 fk/W9JVgw0bh8rDob1ge+7copPFFVP/1EQZbgmHegnBUztdR06ioSlvxHpSzpS2q7KdUSjd64
 KDbZUKe4gt3iHVvKBhhBfYUkChutA2zmqKbX1O3lm8ozZqgnpMoA6QTQv7ptMPs1UDbRfPB3W
 6ycC47o0HrvI2ILxW0jHtoHAOx/AhQ3ELD4rzpJT2XZrSzNgbD7cnP8fZnRanJs7oylyg8EP3
 EuCvTONPTG2tnDYuRivr5MCT/p06+gnxLlXBjoKhYQN8nu1hrhvLGYhgqbTh6CBsXuH2773LB
 HrH0qPuvGgzZ5bMvKDyv7d9wbx3vwDPQV/XruAaW8RO0kzB6Q+A9kaFNdfWvxnnVanWCxVjAq
 SFvOG+8DW6Tu1s7Z2XVMec9lpDD+hiKtpUWYEp11/JtM7V+OMewfYeDxbfh1izRP4oDX8TJsZ
 qUsac8pjxZVtxtfZKzYtT9DP9EU4fwh6FRAR95mro+gK5T6metNJHtiH0htojYgRFdDO8JTWQ
 jTQ0ZOJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CoC is extremely ambiguously written for an enforceable document, any
behavior disliked by the maintainers can be punished, and the level of
naivete of the maintainers defending it is suprising for such a far reaching
document.

> In the interest of fostering an open and welcoming environment, we as
> contributors and maintainers pledge to making participation in our project
> and our community a harassment-free experience for everyone, [snip].

The CoC is an enforceable document but harassment is not defined. In the state
of New York, harassment used to be defined as written communication "in a
manner likely to cause annoyance or alarm" before the state's highest court
struck down this clause [1]. Rejecting a submitted patch is clearly annoying,
especially if it comes with a negative review attached to it.

> Examples of unacceptable behavior by participants include:
> [snip]
> * Other conduct which could reasonably be considered inappropriate in a
>   professional setting

There are already two major problems in this statement. The first problem is
that behavior is deemed unacceptable if it "could" be considered inappropriate.
In Singapore, littering the street with cigarette butts is punished with a 300$
fine or prison whereas it is legal and socially accepted in most Western
countries. Again, this is sloppy wording in an enforceable document. The second
major problem is the term "Other conduct" which includes anything done private.
That is, by contributing to the Linux kernel, you are submitting to a sloppily
written set of rules that apply in a professional setting somewhere on earth
and that cover all activities of your life. This is intolerable.

You may argue now that the private life is out of scope based on the following
sentence in the Section "Scope":

> This Code of Conduct applies both within project spaces and in public spaces
> when an individual is representing the project or its community.

Who qualifies as an individual who can represent the Linux kernel developers?
Is this every person who has ever contributed code to the Linux? Is this only
the maintainers? Do you "represent" if you mention in an online profile that
you are a contributor to Linux kernel development? If so, then you opened the
door for another OpalGate [6]. (The founder of the Contributor Covenant CoC
filed a GitHub issue because of a Twitter statement by someone advertising
himself as Opal developer.)

Finally, let us review the responsibilities of the project maintainers.
> Project maintainers have the right and responsibility to remove, edit, or
> reject comments, commits, code, wiki edits, issues, and other contributions
> that are not aligned to this Code of Conduct, or to ban temporarily or
> permanently any contributor for other behaviors that they deem
> inappropriate, threatening, offensive, or harmful.

Notice the "or". With this CoC the project maintainers have the
*responsibility* to remove content that does not meet the CoC criteria
AND they can ban anyone for ANY OTHER BEHAVIOR THEY DEEM INAPPROPRIATE.
Right there the CoC kicks any pretense of due process out of the window.
With this CoC it does not matter if you actually harassed someone or
not, only the perception of the maintainers is important. Harassment is just a
pretext.

This goes on in the next section where "unacceptable" behavior can be
reported to the Linux Foundation Technical Advisory Board (TAB). Again,
what is deemed unacceptable is never defined in the CoC.

> Instances of abusive, harassing, or otherwise unacceptable behavior
> may be reported by contacting the Technical Advisory Board (TAB) at
> <tab@lists.linux-foundation.org>. All complaints will be reviewed and
> investigated and will result in a response that is deemed necessary
> and appropriate to the circumstances.

How is the TAB supposed to "investigate"? Call hotels for the videos of
their surveillance cameras? Ask telephone companies for phone protocols?

> The project team is obligated to maintain confidentiality with regard
> to the reporter of an incident.

This confidentiality is not compatible with many legal systems and can
be viewed as obstruction of punishment. The TAB is neither a law
enforcement agency nor a law office nor are the TAB members acting as
journalists.

In addition, in many countries an accuser has to reveal itself and we
can already see at US universities how anonymous accusations followed by
investigations and rulings within universities lead to wrong decisions
and made them liable to lawsuits. The Linux Foundation (LF) is based in
the US. I wonder if the LF with its more than thousand corporate members
can be held accountable for decisions made by the TAB.


Some TAB members already stated they only want the best for kernel
development but this kind of thinking is naivete bordering on
negligence. Every supporter of every idea ever only wanted the best,
just ask the fans of Donald Trump and Hillary Clinton.

One TAB member writes [5]:
> I personally find it unlikely that relevant pressure could be applied
> on TAB members; I don't find it a prestigious role such that it is worth
> holding on to against my own values or best judgement.

The TAB gets to decide who participates in the development of an
operating system software with an estimated worth of 500 million US$, it has
a 40% market share in the server market, and it forms the basis of Android
with an 88% market share in mobile devices. Add to that political interests
and you have an uncountable number of reasons to subvert the TAB.


Now if you still think the CoC is just a set rules, let me correct you by
quoting the founder of the Contributor Covenant [2]:
> Some people are saying that the Contributor Covenant is a political
> document, and they’re right.

In another tweet, the founder writes [4]:
> Breakfast conversation with my daughter about the impossibility of
> “reverse racism” and why “all lives matter” is problematic

You may argue now that I judge the CoC by its author but I do not
believe that a person with these views wrote this document without
embedding some of these ideas in it.


Finally, Edward Cree wrote [7]
> I absolutely cannot sign up to this 'Pledge' nor accept the
> 'Responsibilities' to police the speech of others that it makes a duty
> of maintainership

Will Edward Cree face repercussions for his non-enforcement of the CoC?

> Maintainers who do not follow or enforce the Code of Conduct in good
> faith may face temporary or permanent repercussions as determined by
> other members of the project’s leadership.


[1] https://www.nytimes.com/2014/05/14/nyregion/top-court-champions-freedom-to-annoy.html 
[2] https://archive.is/xZOZ3
[3] https://lkml.org/lkml/2018/9/19/602
[4] https://archive.fo/oV4Tu
[5] https://lkml.org/lkml/2018/9/20/93
[6] https://archive.is/o/XRnb9/https://github.com/opal/opal/issues/941
[7] https://lkml.org/lkml/2018/9/19/234
