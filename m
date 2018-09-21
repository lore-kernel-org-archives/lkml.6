Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0053CECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAD121522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAD121522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbeIUN4w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:56:52 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:44303 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUN4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:56:52 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id DB9853B3080;
        Fri, 21 Sep 2018 10:09:05 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Christoph Conrads <contact@christoph-conrads.name>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
Date:   Fri, 21 Sep 2018 10:09:07 +0200
Message-ID: <2808315.UYOVJ65Qvk@merkaba>
In-Reply-To: <20180920231823.46d282ce40c91f39988bd34e@christoph-conrads.name>
References: <20180920231823.46d282ce40c91f39988bd34e@christoph-conrads.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph.

Christoph Conrads - 20.09.18, 23:18:
> The CoC is extremely ambiguously written for an enforceable document,
> any behavior disliked by the maintainers can be punished, and the
> level of naivete of the maintainers defending it is suprising for
> such a far reaching document.

For me the most important point is this:

Let Linus have his own experience and insights. It is not up to me 
telling him that he might be making this all up or may be completely 
right in his assessment. I do not know how he got to that experience and 
insights and what talks in person may have contributed to it. And its 
frankly simply not my business. I just congratulated him for his 
insights and his courage to speak up like this, seeing the potential in 
it.

Not my business is also the CoC Linux kernel developers and contributors 
may or may not give themselves. I am mostly a by-stander. Sure I test rc 
kernels and give (limited, as I usually do not bisect issues) feedback, 
report bugs. But that is about it.

What I see here is that a lot of people who are not even contributing to 
the Linux kernel in a major way apparently want to make their opinion 
about Code of Conduct heard loudly.

I ask myself: What the point of it?

Apparently at least some of the major contributors to the Linux kernel 
see an issue with communication culture on this mailing list and 
elsewhere. Whether it has been a wise move to just change the CoC to a 
different text, I read some major contributors opposing this move … I am 
all for letting people who contribute significantly to the Linux kernel 
have their own experience and insights.

It is simply not my business to interfere with whether they give 
themselves and the wider community a Code of Conduct and what would be 
the content of it. They do the work, one of them cares for the 
infrastructure that serves this mailing list. Even in case someone would 
now censor every post I do on LKML or even ban me from using it… I do 
not think it is to up to me to change or control that behavior. Sure, 
even small contributions count and I even have a tiny, little commit to 
kernel documentation, but still for me the major point is:

Some of the major contributors apparently see that the way of 
communicating here and elsewhere sometimes (!) does not serve Linux 
kernel development and the community. By just continuing the way it is, 
it is unlikely to receive a different outcome. So it is important to 
change *something*.

There is a kernel developer summit where they like to discuss exactly 
things like this. I do not see it up to me to try to control the outcome 
of that process.


KDE.org has a code of conduct¹. While at the same time they really have 
a rather friendly and welcoming environment – if you ask me one of the 
most friendly and welcoming ones I have ever witnessed so far. I also 
still see honest discussions there where people share their point of 
view and agree to disagree. They are very productive as well. Plasma and 
KDE applications become better and more usable with every release – yes, 
Linus in case you did not decide not to read mails on this list for now, 
I won´t CC your address, KDE stuff is getting better and better. And 
they work on making the project even more welcoming for newcomers. I´d 
say I even found friends within that project. They may not even need the 
CoC, but I do not see it doing any harm either.

I really don´t see the point of most of the discussion here. What 
happened now won´t be the end of Linux and that´s about it. There is no 
point for predicting doom unless you want it to happen.

[1] https://www.kde.org/code-of-conduct/

Thanks,
-- 
Martin


