Return-Path: <j.neuschaefer@gmx.net>
X-Google-Smtp-Source: AB8JxZoggYENUQ5Zo6gzw/G5xC+f5/5SW+RlcHiDdRjKI/SWeQ2id8uGa29uzRCmXYIyRbb6Mvd1
ARC-Seal: i=1; a=rsa-sha256; t=1525692090; cv=none;
        d=google.com; s=arc-20160816;
        b=emGR8oNQ6wuartntAiwvQwcmbe5sdeQ2P8AfinJdcIW59H9tfkBLaHIyJNqINuSjWT
         Cvk5ur+1dg6CW1OZn3UbQgRtbYnDcR3j7OFjLAhQVcxIZWu/vtnLXRNdVuy5csfIU6fY
         6WCWAOsxkhicXEhfpkkCaf/4Q4/F09yJaIEKaRx+3erywtlVa0M6w8PAXPpNLJaJTfkR
         Zy9ebBz16ZvSinDGO9FHqoqH/Fv3vgla+EU4Hjds78EvzFgswRDV3u0EvZm7YDmE3ejq
         WJ4hpy5h+/iugKOYKZF0EZqG1YG7iqywf9ZhR+LbgCaEdMMfeFc7zssMJ+vu8Teq1MHC
         uifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2uA+U62eOrXJVbJwNsPt5UBt1dTuqCsqdqEvobynFKI=;
        b=Z9GZDc0/LVnAc3m54XUAIcgUH5oxILpSnekq/KJaw/tlYzZr327jtu6zG75SaLBUij
         NyNIQPkm1Ngz/zKNT/bqDHMSvWLGXWjgxrdeRrVwICSkI8IOfKXqDpzPnS2jYWM+xIq3
         QQ94uhxHOfN8s8hzeWgA00rU3cV309ZkxO67ADQtyrsJrlPFoN1ywvWoI5T7k8AE05/I
         i+AXD1yjdLGZKIfBRcEK2VJ89OZ1biYBs0dBOqLc9pSuT2MlP0a/nqL+NmpkvUJq08Lx
         mVHuEBc4r80ONLKX3/8wvN5AjClQiucDwv8YANv22ChLYdqEY9S58ZBZnuY8Xg3ACNzk
         scAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.22 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.22 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Date: Mon, 7 May 2018 13:15:22 +0200
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benjamin Gilbert <benjamin.gilbert@coreos.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc: wii_defconfig: Enable GPIO-related options
Message-ID: <20180507111522.GA32665@latitude>
References: <20180430134252.17345-1-j.neuschaefer@gmx.net>
 <20180430134252.17345-2-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20180430134252.17345-2-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Provags-ID: V03:K1:rQ1wBDWVYcaQsS3xkarqxlGiMHCxaMKqLl22tYekqY6js4uki1k
 mDCdCLs656gOraQkZHIGgsfS7B1Pz/sGd+fkcTvXVFtRd+dECVDI61czQxyT7ucHgds9vuK
 20WxnIBYIFYlQxUln44krdK0hX9AedNvHPwpKlX9pMU7m5w7byRtUBYrXfygeHwL7rKN5fe
 gWJ0s3GCXD9HyJ70I3zdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ry2LLs+EsdE=:lCI4hsDEO3wFX5ShqDohFy
 y2FI4QxQbbaMpgHrfR9NhHyNPzexsY9wUe3tvwo3Wqa7DuNte48vCS5CSVuq0QPCIanXEUDGy
 CuZiwf9C4NE1bprGENYEw5xQzebbUz3NyLfE0/3xVQkOsCuuJ+2d/CbK/SPiuYqp3kQeardk9
 UQ4cDpbsyVCn5u4bG1xCTTUZABCyqk1iN45sTwapHrH7d1fAZf+yFLFGhF62MB54QibzJFmaQ
 SHUsuL2WohrVp0418t4zFyQL0bq10RYrzDgx0kgWN3yqL23L8d7xtKjvBsacNFHza1rKTOCNb
 8BrS3n7WQjLlFaDyOjI2tPeSBcDm8GaDtg1wJO/+XP8JhQBdf+E7jBbr9Zzjmweo8reyBhMlt
 1R/EJcg9S5+K4VRFAB5cS7l6g14oT+aOf0Pt/KlGNmoBE4MUJ0uHLEeHAznO5L0/wd3ArZXm1
 HGVmGTxXP9BHNS0shm26FGN8kN5vbepZoYwTjs/zu4/1p3IZHR03I+h5o7MKb5HV/voSSLNJP
 YGu0MwgPnFY07/ZloRVD05cFuP4YJa5vCjS5HMnUYeGNG2uipKTK0h3yCnSmeMpQj2oFItUtn
 VPw8EgxDyLuNEPyNXPHXIDJrxPWCYwR4n89Y2lF1eIxZgXUQb3gi1TGIh77rne5jze3HIjcdH
 oY5KTbPGAsIRL0WoWbyPVPqUJ+lqmQSCR7pV4A0Pejk93o+ZuIzBSUlkKhkCDNHVCrBZ/P4r9
 cjXELY/WwCxD0zRL4VBoWnABW8+fRzF3K52fhVDAn2eDCRGVKYGX42ZtWYw=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599179228553644681?=
