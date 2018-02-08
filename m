Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbeBHH5Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 02:57:24 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36087 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHH5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 02:57:22 -0500
X-Google-Smtp-Source: AH8x225uKVTilJ5sr4k9LTD6UFKZMv2HtQQbx8xmeoTGqSGdqGMyMlFy4rvjJkOT/0/lCu++xoSFNA==
Date: Thu, 8 Feb 2018 08:56:28 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hid: logitech-dj: delete unnecessary error messages
Message-ID: <20180208075628.GA2860@gmail.com>
References: <20180207170800.15015-1-christoph@boehmwalder.at>
 <20180207170800.15015-4-christoph@boehmwalder.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20180207170800.15015-4-christoph@boehmwalder.at>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Christoph,

On Wed, Feb 07, 2018 at 06:08:00PM +0100, Christoph B=F6hmwalder wrote:
> Remove some "out of memory" messages that are considered useless.
>=20
> Signed-off-by: Christoph B=F6hmwalder <christoph@boehmwalder.at>
> ---
>  drivers/hid/hid-logitech-dj.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 59c54cb4bc64..ba5239840cda 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -414,11 +414,8 @@ static void logi_dj_recv_add_djhid_device(struct dj_=
receiver_dev *djrcv_dev,
> =20
>  	dj_dev =3D kzalloc(sizeof(*dj_dev), GFP_KERNEL);
> =20
> -	if (!dj_dev) {
> -		dev_err(&djrcv_hdev->dev, "%s: failed allocating dj_device\n",
> -			__func__);
> +	if (!dj_dev)
>  		goto dj_device_allocate_fail;
> -	}
> =20
>  	dj_dev->reports_supported =3D
>  		get_unaligned_le32(dj_report->report_params
> @@ -1015,11 +1012,9 @@ static int logi_dj_probe(struct hid_device *hdev,
>  	/* Treat interface 2 */
> =20
>  	djrcv_dev =3D kzalloc(sizeof(*djrcv_dev), GFP_KERNEL);
> -	if (!djrcv_dev) {
> -		dev_err(&hdev->dev,
> -			"%s:failed allocating dj_receiver_dev\n", __func__);
> +	if (!djrcv_dev)
>  		return -ENOMEM;
> -	}
> +
>  	djrcv_dev->hdev =3D hdev;
>  	INIT_WORK(&djrcv_dev->work, delayedwork_callback);
>  	spin_lock_init(&djrcv_dev->lock);
> --=20
> 2.13.6
>=20

Thank you, but Markus Elfring already has a submitted a patch for this one.

/Marcus

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlp8AqcACgkQiIBOb1ld
UjLOag//YG9qkWU53hR6AJdxgXX6Zblvbum+Sc7OsgWuzy5WPbDsUFZvqpyIuCNu
5J7pdTOkxMm4DX62UM/69WdSZlR+qdSitAl14Jp7gpkwDHEDFS1c9etEtD474tkb
iRnp90ubffkhY3KVABUJa0gprOXK0Yp4yfbfNN3bW3Umqe5FVjnWb+tWPQVMEAaI
irsd6ckvY4w48j1ujY3v6658oLi5tp1d9isoqvpC90GubGq5O6ISEzG0nnEt923f
35d44li14XX0686mNWhgRsHZDqXaRCBzNZqVUieISIJQ2coL6c8RnGJCW/5Xj3Up
z17Bd9TQmQDbKdUZwWUhn81C6ieOEAnyVeDMSELrUVNTPKKb4v00eS/OgxFensz0
zL2+fpqNcwlb2iEgt/iZA3QQt1XEizvcNBADPEF/I3Xy84Jv/hpQ8VWGCBK9FGi4
57TJSZZl60AxtsUU6M4x85/SZzLA4TB6B++a3vWy1od/LBlW//X9sZkj+xX5Q9Fa
k0kkb7wXHqcgs9JKAmacIUMup1Zp0OzovWBOxrKAma12BOzOB6KCsWGZQeoPIKei
SXQH0pzdqPL9EcjpJIoGhAcAPG3Spf5M6r4yDk/5gMmxSCgM7H+ehILD+cNLTmXU
2N1ezaN47omYoT8eiWzcGNiJaajuWmtBDZ9SH59GmNjp6S8KasY=
=69P5
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
