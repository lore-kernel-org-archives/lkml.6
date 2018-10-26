Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23696C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE04A20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE04A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeJZR2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:28:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36688 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJZR2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:28:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9091A808A6; Fri, 26 Oct 2018 10:51:57 +0200 (CEST)
Date:   Fri, 26 Oct 2018 10:51:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 4.19
Message-ID: <20181026085158.GA20200@amd>
References: <20181022073224.GA5658@kroah.com>
 <7c258019d4746325ac323bd6d49746ab3ea84066.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <7c258019d4746325ac323bd6d49746ab3ea84066.camel@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-10-22 00:38:43, Joe Perches wrote:
> On Mon, 2018-10-22 at 08:32 +0100, Greg KH wrote:
>=20
> > Greg Kroah-Hartman (7):
> >       Code of Conduct Interpretation: Add document explaining how the C=
ode of Conduct is to be interpreted
> >       Code of Conduct Interpretation: Properly reference the TAB correc=
tly
> >       Code of Conduct: Provide links between the two documents
> >       Code of Conduct Interpretation: Put in the proper URL for the com=
mittee
> >       Code of Conduct: Change the contact email address
> >       MAINTAINERS: Add an entry for the code of conduct
>=20
> Regardless of the number of acks that were given
> to this patchset, I believe this was patch block
> was not done in a public manner and so should not
> have been applied within the single day after its
> initial publication.

I was wondering if I somehow missed the discussion.

No, this is not right :-(.

Based on this, no, I don't think Greg should be MAINTAINER of the code
of conduct.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvS1a4ACgkQMOfwapXb+vLoaQCcCtCqf1wy8vjoRyaR0Hy+0Txa
M3cAnivFEwh0of2WFJHFS7wmapCiDsSu
=zht3
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
