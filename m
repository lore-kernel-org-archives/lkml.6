Return-Path: <fschmaus@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526472597; cv=none;
        d=google.com; s=arc-20160816;
        b=H/edPYsqEgzEpzlFP95WQJfWzAUQIbDwQZPVS1lYoGmNoL5+dSQglWk4Om2Ee4JxQs
         qW5BtAUHkov2D5PXKHwMI4kYp5KP/rNQ9zNvWuY2ZNLcdPp5Y9LwYSiX2ahKzhNfijP2
         EvFdhjCn4CuHgHsx+HEZXRuBO8YlfLjbFIDNTR3AfRxzv9xuMhUMlHP10vy9D32Nj4Hf
         +plEaRSF3tXjrtz3H41j9tob1oGeXbTx40QS6rgYu5qb05xtI8QMJg1gNEVZrgCd3ful
         QJdlX2TjlgEbs0qCqvmusGlAqMrezVNnTU/2ggRfdF014q+s5+btDIrxVIcYbn7ChtQw
         pSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:autocrypt
         :openpgp:from:references:cc:to:subject:arc-authentication-results;
        bh=d9L12eo0x7RQFFTzGUzZ6dkqcsUarhGBWqaJ/DPWOls=;
        b=lpnWWsyeh3AAJFFcM1nlXxTQOJv8aYBbeOFodDlYqI2E2rpYMhY5/ma0Y7Y+muKd+3
         aCf9KysRu+8g0wFQ+cu1GJT442Sfeui1T6KlSgSKF/lQuqtXSgfbMSTT8Sj746k/VTGg
         0MAc79MKkaSgMqib9UHQZoLO311lltz+VV7bBJPQR3LR3dUY+Hyyp6/OXIP23agOZC4q
         irxbpnkQW+lodEpBzlQtKfvy3R8Pn6Zz6ecl2CUyP79Vg9uPDoxmSTVR0a8uZXzt3Auo
         OtBhgSHYg1Smd+er97+dl/vAE6EITwtG5IPO13oNNLDCR0SmEiInTkLArr/UkExQAM2b
         ciyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fschmaus@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=fschmaus@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fschmaus@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=fschmaus@gmail.com
X-Google-Smtp-Source: AB8JxZqYERBHz6Z8T5K0t/bpzUNTRZqUag0J3HqCCMperjIQ3Ff8q+SSM6jCg2/grthHIj+pcYwLRg==
Subject: Re: [PATCH v4 3/3] driver-core: print bus registration error value
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <20180516120527.29403-1-flo@geekplace.eu>
 <20180516120527.29403-4-flo@geekplace.eu>
From: Florian Schmaus <flo@geekplace.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=flo@geekplace.eu; prefer-encrypt=mutual; keydata=
 xsBNBEw8UF4BCAC4H+pf0bJjP8iUvOXtyfM052WptOwK+YCVWx5y8TExQ6u2WuKnsLC5AhdQ
 qChyLU08zIkno2dvfhyRxxMqhUPmo60ckn6AjLrif28vZiHJRWCfJTipxL2mZO0xNW68d23k
 9G4f7+hzNyjWV5SpFG2qg4DWKmwIonZHZMZAK3NtWK7h+3uIVXk32Veuseh/qACZRI63EuQH
 e+BhnHDFLbb7gYhm78tuzVobU1mEqiNSA783BpxoVUSCEine1/qB5kObmq9Nno0cwnPui8GS
 sAUmNItKC270UdwLimFdCnV8qEbVEVj+Nh+nE+LVMdNZJa95x/4HHz9oIj8TGc1/RNiXABEB
 AAHNIkZsb3JpYW4gU2NobWF1cyA8ZmxvQGdlZWtwbGFjZS5ldT7CwIAEEwEIACoCGwMFCwkI
 BwMFFQoJCAsFFgMCAQACHgECF4ACGQEFAlh3gqwFCRHezM4ACgkQjKwqlnhUjjWzQwf/dXwE
 R8QeAwc7hOCHje0qiwq94nNjUgJwvYTGjvKbCgiTuDZmyVqSSjhXAYADFYC5wcW5SwIDKTQ4
 1jxySbpZq6sjEHyAsfyw6cyMaK0J0VImrl5DItYANVVJ+4oGwtd5bBzZYeHzDcfbqWMhH1jZ
 LQIaj905OiX6E9breSN8cBvA0+A65Xh9EAOE2uFRv7HBUQ/GgJA6JL8K/ApsXm/MpvVjsYgp
 2iwzbcB2Wd4ozrmHUAjO1CELcToCUd/nkZMPruRhRJ+bk3IOR+GmPeDgBHrRRvlIph0KmIk7
 o8d3etsJ8DbkS9SE3Tfv/05bkIJCoMliQnjQZ37BojeMjkit+s7ATQRMPFBeAQgA6CUUbbL8
 LtKj22CmRsWvrCeOMw1/KCwa/1A/GhEkz4u517XOVRUUO7+uiRCpCk2KvU/ydvT+R7HcTKJo
 keaW2kVGgI3hDbHMc12PAWU2Vc0qLakOmR8jnhqpCl4TTVVMe6RWRdQDuOm5PDm/vuoxBTQk
 iFDYIg7BYIBsHd54Dy66Q25UELowuaQE/SQel/jpxONXGEkuawmwz2gSh7SMk37XAj8I7IIn
 NKijIV4LYUfOkJp2uGVHhzffvHBLM5Py0hCcrA7+EPo/R4ns0UMRV4Co7DMk3Q/EwKN7laWV
 3O7zqxmoIu2oCuEADLqM5m8FWzqIWL0dMOpmZmBLBLofXwARAQABwsBlBBgBCAAPAhsMBQJX
 VpyaBQkO3LM8AAoJEIysKpZ4VI41kGsH/j8+IbuS+vIdcWgzHXwe8f4sP9+pEQjKCR4LgbVr
 gd+35DCTwZNLFBDdv0rkv3i7wv/Jmgh4UUTXZif9Umw11JOeRdH7L6nCpR7wu+sXfZFyHmNd
 bRyMz4NN75Kah6fumWSCHf6JiZtCU/gpfMVnlb/oBG7viUldYHn6HLIP4CQM+2l/8bDRh+In
 NKBEEm1jHXgHGoM+Cqi5g6lnf59xFFFA8VWr07kZeHn0tjv98gIq9Uk1StWi66Y6WDDtVNq5
 Gyy51NlEgttKhw/c6+tJC807rBccdVtG7AoBsSub89ofJ5stY+A3Uj9AnSJzg5MnCzIR9aeX
 JvmyGcVIPOmLAPA=
