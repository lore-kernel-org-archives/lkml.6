Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51260C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5E32086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5E32086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJJX7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:59:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56690 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJX7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:59:02 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 45188809CD; Wed, 10 Oct 2018 18:36:04 +0200 (CEST)
Date:   Wed, 10 Oct 2018 18:36:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dave Airlie <airlied@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
Message-ID: <20181010163603.GA22306@amd>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861799.4088.6.camel@HansenPartnership.com>
 <CAPM=9tz3Z=vD6qWUL2boZGEAgMeC_o9euBXFu2V58RHOn6gR9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <CAPM=9tz3Z=vD6qWUL2boZGEAgMeC_o9euBXFu2V58RHOn6gR9g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > ---
> >  Documentation/process/code-of-conduct.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/=
process/code-of-conduct.rst
> > index ab7c24b5478c..aa40e34e7785 100644
> > --- a/Documentation/process/code-of-conduct.rst
> > +++ b/Documentation/process/code-of-conduct.rst
> > @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants inc=
lude:
> >  * Trolling, insulting/derogatory comments, and personal or political a=
ttacks
> >  * Public or private harassment
> >  * Publishing others=E2=80=99 private information, such as a physical o=
r electronic
> > -  address, without explicit permission
> > +  address not ordinarily collected by the project, without explicit pe=
rmission
> >  * Other conduct which could reasonably be considered inappropriate in a
> >    professional setting
> >
>=20
> I agree we want something like this, the question is whether we want
> to change the CoC text from upstream, or clarify it in a separate
> section.

If this comes from some kind of "upstream", that should be clearly
marked so in the document or at least in the git log. I was always
wondering who created that "useful document".

									Pavel
(And would still like to know what the background story is.)
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu+KnMACgkQMOfwapXb+vLCSgCeLER77yWcAxUsoiaQ78cA29ZQ
J/wAoKhjbDoXy8oP2yAPC1FJGMUmK4ek
=RW8M
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
