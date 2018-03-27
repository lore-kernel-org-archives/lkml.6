Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeC0VZh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:25:37 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40128 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeC0VZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:25:35 -0400
X-Google-Smtp-Source: AIpwx4/Q45TNvfm7YbcwRq7lowYCzHG8JGqXDGG+l+OHQSSg2XrH1ip8NEXjMdlDLFMXpLufx8UzcA==
Date: Tue, 27 Mar 2018 23:25:32 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: alexandre.torgue@st.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] pwn: stm32: Adopt SPDX identifier
Message-ID: <20180327212530.GA28058@mithrandir>
References: <20171205145721.20403-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20171205145721.20403-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 03:57:21PM +0100, Benjamin Gaignard wrote:
> Add SPDX identifer
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 3 +--
>  drivers/pwm/pwm-stm32.c    | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6tsIACgkQ3SOs138+
s6Hedg/8CsNgFI6sAH2vJXzPw9BEZ8vDopedDE4ZSxMkWIlUHXZC7iZmwaVFRqf8
2hOZIONf6AlHmsj0xBCyGxMdnGdVpMd+AAMWT7cupQDaFLJtLI5puxTjyrWFuOvM
zVbaEHrlaw17coqncuWIeWMAOKzFRa4FDzOCCovxMgIpzE59+vNBRDs9VltESnWw
UlmH0908+7YIilGqseRvOq5+s8zr1IPU/xKuSfvVCji2Ug6NTnuaPNxhfQQXKYq9
xs5SjyHn3GVCeAGgXK52W2mt8RHiteENrYLr9JwWfsv9tYJ2t25z+2ThBTiSJN/Z
8Ge7Wt9EBWQ1Enujyb1KvpZdHeFg1+HCsd+2PCEe2HtgT/yOTG920djbgTubbTdr
GOy/O3ljwRlrTXzSdR1HP5VtDDemLtrfT1TyH8dJrs4qNcyDxLXsGOmAJOzDbJUP
P5lWkOr63PGLVTExL1nQ0huSWDJ3+E4/33VgYKAx4RhT+bzMZw99nO9WT+Ai3PeT
/PQWiXBRF9OKHWi6jMsA0QlsS1AUDoZpxLyDFc+S4QaoJbvmIRwclHoTaP9QUPWP
fneoDyWQlSl1IGNmVCoe9XYQylbsqbEKSsqkteYKOJtFBq4GEZB2p3OAS9i6Q8EW
wNJKt4RCCk5fGHajYvUsCnfnDzBp8nH3OMEwKnPDFLZzqTNNWIw=
=Zw4F
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