Message-ID: <b49cf013-79ca-3ad3-14e2-9227fde5b080@geekplace.eu>
Date: Wed, 16 May 2018 14:09:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516120527.29403-4-flo@geekplace.eu>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="n2ueeaajkcQ5qUIBaGE0cm0oLb3n0nMnX"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538308576095679?=
X-GMAIL-MSGID: =?utf-8?q?1600622530249621315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n2ueeaajkcQ5qUIBaGE0cm0oLb3n0nMnX
Content-Type: multipart/mixed; boundary="uqdopWMkAJLQnMmclIKsaGm994olodAg5";
 protected-headers="v1"
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <b49cf013-79ca-3ad3-14e2-9227fde5b080@geekplace.eu>
Subject: Re: [PATCH v4 3/3] driver-core: print bus registration error value
References: <20180516120527.29403-1-flo@geekplace.eu>
 <20180516120527.29403-4-flo@geekplace.eu>
In-Reply-To: <20180516120527.29403-4-flo@geekplace.eu>

--uqdopWMkAJLQnMmclIKsaGm994olodAg5
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 16.05.2018 14:05, Florian Schmaus wrote:
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> ---
>=20
> Notes:
>     - Use correct member name 'bus_register_error'
>     - Only print out error code if it is non-zero
>=20
>  drivers/base/bus.c    |  4 +++-
>  drivers/base/driver.c | 13 ++++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index dce677dddba4..5814ecb07648 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -849,8 +849,10 @@ int bus_register(struct bus_type *bus)
>  	struct lock_class_key *key =3D &bus->lock_key;
> =20
>  	priv =3D kzalloc(sizeof(struct subsys_private), GFP_KERNEL);
> -	if (!priv)
> +	if (!priv) {
> +		bus->bus_register_error =3D -ENOMEM;
>  		return -ENOMEM;
> +	}
> =20
>  	priv->bus =3D bus;
>  	bus->p =3D priv;

I'm sorry, this change was meant to be part of 2/3 (and not 3/3). Shall
I send a v5 where this is fixed?

- Florian


--uqdopWMkAJLQnMmclIKsaGm994olodAg5--

--n2ueeaajkcQ5qUIBaGE0cm0oLb3n0nMnX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEl3UFnzoh3OFr5PuuIjmn6PWFIFIFAlr8H5JfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDk3
NzUwNTlGM0EyMURDRTE2QkU0RkJBRTIyMzlBN0U4RjU4NTIwNTIACgkQIjmn6PWF
IFJbeAf/W3Dh5wl8IdpFO/klXmFi/Y5mC2VFQpcOTMKBs3bf5Kfz6jN+T7wKyeY3
JSQ9iaCQUJ+OUNBfHbR3TBLvGvALc6lI7kA7ovwEyBggXXUm/Q7bwpbO92WdxUPb
FPscIeuBU2BQ6Sa+phUHO1hd4aPhC6t/nMnSCVkjSmfbNMGxa3jJaI7MPXFaEG8L
UtUKgefSDKyv7a60X4nO2TUwpxfcEQw3czLCsSR4UOa25kd9rO73aQbGP6B2cH4Y
eZ2DHryjEnJB7R2fozqiAAw3TwEgVQZSH9enwdjOKajo0Zf0anpuviz72MRqnwy+
ZYOGWdIfxLkfIeWp8mM1kKVavH2keg==
=C+UE
-----END PGP SIGNATURE-----

--n2ueeaajkcQ5qUIBaGE0cm0oLb3n0nMnX--
