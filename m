Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB50C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36DB20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36DB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeJWF0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:26:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52173 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeJWF0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:26:52 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C2FE9806F5; Mon, 22 Oct 2018 23:06:39 +0200 (CEST)
Date:   Mon, 22 Oct 2018 23:06:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Frank Rowand <frowand.list@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@iki.fi>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] code-of-conduct: Remove explicit list of discrimination
 factors
Message-ID: <20181022210640.GA3721@amd>
References: <20181017071902.30102-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20181017071902.30102-1-geert@linux-m68k.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-17 09:19:01, Geert Uytterhoeven wrote:
> Providing an explicit list of discrimination factors may give the false
> impression that discrimination based on other unlisted factors would be
> allowed.
>=20
> Avoid any ambiguity by removing the list, to ensure "a harassment-free
> experience for everyone", period.
>=20
> Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

[I'd preffer going to old code of conflict. But even this is an improvement=
=2E]

									Pavel

								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvOO+AACgkQMOfwapXb+vKWaQCggKvX/eFZxqtHpDRiLS6cXkCs
MM0AnA6Fu8QYvcuy/IdwCgHYR18nTlZZ
=AQRh
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
