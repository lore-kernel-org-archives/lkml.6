Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B43CECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EC021532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="E3gSvglt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EC021532
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeIVPlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 11:41:47 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:61550 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeIVPlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 11:41:47 -0400
Date:   Sat, 22 Sep 2018 09:48:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1537609727;
        bh=04D0FYTOZGgTicptuc0OhiCg84RnTThQCUIqPPslS1s=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=E3gSvgltymblqBjnfU5PcXuwpk4rswL/31TJ9VRlf1YMfsUx42kBpLLp1RagJ4W3o
         0zpD86D3xa6Hgf34zACQhXZE7KnfZOzymKTqv0aTZmAbfxgEEFNGzVUrdeWUkAZCTg
         p9PfdmF0EkE12hDRzlXsNPuBvSgYgwoO3brIfjl0=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@transmeta.com" <torvalds@transmeta.com>
From:   comrade-c <comrade-c@protonmail.com>
Reply-To: comrade-c <comrade-c@protonmail.com>
Subject: Linus, my friend
Message-ID: <e54oSV6W8t-UPOCr17z7UFOa0UAHP4_spYXEHYKysqxVkbA7QXloAGW8YVJMoqihMgym39xrOwHjI9gSoq-qZhnhEHCNFoNBE5VMt4FCnOs=@protonmail.com>
Feedback-ID: PIMxIZnsagI3dioeI6nmZIMMHXF9O3Bt2yOQEQA_OCgXrChU4aJvq5Ye57sRSsEXLOtP6KN_F5paJmE99r0U0w==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite I didn't have a pleasure to know you personally I have a huge sympa=
thy to the situation that you are in now. It's hard.
You have to re-evaluate what makes you yourself and whether you want to giv=
e up a part of you if some particular part of you doesn't is outside of the=
 other people' reality tunnel.

My friend introduced me to Linux before it became untouchable. I remember a=
ll the struggle that Linux went through fighting for the its place under th=
e sun with giants like Microsoft and Oracle. The involvement of SCO and oth=
er nice stuff. I believe it takes some guts and character to make it throug=
h. Not every single person can do it. Code of Conduct will not help it eith=
er.
Linux is in the center of billion dollar industry, basically in a non-profi=
t project in a shark pool. Look at what happening in the JavaScript world w=
here Facebook and Google are fighting for the people minds and for the mark=
et influence. Don't let Linux become a battlefield for the tech giants.  It=
's your baby and it needs your protection.

When I was a kid we used to gang up and explore the neighborhoods, build hi=
deaways and make secret plans. That was a boys club. And there was boys rul=
es in that club which were perfectly fine. We tend to loose that kind of fe=
eling while growing up because we have to become "serious", respectable and=
 responsible. But look, it's great to have something on a  side, another bo=
ys club, where it's possible to leave all those social demands alone. And w=
e need people who will be the core of such clubs - people who will remind u=
s about something deep inside us on a constant basis and I guess you are th=
e man who is doing it naturally. It's important not only for you but also f=
or the other kernel developers https://www.upworthy.com/loneliness-is-killi=
ng-millions-of-american-men-here-s-why

Now few words about CoC. I would prefer to work with people who sees projec=
t success as their own personal goal. Maybe if people can't cope with the w=
ords the project success is not as important for them as their ego. It's ok=
ay to not let them in. Having a team of people who can put their personal s=
acrosanctity aside and cooperate on the project is rare fortune.

I guess people who are happy because of your decision to take a step back d=
idn't ever worked in environment like you do. Don't loose yourself because =
of the people incapable write good quality code.
