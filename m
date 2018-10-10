Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93979C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EE921470
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EE921470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJJXfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:35:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56043 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeJJXfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:35:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4170C809CD; Wed, 10 Oct 2018 18:12:57 +0200 (CEST)
Date:   Wed, 10 Oct 2018 18:12:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [PATCH 0/2] code of conduct fixes
Message-ID: <20181010161256.GB19941@amd>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <CAKMK7uFvmXtk=WiZJxGrzQQD1RHv7srA-_e8KdwXZ9Kn5rcmiQ@mail.gmail.com>
 <1538934030.4010.1.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <1538934030.4010.1.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Personally I'm not happy at all with how the new code of conduct was
> > rushed in, least because I still don't understand why it happened,
> > but also for all the other reasons we've discussed here in the past
> > few weeks.

These are exactly my thoughts.

> > But I also understand that there's lots of people (me included) who
> > don't want to ship a release with the code of conduct in it's current
> > in-between state. I think adding a disclaimer at the top, along the
> > lines of
> >=20
> > "Please note that this code of conduct and it's enforcement are still
> > under discussion."
>=20
> I don't disagree with the position, but eliminating our old code of
> conduct in favour of another we cast doubt on with this disclaimer
> effectively leaves us with nothing at all, which seems to be a worse
> situation.  In that case, I think reverting the CoC commit
> (8a104f8b5867c682) and then restarting the replacement process is
> better than adding a disclaimer to the new one.

Reverting it then having proper discussion sounds suitable to me.

(And it would be nice to have something on the mailing lists, too, as
I probably won't make it to kernel summit this year.)
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu+JQgACgkQMOfwapXb+vIJCACcDvJriHp4ANq5GSyQdbwoo2Cr
RD0An1TkwQ/aNNJyxXEVtwDnoYQdKoor
=qTWA
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
