Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935453AbeEYGJI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 02:09:08 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:57678 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeEYGJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 02:09:06 -0400
Subject: Turris Omnia firmware possibilities [Was: Re: led: hw-trigger, global
 brightness and multi-colored leds]
To: Tomas Hlavacek <tomas.hlavacek@nic.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
 <CAEB7QLBcLnv4JYphjxqESqofTbGyVWOd6QYKzfvdEZyDXH9LLQ@mail.gmail.com>
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Openpgp: preference=signencrypt
Autocrypt: addr=uwe@kleine-koenig.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e72ed1b1-1225-2782-e207-1af6af347810@kleine-koenig.org>
Date: Fri, 25 May 2018 08:08:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAEB7QLBcLnv4JYphjxqESqofTbGyVWOd6QYKzfvdEZyDXH9LLQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dqvHR029Jjs1R5OkF9AVYUPo7BNncKuoT"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dqvHR029Jjs1R5OkF9AVYUPo7BNncKuoT
Content-Type: multipart/mixed; boundary="UTtihMLZlz5WtpzAoJnLHRy3oyxth20Ej";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Tomas Hlavacek <tomas.hlavacek@nic.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek
 <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Message-ID: <e72ed1b1-1225-2782-e207-1af6af347810@kleine-koenig.org>
Subject: Turris Omnia firmware possibilities [Was: Re: led: hw-trigger, global
 brightness and multi-colored leds]
References: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
 <CAEB7QLBcLnv4JYphjxqESqofTbGyVWOd6QYKzfvdEZyDXH9LLQ@mail.gmail.com>
In-Reply-To: <CAEB7QLBcLnv4JYphjxqESqofTbGyVWOd6QYKzfvdEZyDXH9LLQ@mail.gmail.com>

--UTtihMLZlz5WtpzAoJnLHRy3oyxth20Ej
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Tomas,

On 05/25/2018 12:08 AM, Tomas Hlavacek wrote:
> But I also have good news: The FW of the MCU is also OSS (see the repo
> in the link (1)). There is a method for flashing the MCU over I2C from
> Linux and there is JTAG connector for the MCU, in case un-bricking is
> needed. Therefore the LED protocol can be changed to be more sensible
> and/or it is even possible to emulate some existing HW LED driver chip
> in Omnia MCU and reuse OSS driver for that chip.

Yeah, I noticed, but when we start replacing the firmware, we'd need to
detect somehow when a machine has an old (or only different) firmware.
That would imply a versioning scheme and a generic way to read out the
firmware version. (CMD_GET_FW_VERSION_BOOT is already a start, but this
doesn't help me if I find an unknown hash.) So a CMD_GET_FW_SOMETHING
that yields a version string that is similar to the soname of a library
would be great.

Talking about firmware, I wonder if there is firmware supported needed
to solve
https://wiki.debian.org/InstallingDebianOn/TurrisOmnia#Power_Management
=2E Didn't look into that deeply yet and probably not high prio given tha=
t
normally the Turris Omnia will just run 7x24h.

Best regards
Uwe


--UTtihMLZlz5WtpzAoJnLHRy3oyxth20Ej--

--dqvHR029Jjs1R5OkF9AVYUPo7BNncKuoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlsHqHgACgkQwfwUeK3K
7AnDxAf9F4gkgLDOo3theNCuDOU6f4aW46Bzp0fTlCXak2ZcFJk9T1wyFOdq5zBQ
n+dxRAM/og8PIxe74F11uMveJHNXZbQDd+Pz0ojExn4ieF1TnGW68qb//O7dqBRD
IVf/zle3q83hGfZXgEl0ziS2X6WQ6iBHNIKyz71vGeZ0X1ahcV66h0Vk0L6nZaFo
ENWGinyO6VeaXltaTkUqwsTQoRytMr8UDvpi8+bdkHkcrqxEXx12aVfJFZj7GwLc
6Ep57lvnm1BjzbEEU2rhT3xhxI9NaphZGHmFrdjVpI8h50xdGKGDJHvndLZ7EZf2
mItg38rZiP5e7DeKiRW+/so/8pAbtQ==
=4Ry1
-----END PGP SIGNATURE-----

--dqvHR029Jjs1R5OkF9AVYUPo7BNncKuoT--
