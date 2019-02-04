Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E79C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C692082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfBDXvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:51:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40098 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfBDXvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:51:44 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqo1e-0004Lp-5L; Mon, 04 Feb 2019 23:51:42 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqo1e-0000DU-0P; Tue, 05 Feb 2019 00:51:42 +0100
Message-ID: <b4167f473406a3813495cb9584d3eb09b479c7c4.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/305] 3.16.63-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>,
        akpm@linux-foundation.org
Date:   Tue, 05 Feb 2019 00:51:37 +0100
In-Reply-To: <20190204213839.GA18895@roeck-us.net>
References: <lsq.1549201507.384106140@decadent.org.uk>
         <20190204213839.GA18895@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-wK1Ot7jQSysGQwnQJQJ0"
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wK1Ot7jQSysGQwnQJQJ0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-02-04 at 13:38 -0800, Guenter Roeck wrote:
> On Sun, Feb 03, 2019 at 02:45:07PM +0100, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.63 release.
> > There are 305 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Fri Feb 08 18:00:00 UTC 2019.
> > Anything received after that time might be too late.
> >=20
>=20
> Build results:
> 	total: 137 pass: 136 fail: 1
> Failed builds:=20
> 	i386:tools/perf=20
> Qemu test results:
> 	total: 222 pass: 222 fail: 0

Great, thanks for checking.

Ben.

--=20
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.



--=-wK1Ot7jQSysGQwnQJQJ0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlxY0AkACgkQ57/I7JWG
EQntgxAAj6UTPORz7AfR/z2A3UXPs9EeywrjspmTH5Twua5PVrCPYb13nIcYOToE
TTOhkQKcHmflK3+a5CnfNN5XtPoKe6MBPtL1LweqyJuqeI3v8JkidTsjpT/W9uy0
49SGoXG3X5r7KER/lncovGK3W0LHf9EXAXTysnLLuXvEPqICAMIJVMIU8gIWK4Zz
TycfPJ5JiU1igegwcGdygSaIycmcDBpkulyoAlTzdCJL6OvNYYaOXywIxu4p1fBk
g5j1js90CnFyGlvHbJHYYJJ7HNd/7aF5k36SvTTaCgp8XhKGaNj7PK7YTr6q6BX4
xPBNNoaDmS+UIDZB6fQsUBU1r0qC7haClDsLdP9YemEUjFxxKAqLTfoMONFIUd+O
6Dvf5jFE9LAZVef14hOB3K3yLT5Yk/8RToPkgrGU8/njXMoXHRZMJlx2HYQpx225
0d9iTzILh7S5j03Q9jOJt0qG+TAGiAvVi7sJtqReqWanlw83iY6PPJTiz0KuT1wl
fG/RR1vlX7FdJAf8d10u43oDasTlyqYrJaBiccvK9wv+DMPS+Xmy1xzf2paiUULo
dUZJvM+BNXeN/jdwwxxqTNOfvmboT50/LdiU4xBXv7ZOc6fhsMC0H62SISXetV7e
NqytPgfU/qtWMpDQOxZWrcFS5IFj67cTaR9OPuiRRlCGPKphEgw=
=Lr4r
-----END PGP SIGNATURE-----

--=-wK1Ot7jQSysGQwnQJQJ0--
