Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217D6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B7C21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfAXFmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 00:42:24 -0500
Received: from sauhun.de ([88.99.104.3]:40002 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfAXFmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 00:42:24 -0500
Received: from localhost (p54B333E7.dip0.t-ipconnect.de [84.179.51.231])
        by pokefinder.org (Postfix) with ESMTPSA id D2CCA2C3720;
        Thu, 24 Jan 2019 06:42:21 +0100 (CET)
Date:   Thu, 24 Jan 2019 06:42:21 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Elie Morisse <syniurge@gmail.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Message-ID: <20190124054221.GA909@kunai>
References: <20181226232258.GA23526@syn-yoga530>
 <ecb5ecad-7141-b8db-74dc-a53f2a17301c@amd.com>
 <86BE166C-0821-4E16-AE72-728752654C20@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <86BE166C-0821-4E16-AE72-728752654C20@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Looks ok for me
>=20
> With Shah=E2=80=99s blessing, is it possible to merge this patch to your =
-next tree?

I am currently reviewing it, but the driver is large so it takes time.


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxJUDgACgkQFA3kzBSg
KbbcihAApL+J0SRy5db/uA5q3OC/9WcRCbgXpfWHayOln7yah97iu2tA4kKYnUWa
UwoltkFoV5/4T/YMT8QxMrqP5aux2xeIWt1zmfLwk7AdmRsqOJxRB5vPpQF7yxax
urEXkOxPjLcie7fHOjE6S1EdKcW92m3rOpv3boeOkMUFRlUsm4bY4+WV5Ame5n4L
RRnug06IWCSvKo7ts8bx1Ef/sdcwrnPtg+fmSW/EdyFo/jq4WlqUztuY8O453Ocf
PnFPTt2ej7/MeYnWuif6GxSpuQb1l42qCA3vldjjb4BBdUsHUFTaZSyKJke1D88I
TKnFhjD3dokSyU52Uq/ywI8wn8eEZwvQ99vFBV5+OVge2m1FgLijZzMioIZNJWuk
uPP6Pd/3eSvVuTuC3HVzuzSJsYIZ4wCjc6brypxuzPRMK6926hvElTPx+Jlm8O4a
aXcsgbXSCKOhw8YAhtqzSduqmW+oHS83jsxIEsmEf5tnFLW+fnkwOTsK20ad86ay
Ar3J4hMTSRvxQGuOYJhmOB7RTGtBXi1/EeFZKrScGSPA4RVYcZngc89c4Ly2MAy0
ECl821ld4GISlo8L2Sa4yETlFbPYoYUAhsiJYzDfbtkHVIWASARQEpnKq/rluxsv
c476j1qhD6IbH8rx1xYlTcMqGMoDq5DzY5Ko89DM+oEY/k+I8mg=
=7MVd
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
