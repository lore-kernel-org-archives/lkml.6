Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E6DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDB52152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDB52152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=christoph-conrads.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbeITSfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:35:10 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387825AbeITSfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:35:09 -0400
Received: from theta ([94.223.0.147]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N4yNG-1fddTg0mwO-010xaR for
 <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 14:51:44 +0200
Date:   Thu, 20 Sep 2018 14:51:55 +0200
From:   Christoph Conrads <contact@christoph-conrads.name>
To:     linux-kernel@vger.kernel.org
Subject: The Contributor Covenant Code of Conduct is Dangerous
Message-Id: <20180920145155.43d7a4645e743d4fbbd1693b@christoph-conrads.name>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NAX7D/2rHKgdiW7A2M7rnHKcUU65AtRLarULObOKdEKYTRvSUnw
 oqSYclDQBrmHHNk163YXRiaMxNZ7cadGxMUrMAQsVVRy15PJiQj6u39DMaIHCa7av/hMV33
 NOFFGY8tX16MkouHJcocGFQIzwIqKoY6HickITHAK/GPae89R0ZeprIDUcvH2MlcWK7X/lH
 7Bj5MH83XhfS/aRrjOiIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8mmcDPt5sjI=:28R98SAKTWUzPk8tk7n+Ko
 JKABzx91fKXWdY5XW6YgU9PlwEIxj57lW8y9FsHHYsD/r4WrX01GNN0l2txOyu9t1P5IafGKV
 43v0yYcyfb1f673yXvDAofcJAjLy+FSvvb/ZkaeM/hq0etsxUxGgjBqeG24/NlIAvYWfU6j0V
 2i9J8J0W2UTQ1cuU4mzYYKv2IL0N4KfprSb9C2zZhvPOr30boIymzTQVs7LAzmeSk6o2cs+7O
 sRT0FTjgihg0IJowl7J2K7bZCMyqAKHs3qajaw1wA0G5/tuS+hOv0pD3SqPwVsfcXIeUQNc4Z
 090SmxNlMF89dgQrOnXGV1f3Nfb4C8snXkd8ILM+U5KU/zn7Md+pvgdl7rE2gjIlPrqkKtrzk
 5B6YmuKh2yZTY9HwuXVyL3uSMWJ6+KDafBJNcfnY5sd/pOqhe6QnBVOfpbrNkjyP0bOBvj89p
 kfLbHUJOyIko18cY6NN0ZFdKikb5qodr/uiFMzCNrk1YYlR1Dnj3BQ/MvVvi7fnWdwJ6uv7Mf
 8pMw9xr/9YwnIR4L8cfcfiz+qKQ2QtKy6eA0Ds5NOkAPqycifTKjzkktN1ZfZXGsigU/z7v9Y
 ela0CVoH6hpuJ3BDhi5t2qNF76ejlUahI1IWA2RWBhfGZIAZP2ojuEDc5/v4v7KD8F0uUgV9c
 PXthG8yr6Xld2htHocVGgqKBcPyyrtRNhSN/Ug9ZFkLq5cSrbTt8LEETrQeN7X21T3/hkH04u
 +Ci20WU5unAdyMyMRGTwmWTRJwVYEos9WUI2VgXbppFm4QzYfYxt6QzzcFmcdmyBSX6Ed4Jq0
 +9eJHuh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To whom it may concern,

in this e-mail I will highlight what is fundamentally wrong with Contributor
Covenant Code of Conduct (CoC for short).

> Examples of unacceptable behavior by participants include:
> [snip]
> * Other conduct which could reasonably be considered inappropriate in a
>   professional setting

The wording is already very vague for an enforceable document. What is
considered appropriate in a professional setting is different across the
world. There are two major problems in this statement. The first problem is
that behavior is deemed unacceptable if a behavior "could" be considered
inappropriate. In Singapore, littering the street with cigarette butts is
punished with a 300$ fine or prison whereas it is legal and socially accepted
in most Western countries. Again, this is sloppy wording in an enforceable
document. The second major problem is the term "Other conduct" which includes
anything done private. That is, by contributing to the Linux kernel, you are
submitting to a sloppily written set of rules that apply in a professional
setting somewhere on earth and that cover all activities of your life. This is
intolerable.

In the fourth, the latest version of the the CoC, it says at the beginning

> In the interest of fostering an open and welcoming environment, we as
> contributors and maintainers pledge to making participation in our project
> and our community a harassment-free experience for everyone, regardless of
> age, body size, disability, ethnicity, sex characteristics, gender identity
> and expression, level of experience, education, socio-economic status,
> nationality, personal appearance, race, religion, or sexual identity and
> orientation.

The CoC is an enforceable document but harassment is not defined. According to
[1], in some states of the USA, harassment is written communication "in a
manner likely to cause annoyance or alarm".  Rejecting a submitted patch is
clearly annoying, especially if it comes with a negative review attached to
it.


Finally, let us review the responsibilities of the project maintainers.
> Project maintainers have the right and responsibility to remove, edit, or
> reject comments, commits, code, wiki edits, issues, and other contributions
> that are not aligned to this Code of Conduct, or to ban temporarily or
> permanently any contributor for other behaviors that they deem
> inappropriate, threatening, offensive, or harmful.

Basically, the project maintainers have the right to do anything with
respect to kernel development and they may ban developers for
inappropriate behavior.

The CoC and its imprecise wording is enforced by the Linux Foundation
Technical Advisory Board (TAB). The TAB get to decide who is allowed to
contribute to the Linux kernel and who is not. By extension, the TAB
members get to enforce for how long the CoC is in place. The CoC members
are voted for at the kernel summit [3] but here is the catch: If the TAB
banned a person, then the person is also banned from the kernel summit;
this person can neither vote nor be voted for. If a TAB member refuses
to ban a person from the kernel summit, this particular TAB member may
be banned by the other TAB members because it failed to enforce the CoC
-- in the eyes of the other TAB members. This follows from the last
paragraph in the Section "Enforcement".

> All complaints will be reviewed and investigated and will result in a
> response that is deemed necessary and appropriate to the circumstances.

The TAB also get to investigate accusations and be judges at the same
time. I am not aware of any legal system I want to be subjected to with
such a structure.

> The project team is obligated to maintain confidentiality with regard
> to the reporter of an incident.

This confidentiality is not compatible with many legal systems and can
be viewed as obstruction of punishment. The TAB is neither a law
enforcement agency nor a law office nor are the TAB members acting as
journalists.

In addition, in many countries an accuser has to reveal itself and one
can already see at US universities how anonymous accusations followed by
investigations and rulings by the same group of people at the university
lead to wrong decisions and made them liable to lawsuits. The Linux
Foundation (LF) is based in the US. I wonder if the LF with its more
than thousand corporate members can be held accountable for decisions
made by the TAB.


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


[1] https://definitions.uslegal.com/h/harassment/
[2] https://archive.is/xZOZ3
[3] https://lkml.org/lkml/2018/9/19/602
[4] https://archive.fo/oV4Tu
[5] https://lkml.org/lkml/2018/9/20/93