X-GMAIL-MSGID: =?utf-8?q?1599804109437669898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 03:42:47PM +0200, Jonathan Neusch=C3=A4fer wrote:
> Now that there's a GPIO driver for the Wii, let's enable the following
> drivers:
>=20
> - the GPIO driver itself
> - gpio-keys
> - gpio-poweroff
> - gpio-leds and a few LED triggers
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
[...]
> +CONFIG_LEDS_CLASS=3Dy
> +CONFIG_LEDS_GPIO=3Dy
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
> +CONFIG_LEDS_TRIGGER_PANIC=3Dy

Oops, this doesn't work without first enabling CONFIG_NEW_LEDS and
CONFIG_LEDS_TRIGGERS. I'll send a v2.


Jonathan Neusch=C3=A4fer

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJa8DVDAAoJEAgwRJqO81/bhdsP/0so8ZngWoGwQUkLG5U4ZX78
8Cz8CvwiJPOPzuyRTGJkHytdYPG8pqAfC1A6wAnWN9zoqAdPO6FkOe//l7OecBLS
zq/cE+OAnzaZajG2mPjEgnavjZhjvy/HXhfJCA+LuvzRW87gpsddhX0V9ZMkFtWF
jSfkS0AsI+rIU9t0lMY68i5LjmqG9OEPcFhPKPpjqwS4Ji+KqZnFh+aYQRhE9l/c
x+tm9SqHivSgINpT9NkOKhfJIn/GnpsZVZqIbdFTA8PLuKS/CfA5SX9IwEIwn3ch
sfhJC6E9gq2as5OcQD3EqHLlLYXkfPFDfs2nWh7AuMod/w4KUBtnP7GV5P1JBEuu
xSeJv4UCvKM1zBvUiZ/4Kz0/2HAKMOJr8v8hueOmiGgjGKYJ3aD1EGtFwQHq5WkG
3u626YpbbJAK7BbTzbiYPXu4AFxotuCh1ZSSzMezSylBCq5FMCLfWjSrlDPUxuhV
UqKQohEXM4Fn+x3rGQMYfjWC8JQZWQBlFWbHw3rgcYMHDEDFJ2gJ/YVDozjFINKx
irv2DVaPSD7GHCpOilceXXiRgDfwTvdEmD8jziUL/gfEBOs/1OBfgR0/PJ9CL8Za
qhi4JTP3zEStCwk0+k2wXfJb7z4BnuP9KOa10noIlZ78HykIf4t4EEffIWwjRbSU
ymURcz6hJmEQtybJMz5Z
=bAkE
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
