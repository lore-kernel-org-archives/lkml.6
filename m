Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0FEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF872086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF872086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbeIYRfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:35:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41296 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYRfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:35:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E8AF3807DC; Tue, 25 Sep 2018 13:28:32 +0200 (CEST)
Date:   Tue, 25 Sep 2018 13:28:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Edward Cree <ec429@cantab.net>
Cc:     Olof Johansson <olof@lixom.net>, Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180925112832.GA10951@amd>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I can
> > see how that kind of environment _could_ be implemented with the same
> > code of conduct as a base, but [...] I know I
> > would fight strongly against that.
> It is definitely reassuring to hear you say that.
>=20
> > There is a list in the first paragraph, but the preceding words say
> > that it should be a *harassment-free experience for everyone*. That
> > part of the paragraph is to me the most important part.
> It certainly _should_ be the most important; IMHO the sentence should end
> =A0after 'everyone'.
>=20
> > Your above argument that the Code of Conduct is problematic because of
> > who wrote it seems to contradict your statement that we shall judge by
> > code (or text) alone.
> I think there are important differences between code to be run by CPUs
> =A0and a Code to be run by humans.=A0 And when the author goes on a victo=
ry
> =A0lap on Twitter and declares the Code to be "a political document", is
> =A0it any surprise I'm worried?

Would you have link on that? I'd really want to know who authored the
document, because it is making statements that are untrue.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluqG+AACgkQMOfwapXb+vIM2wCgtRSMWEa2lI4Ahrzz68eo++6x
Gg0AoKnVrhF4vg8HoJn+kVdLVnXDmbey
=o4gI
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
