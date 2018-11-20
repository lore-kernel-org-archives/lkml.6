Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7141C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7242B206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7242B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeKUE2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:28:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52232 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbeKUE2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:28:06 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gPAHO-00077i-Pb; Tue, 20 Nov 2018 17:57:42 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gPAHO-0003uJ-KK; Tue, 20 Nov 2018 17:57:42 +0000
Message-ID: <728e91ef0685abd3c2dc859c72c0b30af4f3e022.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/366] 3.16.61-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Date:   Tue, 20 Nov 2018 17:57:38 +0000
In-Reply-To: <20181113015707.GA5984@roeck-us.net>
References: <lsq.1541965744.387173642@decadent.org.uk>
         <20181113015707.GA5984@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-FCgKBHwjOkeyfB56p3mY"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FCgKBHwjOkeyfB56p3mY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-11-12 at 17:57 -0800, Guenter Roeck wrote:
> On Sun, Nov 11, 2018 at 07:49:04PM +0000, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.61 release.
> > There are 366 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Fri Nov 16 18:00:00 UTC 2018.
> > Anything received after that time might be too late.
> >=20
> Build results:
> 	total: 140 pass: 139 fail: 1

So perf now builds in your x86_64 environment but still fails on i386.=20
I didn't try i386 but that's still surprising...

> Failed builds:=20
> 	i386:tools/perf
> Qemu test results:
> 	total: 217 pass: 217 fail: 0
>=20
> Details are available at https://kerneltests.org/builders/.

Thanks for checking.

Ben.

--=20
Ben Hutchings
Time is nature's way of making sure that
everything doesn't happen at once.



--=-FCgKBHwjOkeyfB56p3mY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlv0SxIACgkQ57/I7JWG
EQkBkRAAo9u0mDqbwogQmaXm3COyMimqFSuHcprE4xWsvgisjfJ2OONQVfvfZl7k
UwUsH1jgKzr1pp2HiOVguap1fexltRi1+V8rnBu1bsjC3lTrRRdw1Lz4yKzLKTtE
EA46++iOW8Qv7tNqD120RiiK5qjTZRwf5nXyuZsJP9Hpg2zt7+FekvlNZci/vyOW
iYqr9UxYoc5vFcrkr2hB6bCXZ3upKmku1b01v+dY0GRO/rfPfXphy0is8/YcEfJ2
YqGkJGohUPcXQHrvAm8N9ZpK0C4ni6jHIiNZG6jN2dndNmaPnAXIiHkHKZ8MS055
QrMqsywHXERdMRFB6nblnivu9eiyBOsnvW8t+YMRGoksNh1CrKlEeV8FGUmdJ3we
cBHPVCT/Qa4AnqHMGyDf1/KMen2ZWL8X7YcnFBz2Nl/KuUq15c9PpAiLvCA1EL2D
J3Uty8LCLbFDYyKwcUUIUnND9dj5/O3PMr3aymY6UT3AFgNgAfN9nsuK5LtgQya8
eoO9DTO2Pkvrn5Osbki5+nTHuibDJXVdVM1jnJRTitsvuBKM7aCkYwVbFkt9KEAL
VCdFVRwHWRR8qwXHfl3LpCzIY8blhH/BQ+uRprbo2dZ0WSt6DkBGz0PsH6xNnhHx
Mkkv0DBB+FFi5XMvaWkcuZyRGf20PbzH3QXYd7JtT9LvqRRLqug=
=XaBv
-----END PGP SIGNATURE-----

--=-FCgKBHwjOkeyfB56p3mY--
