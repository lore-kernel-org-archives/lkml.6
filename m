Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C41C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9276B21848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfA2SIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:08:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46908 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbfA2SIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:08:45 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1goXoP-0008Vj-3c; Tue, 29 Jan 2019 18:08:41 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1goXoO-00040A-UH; Tue, 29 Jan 2019 18:08:40 +0000
Message-ID: <20d22d3678062231a459fcf8ae05ee35efc4b425.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16] x86/eisa: Add missing include
From:   Ben Hutchings <ben@decadent.org.uk>
To:     whiteheadm@acm.org, Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Jan 2019 18:08:40 +0000
In-Reply-To: <CAP8WD_ZoF+C=R07D6uio1fdDVJD5XLS64g=Cgced7BHZ1GbXUQ@mail.gmail.com>
References: <CAP8WD_ZoF+C=R07D6uio1fdDVJD5XLS64g=Cgced7BHZ1GbXUQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-qFaPKzgKeCF4s7gP0Uu8"
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qFaPKzgKeCF4s7gP0Uu8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-01-22 at 14:51 +0000, tedheadster wrote:
> Ben, please backport Thomas Gleixner's patch to the 3.16 series.

This was already in my queue for the next update.

Ben.

> commit ef1d4deab953ecb1dfcf9f167043bda8b3f14a11
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Thu Aug 31 20:08:16 2017 +0200
>=20
>     x86/eisa: Add missing include
>=20
>     The seperation of the EISA init missed to include linux/io.h which br=
eaks
>     the build with some special configurations.
>=20
>     Reported-by: Ingo Molnar <mingo@kernel.org>
>     Fixes: f7eaf6e00fd5 ("x86/boot: Move EISA setup to a separate file")
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>=20
> diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
> index 881f9236ebff..f260e452e4f8 100644
> --- a/arch/x86/kernel/eisa.c
> +++ b/arch/x86/kernel/eisa.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/ioport.h>
>  #include <linux/eisa.h>
> +#include <linux/io.h>
>=20
>   static __init int eisa_bus_probe(void)
>  {
>=20
>=20
--=20
Ben Hutchings
The obvious mathematical breakthrough [to break modern encryption]
would be development of an easy way to factor large prime numbers.
                                                           - Bill Gates



--=-qFaPKzgKeCF4s7gP0Uu8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlxQlqgACgkQ57/I7JWG
EQlWWBAAqhFhD4IuNjYTlgl/ls4AKz3Jybf3PzIX4+oZ7VdHte9k07jLMm+uJrlf
Ha2FGBDQx4tPcM9Pgv5MRPiDo+L6wYYdKgn1GxvukjgJ/8tuI2KmDm6AGXpYpjRt
QJssgKH4WuiGtvr3exH7JgGtAWxW4Cd5w72CMHU76QHjZOFysN7P/gfh+1nnff4t
+3mBNkSPVjpoMWmWFmUGIpZkAVKeUP1qUOSG3J5n07fy6at0vYrlxWqrNlD8N2vr
0d/2law43OJkFiavH2zbJdLS3QMPq6lUSuGdHFxn4dmiTRVl2s3SMH7/EV4dla3v
TVgURVwp/vQC2+YBIb8G6G6yBxZCBJsiLsYrxs1N7Vhc7jWiR9uBiIjK1vBljxIt
QYVDeUNwwzQSwHqOzTOYVjBcmDAZsWkmyuYbBTbJXlQ2l5LrYP0jk506xECmgbBb
WyWE1Txd0q9IvST9zhz48yhOZYlbUWa8PZyWEqfgXwZmNizudsqgfMm0WGdWLzBE
N4oK54thKRjX7vrC7d/CaDEAxScFjyByKpPvTJMPKOdcDzSoeHFU5rClel2C5ENE
yD/efYK4oXTO+yRwIM0DPiN5sCUK8l9W0B50tyeLe6ZsKe+Q6mDqiIvESOPbIVfd
4iKO5tdxU8IOxUWbygcGPX6FtXJo6KrNzLB+aKpHIQrw9sOFJ08=
=xUV0
-----END PGP SIGNATURE-----

--=-qFaPKzgKeCF4s7gP0Uu8--
