Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9ADC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46712172A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="HRVzr5D4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46712172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeI1FXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:23:22 -0400
Received: from cock.li ([185.100.85.212]:56840 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbeI1FXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:23:21 -0400
From:   curious <curious@redchan.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1538089359; bh=fQn7+RS+wRYUv4JcH394PJ4THP1fUezZfLcPKenoRLE=;
        h=From:Subject:To:Cc:Date:From;
        b=HRVzr5D4/u2oOVBvCtb1BKMkbEDBag6m4ALwd/sLxv4Flda6JNK1gaLtGGfa3WrQL
         ZShJcHquo27uh4++WeMy+zyB5qV36hd+bt3Ir3Smx4qN+pLl6oFyU7gDtKznYs7ixe
         /F3YrBPda1pbHCWPddY5IfmW9ppBrX8txHCLC7pg76h8fh5kGHg7dwLLzN1F+VwvFQ
         O6Pfkxq1bUnklCo4g1xhOsIHHDARfTlZPLQ8lARabK1o13HSWYRCz4nNWQFJa/eQ7w
         NowL2W2OmeyRdXEs6kf+iZFC5uxDrPMnjNgBDj3eOUxnufAWiSGlE7DqKGpU7d0z6I
         n968XMLlhGxRA==
Subject: Linus Torvalds: Reconsider adopting the Contributor Covenant
X-Enigmail-Draft-Status: N1110
To:     linux-kernel@vger.kernel.org
Cc:     adeleradul@redchan.it
Message-ID: <5BAD6176.1070906@redchan.it>
Date:   Thu, 27 Sep 2018 19:02:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus Torvalds:

We are two fans of Linux who really enjoy the operating system you
started and the ecosystem that built up around it. We have been using
Linux in its various flavors (distros) as our main operating system
for years as we wanted an alternative to Windows and macOS that could
handle the everyday internet-based tasks that one would expect to be
able to do on a modern computer.

We understand that you have had second thoughts about your behavior
towards those who contribute to Linux development, especially when
critizing code that may not be up to scratch, and we do appreciate you
for considering the impact of your behavior. However, we are writing
you because we are concerned about several possible implications that
the recently introduced Code of Conduct could have on Linux and the
ecosystem as a whole.

On the surface, the Code of Conduct that was adapted from the
Contributor Convenant appears laudable: an expectation of a hassle
free enviornment despite any individual contributors' physical and/or
social characteristics, examples of positive behaviors that would like
to be seen of contributors, and examples of negative behaviors that
need to avoided (and we do see that the examples given are often seen
in the behavior of those who harass others over the Internet).

What we do have issue with is the origins of, the ideology behind, and
the behaviors exhibited by those who promulgate this code of conduct
as the solution to alleged social ills within the tech community. The ideas
expressed in the Contributor Convenant come from Social Justice, which
also on the surface appears laudable: the recognition and reparation
of past societal wrongs and activism towards ensuring equality for
historically oppressed groups. However, we have observed the actual
behavior of those who follow Social Justice, often referred to as
"Social Justice Warriors" or "SJWs," to be less than sincere.

So-called Social Justice Warriors have been observed to show rather
hypocritical bullying behavior towards those they disagree with, both
online and in real life, while still claiming to be doing laudable
activism. Most of the harassing behavior by Social Justice Warriors we
have observed is often perpetrated towards those historically
considered to be oppressor groups (often not letting the target redeem
themselves or recognizing they have disposed of certain
"privileges"). But we have also seen that Social Justice Warriors will
harass those they claim to champion if they do not wholly and
uncritically agree with their beliefs and ideology.

The wording of the Code of Conduct, as well as the Contributor
Covenant have been observed by posters on various websites as being
rather vague and open for abuse by those not above playing
victim. Rather more specifically, those so inclined could seemingly
choose to take offense at certain remarks or actions (regardless of
whether or not the person is actually offended), and then call for the
ousting of those they've (chosen to) see as harassers. It has been
feared that the Code of Conduct could be used to conduct an
ideological takeover of the Linux kernel (and, by extension, the free
software ecosystem) by finding dirt on various contributors and using
it to oust the rather brillant and technically-minded contributors,
thus causing the quality and cybersecurity of the Linux kernel to
decline while the community is consumed by political infighting and
fragmentation of the Linux ecosystem---perhaps eventually resulting in
Linux becoming a shell of its former self.

The other reason we are writing you is because the authors of this
letter belong to the categories often championed by Social Justice
Warriors. One of us is gender non-conforming, while the other is
gay. We have watched in shock over the past few years as so-called
Social Justice Warriors have become the de-facto representatives of
our kinds, often silencing, shaming, and harassing those who are of
these characteristics for not agreeing with the now-mainstream Social
Justice ideology, all while claiming to be "the good ones" fighting
oppression. At least one of us chooses to stay in the closet, not
because of the stereotypical conservative, the Christian
fire-and-brimstone preacher, or the orthodox Muslim cleric; we have
grown afraid of those who claim to be our own kinds.

While your decision to reconsider some aspects of your communication
style is commendable, we implore you to reconsider the Code of
Conduct. Perhaps the document could be modified to address its
shortcomings and prevent its abuse, or the document could be rescinded
and a more suitable document could be drafted. We do not want to see
this wonderful technical achievement, one we utilize everyday for our
personal computing needs, become compromised by those with insincere
ideological intent.

Sincerely,
curious and Adele Radul

P.S. Please CC all responses to curious@redchan.it and adeleradul@redchan.it

