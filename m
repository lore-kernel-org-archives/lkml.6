Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435CBC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB65927CBC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB65927CBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933610AbeF2JqM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:46:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41333 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932331AbeF2JqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:46:09 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3D532805BE; Fri, 29 Jun 2018 11:46:08 +0200 (CEST)
Date:   Fri, 29 Jun 2018 11:46:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        alan@linux.intel.com
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
Message-ID: <20180629094607.GC31718@amd>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180628120103.GA28131@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20180628120103.GA28131@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Finally, note that documentation (including kerneldoc) remains to be
> > written, but hopefully this will not hinder review given that the
> > current interfaces are fairly self-describing.
>=20
> This all looks great.  Thanks for doing this work and adding a new
> subsystem for something that has been asked for for many years.
>=20
> All now merged in my tree, nice job!

I don't think discussion was finished on this one.

In particular, we agreed that /dev/gnssrawX would be better device
name, so that we still have place where to put proper abstraction
layer in future.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls1/98ACgkQMOfwapXb+vLUQACgqpWMsI37vi4u0C6kmqx7hkVo
XRIAnjq3CzVtwfkll7xX/8TtjV9FUild
=Q4uJ
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
