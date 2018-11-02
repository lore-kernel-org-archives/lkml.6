Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA1C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D172082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D172082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbeKCF6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:58:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38496 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeKCF6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:58:01 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CDAE180916; Fri,  2 Nov 2018 21:49:19 +0100 (CET)
Date:   Fri, 2 Nov 2018 21:49:21 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mrvl,intc: fix a trivial typo
Message-ID: <20181102204921.GB14954@amd>
References: <20180910112033.40465-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20180910112033.40465-1-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-10 13:20:33, Lubomir Rintel wrote:
> s/whold/whole/.
>=20
> Jiri Kosina <trivial@kernel.org>

Missing "Cc:"?

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mrvl,=
intc.txt b/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc=
=2Etxt
> index 8b53273cb22f..608fee15a4cf 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.txt
> @@ -5,7 +5,7 @@ Required properties:
>    "mrvl,mmp2-mux-intc"
>  - reg : Address and length of the register set of the interrupt controll=
er.
>    If the interrupt controller is intc, address and length means the range
> -  of the whold interrupt controller. If the interrupt controller is mux-=
intc,
> +  of the whole interrupt controller. If the interrupt controller is mux-=
intc,
>    address and length means one register. Since address of mux-intc is in=
 the
>    range of intc. mux-intc is secondary interrupt controller.
>  - reg-names : Name of the register set of the interrupt controller. It's

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvcuFEACgkQMOfwapXb+vITeACfXjbO/eDf3sMC/AVDZ6KdZryC
z9gAoLYrUUWv8SurnykvcTSNtQcPhGJ4
=Ad5j
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
