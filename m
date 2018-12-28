Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ECFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E577820873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="UUXhOtz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbeL1QzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:55:09 -0500
Received: from cock.li ([185.100.85.212]:40608 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387466AbeL1QzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:55:08 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546016104; bh=SvMJUa+8mncB6JN5eu6UjS/uj2HkwVGnO7hjGKk0pEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UUXhOtz+zKmP4JITAxfgcALGhp99OT6hA0oKWQWR+ghHkfSU4agTxro2aU2mzgubY
         o7LElLkNohw3Wp7sqImKtUF9u7OAti4+a9KJ7c2PWS1NK7K2N8leDtiDx0YFdELJpU
         qBDiZgoRXtk9kBXr6aX4sT0rBUYtkEhgRPHXJpkDcuIpJD3/J2VqIkbyW11X5USunn
         jXdlGB8gA7SRz4WcxDSSqF2iVzEldgfd/CTWCu5rsWkmBkvoAk2nlkq3e2Ub9+8Ibq
         XljnZchLi+qThwWkdLj8LB6Kyn2+zyjbHvr0DuQw76GIX9fnE67uFyXpg6UlMEgO5x
         f2ZCe/C29QR6w==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Dec 2018 16:55:02 +0000
From:   vsnsdualce@memeware.net
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc:     Raul Miller <rauldmiller@gmail.com>, visionsofalice@redchan.it,
        freebsd-women@freebsd.org, freebsd-chat@freebsd.org,
        OpenBSD general usage list <misc@openbsd.org>,
        owner-misc@openbsd.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: Why is no one discussing this anymore?
In-Reply-To: <6b305c25-cf15-ac5d-d246-7c2e3c902f1b@petrovitsch.priv.at>
References: <d1a036ae6ecc7614d969e841ee2e9d2f@memeware.net>
 <6b305c25-cf15-ac5d-d246-7c2e3c902f1b@petrovitsch.priv.at>
Message-ID: <9fb6feaad76dca5342b55c4c17618075@memeware.net>
X-Sender: vsnsdualce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Real name pls, if want to be taken somewhat serious? Thank you.
So where my logic cannot be attacked, my person may be instead?
Do you think me a fool, simply because you do not know what you do not 
know (the law), yet think you do (an attribute of many programmers: know 
one field, know them all!)?

I've explained the law again and again.

But here it goes:

Under the copyright statute, copyrighted works are alienable in all the 
ways property is.
You can sell, transfer, and license etc.

Copyright comes into existence the moment your work is placed in a fix 
form. The copyright is owned by the progenitor (you the programmer) 
until such time as you transfer it (ex: to an employee by way of 
employment agreement stating such terms), or you die (now your 
descendants own the rights), or you or your descendants elect to use the 
"claw-back" provisions in the US copyright act some decades after the 
work was fixed.

You, both BSD programmers, and Linux kernel programmers have elected to 
neither sell nor transfer in other ways your copyrights.
Instead you have chosen to license your works.

A license is a temporary grant.
Under property law it can be rescinded when the property owner wishes to 
do so.

Unless, the property owner has been payed to forgo that right.
That is: if the property owner has been payed by the licensee to promise 
that he will not rescind the license,
then if the property owner elects to rescind the license the court may 
estop the property owner from doing so
because the licensee has payed the owner FOR that right.

Equivalent exchange, if you will. (But the court does not look to if the 
consideration was... equivalent, just that there was an exchange of some 
consideration (read: money, goods, services) and a meeting of the minds 
(both parties ment to do this))

In the case of most linux and BSD licensees nothing has been payed by 
them to the programmers(you the copyright holders) to induce a 
forbearance of the underlying rights of the property owners.

Thus the original default rights still stand.
You can rescind at will.

Additionally, you have never promised that you would forego the 
utilization of your property rights,
so there is no promise anyone could reasonably rely upon to estop you 
from utilizing said rights.
Additionally, Licensee "E" did not pay you for that non-existent promise 
either.

You are not bound. You may rescind.

You now know why the FSF requires programmers to assign all copyrights 
to it.
You now know why Eben Moglen remains silent these last two months. I am 
correct, yes I am a lawyer, and yes anything he speaks further would 
simply show the weaknesses in his (magnanimously) taken position in 
trying to fool the Programmers into thinking they have forfeited rights 
they have not.

On 2018-12-27 21:53, Bernd Petrovitsch wrote:
> On 27/12/2018 21:30, vsnsdualce@memeware.net wrote:
> 
> Real name pls, if want to be taken somewhat serious? Thank you.
> 
>> Why is no one discussing this anymore.
> 
> You don't discuss anything in the first place: You just spam mails with
> claims without any reproducible proof.
> And since we are here on a techie-list, said proofs should be
> techie-understandable - it's not that techies adjust to non-techies if
> it goes in the other direction.
> 
>> It's like you just accepted the "NU UH U WRONG" proclamation from
> 
> "Proof by claim"? I don't think so ....
> 
>> Are you idiots [...]
>> 
>> Are you idiots aware that I am a lawyer[...]
>> 
>> Are you idiots [...]
> 
> Interesting "qualities" of communication are apparently in order for
> (alleged) lawyers in your part of the world.
> 
> MfG,
> 	Bernd
> 
> PS: Sry for feeding the troll- won't happen anymore, it's only spam
>     after all ...
