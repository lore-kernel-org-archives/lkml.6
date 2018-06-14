Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4FC6EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A88C208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A88C208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755359AbeFNTom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:44:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41939 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbeFNTok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:44:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 495FF803D6; Thu, 14 Jun 2018 21:44:39 +0200 (CEST)
Date:   Thu, 14 Jun 2018 21:44:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Johan Hovold <johan@kernel.org>, afd@ti.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 3/6] DTS: gta04: add uart2 child node for w2sg0004 GPS
 receiver
Message-ID: <20180614194428.GA17808@amd>
References: <cover.1525340143.git.hns@goldelico.com>
 <9ebb28aed589aca8e9b5bc5c910f1d2f0d62669d.1525340143.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <9ebb28aed589aca8e9b5bc5c910f1d2f0d62669d.1525340143.git.hns@goldelico.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-05-03 11:35:48, H. Nikolaus Schaller wrote:
> GTA04 has a W2SG0004 module connected to UART2 of the OMAP3
> processor. A GPIO can pulse the on/off toggle switch.
>=20
> Note that there is no WAKEUP output from the W2SG0004,
> hence we can't use the generic SirfStar binding.
>=20
> The VSIM regulator is used to power on/off the LNA of an
> external active GPS antenna so that a driver can turn the
> LNA off if GPS is not needed to save battery energy.

This reads as if you did low->high->low to turn GPS on, then
low->high->low to turn GPS off again. Is that correct?

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsixaYACgkQMOfwapXb+vIR+QCdEaJCgNlT/StRfo2wpu6IL5DZ
f5oAnRk0pf0CnytX6uUjiTwnFyuk9B9F
=NzCb
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
