Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1A2C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53E2206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53E2206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeKUEXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:23:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52198 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730418AbeKUEXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:23:10 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gPACb-0006t6-NM; Tue, 20 Nov 2018 17:52:45 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gPACb-0003qm-Hn; Tue, 20 Nov 2018 17:52:45 +0000
Message-ID: <a76431e14826b15e179081048d6e4056d07e2db7.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 298/366] kthread, tracing: Don't expose
 half-written comm when creating kthreads
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Snild Dolkow <snild@sony.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     akpm@linux-foundation.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date:   Tue, 20 Nov 2018 17:52:45 +0000
In-Reply-To: <17edd54d-a979-b66d-1b30-1d1f9b1142a3@sony.com>
References: <lsq.1541965745.673358820@decadent.org.uk>
         <17edd54d-a979-b66d-1b30-1d1f9b1142a3@sony.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-m0EN5ql9yJBpKaJYSe4V"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-m0EN5ql9yJBpKaJYSe4V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-11-12 at 09:10 +0100, Snild Dolkow wrote:
> On 11/11/18 8:49 PM, Ben Hutchings wrote:
> > 3.16.61-rc1 review patch.  If anyone has any objections, please let me =
know.
> >=20
> > ------------------
> >=20
> > From: Snild Dolkow <snild@sony.com>
> >=20
> > commit 3e536e222f2930534c252c1cc7ae799c725c5ff9 upstream.
[...]
> Reviewed-by: Snild Dolkow <snild@sony.com>

Thanks!

Ben.

--=20
Ben Hutchings
Time is nature's way of making sure that
everything doesn't happen at once.



--=-m0EN5ql9yJBpKaJYSe4V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlv0Se0ACgkQ57/I7JWG
EQmszg/+Pn0BKmBFC5kVT8lH66h8EdhyKorjUUH1ULZNdjLnPBvEChtb7jPLJKGT
ocJBZZM3m5CtTexYX3R1a5uSHMKZHPsYdIHRExT+28qMeZCI8QYsISqYs6WtKZnz
/sJCtgF40qNq0jIuMVOgCA+WnZ/pH9eszn54Ad5mfzqY2ZAwE+49KCS1EtpViIEw
A29RfXzHLb+PS+fjS2uXiD72poCiKaimjXuT6MTYf7PrWOTPsUDsA84l6uJz1tIi
84c5bY5Aw4WnHO57z+vNoO0s5pd4J1irQ3D3gNvvxR5i5PUlNaueqatAm6Ck+rOT
Qvtfw7ZA/i7Cqz7zeIl2zBRnjYsgvCHkxfpMLqR9ByQ3/5ll1m0N3/G81HuLVX8k
Zge+4MHWYmpAQrYIUfPM4ozjEUThZh6FcrOyWkrWY2VmXfwE5R3dXTduuLW3bUMh
3m5mmaLQebbsIJ1UEN2vHOCcHOStjQXlZabiQj4EW6ZtCf6Piq8KXikgoDyULg1D
ELc2Lo3JjAzH579UKftQcIcjLlrF3Cxb6LqzrNJn/EROEqib3HhM2zy+k24dU7kY
mdGqFAN9WXsUZartSVW1O6Kd3jKO+ow/hSBXQ3DFCLgAdbKvhZaenfjWpWTGj5no
G3QJDQ/iEOZT/nrJVj5GRnrImQ7Et+sUXjMTfhCH9bjPpfzQPCo=
=AdAZ
-----END PGP SIGNATURE-----

--=-m0EN5ql9yJBpKaJYSe4V--
