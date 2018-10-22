Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FA0C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31B520652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31B520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeJWEqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:46:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33148 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbeJWEqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:46:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BF87ADE6;
        Mon, 22 Oct 2018 20:26:16 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Josh Triplett <josh@joshtriplett.org>
Date:   Tue, 23 Oct 2018 07:26:06 +1100
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181021222608.GA24845@localhost>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <20181021222608.GA24845@localhost>
Message-ID: <875zxt919d.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21 2018, Josh Triplett wrote:

> On Mon, Oct 22, 2018 at 08:20:11AM +1100, NeilBrown wrote:
>> I call on you, Greg:
>>  - to abandon this divisive attempt to impose a "Code of Conduct"
>>  - to revert 8a104f8b5867c68
>>  - to return to your core competence of building a great team around
>>    a great kernel
>>=20
>>  #Isupportreversion
>>=20
>> I call on the community to consider what *does* need to be said, about
>> conduct, to people outside the community and who have recently joined.
>> What is the document that you would have liked to have read as you were
>> starting out?  It is all too long ago for me to remember clearly, and so
>> much has changed.
>
> The document I would have liked to have read when starting out is
> currently checked into the source tree in
> Documentation/process/code-of-conduct.rst .

I'm curious - what would you have gained by reading that document?

>
> What is your actual concern? Why does it matter so much to you to push
> back against this code of conduct? What does it say that you so
> fundamentally object to?

Thank you for asking.  The discipline of focusing on an answer to this
question (rather than being distracted by all the different things that
are wrong here) has helped me to clarify my thoughts very nicely.

The current document is upside down.

The whole point of any document like this is to curtail, bypass, or
redirect the power of the powerful (and thanks to Dave[1] for the "power"
frame).  We already have plenty of process documents which attempt to give
power to the weak by explaining how they can be heard.  While those
documents might have room for improvement in this process, this document
is quite different - it aims to take power away.

The power that the current document describes is the power of having a
platform on which to speak - through a wiki, through comments, through
code etc.  It talks about maintainers curtailing that power when it is
misused.

I argue that regular "participants" in the kernel community have
virtually no power.  The only "platforms" for speech are lkml (and other
lists) and bugzilla.  lkml is a cacophony (even Mozart would sound
terrible if we played all his works at once!) and bugzilla is a ghost
town.  Neither provide a platform where any central control is needed.
Every subscriber already filters content themselves, whether by
unsubscribing, just skimming subject lines, or with more automated
assistance (and that is not something the community can control, whether
it wants to or not).

The only strength that participants have is the value of their
contribution, and this is only turned into power when they are listened
to.

On the other end of the spectrum, Linus has all the power.  Patches are
the currency of the realm and all power (popularity, voice, voting
rights) flow from them.  Linus ultimately controls patches and has
ultimate power (almost - see below)

In between are maintainers - they received power from Linus through
lines of trust, and sometimes pass it on through other lines of trust -
to sub-maintainers and valued contributors.   They also (noblesse oblige)
give some power to the poor who they don't know - accepting bug
reports, giving advice, reviewing patches.

Given the power structure, the document we should be modeling our
thoughts on is the Magna Carte, where the British barons demanded that
the King's power be curtailed.
We don't need a document where the maintainers tell the participants how
they must behave, but we might need one where the maintainers tell Linus
how to behave.

As I said, the current document is upside down.

I would hope that Linus would provide Magna Carte himself, but maybe he
isn't up to it.  In which case, our job is to draft a document for Linus
to agree to abide by.  He might want to then make changes, and that is
*perfect* *fine*.  It is *his* statement to the community on how *he*
will use the power he has - after all, it is ultimately the whole
community (well beyond developers) who give Linus the power he has by
valuing the product he produces (just as farmers ultimately give power
to the king by putting food on his table to feed him and his soldiers).

Once Linus has adopted such a document, we can look to other
maintainers to follow suite.  They might choose to use the same
document, or to write something completely different.  In either case,
it puts their stance clearly on the table.  People who find the need to
work with them can have clear expectations, and can decide on the best
approach, and whether it is worth the effort at all.

In parallel with these promises (willingly adopted, not imposed), we
need clear processes for people to follow if they cannot work with a
maintainer, either because the promise doesn't make them feel safe
enough, or because the maintainer violates their own promise.
This isn't about enforcement and repercussions and punishment exactly.
This is about economics - keeping the patches moving.

If, for example, Linus or Andrew said "if you cannot work with any given
maintainer, I will consider your patch directly, but you need to point
to where you tried, and why you failed - or to where the promise is
inadequate".

Currently if a maintainer is rude to you, there is no where else that
you can go and *that* is why it hurts.  It isn't the abuse so much as
the powerlessness associated with it.  If you can (metaphorically) say
to that maintainer "I don't care about your toilet mouth, you've just
given me the right to take my petition to caesar" - then the emotional
response will be quite different to pain.

If Linus is not true to his new-found sensitivity, we might need someone
(Greg?) to be a co-maintainer, able to accept patches when Linus has a
relapse.  It might be good form to create this channel anyway, but I
doubt it would be needed in practice.

So there you have it. The "Code" is upside down.
We need documents which:
  - curtail the power of the strong, starting with Linus
  - are adopted willingly by individuals, not imposed on the community.
  - provide alternate routes for patch-flow, so that no-one has ultimate
    power.

Thanks,
NeilBrown
#Iobject #Iforgive #Iapologize #Isupportreversion

[1] just a random "Dave"

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvOMl8ACgkQOeye3VZi
gbk3dw//eGtvCdSG9GxoRD9BqtVtdSXzK4NZLX7xm5ZSBA8Yw4WfIuKdkaJesztD
zoFlKU0FtkKXLS6oarGJ6QNjDgGzjoWvYqHsCED6zsgJoDnbwLov8gi6SD1MaxAB
PY9RC5/gb9R6jQlWDfI9dj8TE99e6AJNwmvj25AZJ5g5Uc+f1HlUXi7UeP0Wa4hF
VNhf7mLAHZ6n3q+EfYcueYUG5DX7SaGbusSJ7q4ry3fSkM/5bmcZmrYnFrHYOQKD
zWTIRzEqVW4OMseRGt0aICAXtfUvGriebfknYvk44+HuGmxTVU015nu3CFPezwcg
Luug9cCbu5jFxV9HiSWfHLeIeg3gnq4wQCwblLm3GcDfI6CGc7oTZh6ubA5KxfEe
M/De3vYQDMiNZpX6GVD+ku09cmxZ5xJuRK3j+c2czGBhQPV7+q8/HGWDulqJxgUK
FoBsXUGa8+2kdC+fXL8u3Q5pg5XIebBinvsEmhz4VwE2eXGbdINyzr7ugOrDVdGK
AaXV/iMlQ6stsejG2/VgUw9f2NhVoQebMa6EuOiLEFrV5X/CO5O5JoeWfk41jpIE
9l8holqEF6LK2QTAxBBLMCGB96kiM++PeiVXaJV6yx3hP+rFY3fwY10Vxmcg3Of6
rtjjFDAbSddiMVmT9m7iux60tUVnOYPwUm43lCX5zzyS6XQCfTM=
=oQfx
-----END PGP SIGNATURE-----
--=-=-=--
