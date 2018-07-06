Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D0FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEDF23C9B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEDF23C9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932463AbeGFLbU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:31:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48008 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932300AbeGFLbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:31:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A8D66263B44
Date:   Fri, 6 Jul 2018 13:31:14 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Rhyland Klein <rklein@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>,
        Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 2/2] dt-bindings: power: sbs-battery: re-document
 "ti,bq20z75"
Message-ID: <20180706113114.sm5ntnoxozp3xo67@earth.universe>
References: <20180612202042.107603-1-briannorris@chromium.org>
 <20180612202042.107603-2-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fimiip3atuknqmhj"
Content-Disposition: inline
In-Reply-To: <20180612202042.107603-2-briannorris@chromium.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fimiip3atuknqmhj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 12, 2018 at 01:20:42PM -0700, Brian Norris wrote:
> This compatible property was documented before the driver was renamed to
> "SBS" (see commit e57f1b68c406 ("devicetree-bindings: Propagate
> bq20z75->sbs rename to dt bindings")). The driver has continued to
> support this property as an alternative to "sbs,sbs-battery", and
> because we've noticed there are some lingering TI specifics (in the
> manufacturer-specific portion of the SBS spec), we'd like to start using
> this property again to differentiate.
>=20
> In typical DT fashion, the <vendor>,<part-number> specifics should be
> used ahead of the generic "sbs,sbs-battery" string, so we can handle
> vendor specifics -- so document this. Language borrowed mostly from
> Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
>=20
> Also fixup the example to use this property (it's already implying that
> it's "bq20z75@b"); fixup the node name to be generic ("battery", not
> "<part-number>"); and fixup some whitespace.
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Rhyland Klein <rklein@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Thanks, queued to power-supply-next.

-- Sebastian

--fimiip3atuknqmhj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/UwEACgkQ2O7X88g7
+popIxAAgLipLBdCr+5abWLW73hZoUSBRmAc5EfVLON3EgaX3h9FFwZq0zAWiP17
UAaVzQTwrK2zBmNjQjuv593Fpq4SalNThcZheIt11TuMgobpmCUa1Qjd5PIlAZ0V
iFPLRzuURaQESFDgJUyELmWT2al13A8P6BYvC1yoSG7KB3jmIqCoAZdbMvY1N+w0
S2bnMxINjR+ViDJFl9VzG5sYqzYDTsWUYlnJMsbe36u7ed4ZFPdsAtyMQ2u7+huf
wtDZdjLz7pdcrBkU//UbBJ9m+oP+917lkUKkISjjAA5i8vqYhvZF79+uFwI2YBSf
3RB5FBabv3RYJr08tjtqnXtfOUn9bpPtFhZNM5B5JcK1Dh+5ZexI+vVR7BnLfnUd
1jfLkY26bJqKcjifUEGVtZ3H4gQtd391Wpcd+C2t2sHnJxV0b1ToENTju2YR7Wwr
UvMa0y9w4XtXgG11rvnEQSnvm76+5y+sRB+sv4HB6/7FpRG0UoOHdtRdMbe2e3JF
xP7qPa6hodz7+3Kx8WuReCNGc7I28iIB8Hf+/krp26JjcKjSQelnpAdWiq/lllQ2
Gynja4qIBo4zbAWCNBCWJ9PT/iUhmryZdc2MbQD1x9RquATaZWiZjJ6jTDhOnMzE
Nw+SSo4I8iJRrwO24SG6ADjHnDlNCoYIzwITzrb+0KHtO0tS2Lo=
=BPX4
-----END PGP SIGNATURE-----

--fimiip3atuknqmhj--
