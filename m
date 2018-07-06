Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F20C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C6523C9B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C6523C9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbeGFLd1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:33:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48018 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbeGFLd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:33:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1D01F263B44
Date:   Fri, 6 Jul 2018 13:33:22 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, Julia Lawall <julia.lawall@lip6.fr>,
        sil2review@lists.osadl.org
Subject: Re: [PATCH] power: reset: zx-reboot: put device node in
 zx_reboot_probe()
Message-ID: <20180706113322.xrei7gcd4577rbii@earth.universe>
References: <1527978125-29850-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rv4e66jnbo2gjkem"
Content-Disposition: inline
In-Reply-To: <1527978125-29850-1-git-send-email-khoroshilov@ispras.ru>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rv4e66jnbo2gjkem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 03, 2018 at 01:22:05AM +0300, Alexey Khoroshilov wrote:
> zx_reboot_probe() increments refcnt of zx296702-pcu device node by
> of_find_compatible_node() and leaves it undecremented on both
> successful and error paths.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---

Thanks, queued to power-supply-next.

-- Sebastian

--rv4e66jnbo2gjkem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/U4IACgkQ2O7X88g7
+pr1Qw/9FXdw7LKy4b4MijHs2cgryF73ws0u1GcPk+TfDHxkpCZiD6YmxNJ+D+UD
v6iwHVdQ0IAPDYfTCJuF4F7d7cEl3k/Bc9dfiKPeNnV/7V3SoeZPM7U18CVLW64n
zJyRdqAs3xFNaoZmqcH7AsHIffeXMZvnNcQPclwGr6wPDLjwMbYxU3Og6rb7abnh
XAWydAca2kE1NCd7imQa4Ic2IZLxjNx6brXoJ++YK5PhKhgk4qyTQ0YGbxAcrmUq
qpVNth75k+I84UX8LzI+TrmfBBwiTqLDUzyQ1W99U4GH42noK7qrtDBdvI/bVxWU
Nei2nBNalA8KJPKOPcCROEfocSy4OIbS0CzrsB8kJ80YdLeftj2YYeVe05xPEjKL
HRP30bptXbmm5eE7vcjfcU0Z3NaGMzB26Zsd6HSb3ScZoIOdIzdVwNHFS77nB8en
ydEijcVZzQ9QBebPRTiRMjAYNo/5sxWqs5CCVxcgp3lWIlM5nAFF7/bxKFz9Zmkx
6Qph7jU1G0Van2z+0sw2gWy/GapAAqf1oRgozaOAR0Lv2wuFU0PUxjUPDcoNqgYu
IlT+e22EBxuF+se5/gdHz507CEFOWQv1OVqmM17GEh7zqfjJ41uRvz0643uRitu/
XhLNpN9fAr/FM5Srt6PSluSFR+PDCFGpbxXUtGJ7HhQ1hqUVOsw=
=n80N
-----END PGP SIGNATURE-----

--rv4e66jnbo2gjkem--
