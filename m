Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED259C67788
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923FA2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923FA2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeIMU7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:59:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36184 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727365AbeIMU7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:59:18 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g0Tri-0004pd-Hz; Thu, 13 Sep 2018 16:49:10 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g0Trh-0000Eb-SB; Thu, 13 Sep 2018 16:49:09 +0100
Message-ID: <0dbcdd4d81ed965915ccf2471dd4d5a3d025c93b.camel@decadent.org.uk>
Subject: Re: 4.19-rc3: bindeb-pkg target is failing on ppc64
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Sep 2018 16:48:59 +0100
In-Reply-To: <CALjTZvYcKOycB=XeF-Eqtmq3ADh2be+gfWGiw0jbSgEUo6q8Dw@mail.gmail.com>
References: <CALjTZvb4hOY_Hew-jEUtpyhkGbmh4Tgb0doPC6EaGtz_rMGt7A@mail.gmail.com>
         <eb1fe15c9ced6950d6a38c901278b8196ae4938d.camel@decadent.org.uk>
         <CALjTZvYcKOycB=XeF-Eqtmq3ADh2be+gfWGiw0jbSgEUo6q8Dw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-EuXEQRX8XeOMxJgw3rwr"
User-Agent: Evolution 3.29.92-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EuXEQRX8XeOMxJgw3rwr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Like I said, please send the error messages; we're not going to guess.

Ben.

--=20
Ben Hutchings
Computers are not intelligent.	They only think they are.



--=-EuXEQRX8XeOMxJgw3rwr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAluahusACgkQ57/I7JWG
EQk0EQ/+OCis/y+/5+30XmLUwlPKs/KjCNXUukH62UdlowoVJEo5XhGvGoXUBSh0
guieQGa9adyMyI9vEgAY6QrtxduvCBuAx2CZmTi6lFFCnBP1zKyXOQ1TI07lPz/1
mEZBDFTC52E8tWcC00jWO9/1IKrZ8tMVhDRRYqq0xvXQFNirL2eXcfv6hPm+9hsf
bDeGmEEHZAeLNdJCXN02KsOnyAqLRiXqPQaEWvrlBwBb6+L8iuqOccwtC5l6ShGD
JBMxXAmWg21MREnPkOXwMIMoJ1nzDdhvg8Xfv/O9d+u49nRXCCX8KFOtfCIR50Jy
0sDXAKOycxw3Yojc00D2cvT5NMz0jEt9lQ9jvRfMpcIHWAo1Z7ii61e9beLXhLXT
pYHtCqEeHsjzI5hwvu8B0SElyxWLcPXgBfESSvHHBfGIsEfXIGMnHlqcqEUdKAtK
uzww5vB+/ZYYBkQjjER/PmX5Gcshm2LOS1GXB7sYD+Pv298BcbUCZkKGEdjWCsCg
qXyAUysS0g5KBKPDFww1a6pE+qjxqglSa/rRnzAszS1BdVGBS5tATcAsWI3dQerN
/UBhruBFXtvu+mZ7eveYjndo2n81zEmoDBKzSPUTfOX0QzQGbRyMk8kxAMctydvq
+SAny8x2E6b1G99hYWxBMyo3XOQkUroHlbDyimts8OgI+RR8AK4=
=LS6u
-----END PGP SIGNATURE-----

--=-EuXEQRX8XeOMxJgw3rwr--
