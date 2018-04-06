Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeDFV0J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbeDFV0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:26:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F4F217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Fri, 6 Apr 2018 22:26:01 +0100
From: James Hogan <jhogan@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
Message-ID: <20180406212601.GA1730@saruman>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
 <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2018 at 02:15:57PM -0400, Sinan Kaya wrote:
> On 4/5/2018 9:34 PM, Sinan Kaya wrote:
> > Can we get these merged to 4.17?=20
> >=20
> > There was a consensus to fix the architectures having API violation iss=
ues.
> > https://www.mail-archive.com/netdev@vger.kernel.org/msg225971.html
> >=20
> >=20
>=20
> Any news on the MIPS front? Is this something that Arnd can merge? or doe=
s it have
> to go through the MIPS tree.

It needs some MIPS input really. I'll try and take a look soon. Thanks
for the nudge.

> It feels like the MIPS is dead since nobody replied to me in the last few=
 weeks on
> a very important topic.

Not dead, just both maintainers heavily distracted by real life right
now (which sadly, for me at least, trumps this very important topic) and
doing the best they can given the circumstances.

Cheers
James

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrH5eMACgkQbAtpk944
dnrcJQ/9HbKEDW760nVDpPAM4P/qFnLetVd5/07IiDl+GABtbOJguepbgs+/al9U
KODYpvd8ZM/BF35t0HVaN/UZA9L5OXbNG/cPAdUviojCZIk8NTUoijll1Wdo2fnV
9ACAv4tLOERuLVGcvE6x5uD/rP1kO09z3voEYTSsjx2jCOcgtBK0hmNGzOw2eRVh
cSwKNA5BWp4BpafUQawCYiKUDXfOWfE5vSlQMc1rUI4Q28gPLqHRrlO+07nDUcpW
CivnyPmlgZ8IIgiuzUVSSTkGNIBx50Ybdcw/MsraU7xU2m87WsOlf5+RcTVKSIvs
t8XAs2vQFYFKrnShvHZavKa4o33zPFHIGJIlfTZvG6SnNHts2XE2Tr9GzfVV0ZWP
lcTpVhe0feOevDcW8VEqr0DTrXYa8NFNuMssno6b4cYnR/HAD6TGuSQSwxi1iz9p
vsWz23C+kuHQIPSl4MYVFJLa/+WDDM5IutMIEFR7C8W3PcNSKpPeoiiZXuhQaqdY
0ZXQJ1NYK4rot6BNiguhsTCKSGWlMDBYK/di+r+NKuT7rS2/YEb8O8hY0ysf3rq/
x3iI/JADa+ftoF8T9UFEZEpKf1hvqV4g4BA2QfimSUlJCUfG7T+kW5mH3siQ7MmL
X+wL4fqU/2TiyGhlHnmMlsSmhVqip/+8WBI8cSCdX8DYMKlIEiw=
=hKSm
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
