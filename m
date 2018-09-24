Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A987ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC7C20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC7C20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbeIYAFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:05:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42729 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeIYAFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:05:43 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2F5D080800; Mon, 24 Sep 2018 20:02:20 +0200 (CEST)
Date:   Mon, 24 Sep 2018 20:02:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Dan Murphy <dmurphy@ti.com>, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 3/6] dt-bindings: leds: Add bindings for lm3697 driver
Message-ID: <20180924180219.GA24418@amd>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-4-dmurphy@ti.com>
 <20180924161844.GA29028@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20180924161844.GA29028@bogus>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Add the device tree bindings for the lm3697
> > LED driver for backlighting and display.
> >=20
> > Signed-off-by: Dan Murphy <dmurphy@ti.com>

> >  .../devicetree/bindings/leds/leds-lm3697.txt  | 86 +++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.=
txt
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

We already have binding for lm3697 in
Documentation/devicetree/bindings/mfd/ti-lmu.txt . Is it good idea to
have second one?
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlupJqsACgkQMOfwapXb+vJEYgCgqQleExRR9ieXCshxOqTbbojL
kxMAn3DjSk8hyZkZwItIvNre9+VJRM+s
=FKQ+
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
