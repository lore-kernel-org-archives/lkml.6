Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeB1B1D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 20:27:03 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:41418 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeB1B1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 20:27:02 -0500
X-Google-Smtp-Source: AH8x224/3hEofOcj73xwTBwIIzlma60Df9KlqhdhcI0dbyCT48X/yMlTcxM+KtdGqJLvDGtbyVzgwA==
Date: Tue, 27 Feb 2018 15:26:58 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: linux-mm@kvack.org, Nitin Gupta <ngupta@vflare.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zsmalloc: strength reduce zspage_size calculation
Message-ID: <20180228012658.t3z5uowdn24wxv6z@gmail.com>
References: <20180226122126.coxtwkv5bqifariz@gmail.com>
 <20180228000319.GD168047@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h4krtnu4bl2l2wvd"
Content-Disposition: inline
In-Reply-To: <20180228000319.GD168047@rodete-desktop-imager.corp.google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h4krtnu4bl2l2wvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 09:03:19AM +0900, Minchan Kim wrote:
> Thanks for the patch! However, it's used only zs_create_pool which
> is really cold path so I don't feel it would improve for real practice.

Very true; in retrospect this this definitely isn't a very hot path at
all, haha. Cheers :)

--=20
Joey Pabalinas

--h4krtnu4bl2l2wvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlqWBWIACgkQruvLfWhy
VBnRWw//RHfWVjVfAS7WBjdIKdL4pITqIm2qWHpL/L/RQw9g8RhtgP++gBtB2pVP
HN7TZ3OW/+3qzCtzY1QLgjbGu5wA/gBuL6oz+xq4pihZozHhby5Qv1ndzvTl+MwL
/8pIfjKKn4hTRQvGSkf31EXkehGyx60BLSx7qEMfSkmfFny2jEeG6LX8HmH8wCyp
fOYC/8DoQcc943eOsVgZ450258qEBvCCDZ7Qk2yy+gqdsLYgtWKtFaagKbUSD6xv
/tCsHD2LaOtD+iLcAG5zLkQioF6h/D7yCowLEfDCAmZnBVMxruRH7559R+8XN/xt
5SB0hc4BVLx2rH/YWx0/sRGteJwCDNbGEC95wB5hiHJOQcEbjny86mv+IbRXpXs2
nQs9FYBmpHHOUZlKtMguhjGd3NaP9G5MfKclXJsIIOn9ZVI2U4nCD8P+z99XsTMK
JUDuxSfNrY+ylpHxPxmyYocx1w5sxjvG/3CvjVkZpKh1VKxQ3fYjbR8xPs8muqqe
xSa/8Rh5y+/s7ZvOLeez0r9fAeBfoiyxDx1OKB4qJTpPYzc89N2hcghF6WZGqeKL
3uV/LAvGv9JQzUUbFqsEZdcJsiwmKEd9m6CsbvFMEQfEGsZFLzcFYmeaPh0RQphL
YameC05JCZ1zKc6TyaU1ZW5cgwrnN5lu83srrAnRN03tYwdyHyw=
=JDEO
-----END PGP SIGNATURE-----

--h4krtnu4bl2l2wvd--
