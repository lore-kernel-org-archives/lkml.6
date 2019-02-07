Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527B8C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B38D218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBGTOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:14:02 -0500
Received: from brunni.mail.netestate.de ([81.209.177.48]:40175 "EHLO
        brunni.mail.netestate.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGTOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:14:02 -0500
Received: (qmail 3613 invoked from network); 7 Feb 2019 19:14:00 -0000
Received: from localhost.netestate.de (HELO fiano.netestate.de) (127.0.0.1)
  by localhost.netestate.de with ESMTP; 7 Feb 2019 19:14:00 -0000
Received: from fiano.netestate.de (81.209.177.7)
  by brunni.mail.netestate.de with SMTP via TCP; Thu, 07 Feb 2019 20:14:00 +0100
Received: (qmail 14306 invoked by uid 503); 7 Feb 2019 19:13:59 -0000
Date:   Thu, 7 Feb 2019 20:13:59 +0100
From:   Michael Brunnbauer <brunni@netestate.de>
To:     linux-kernel@vger.kernel.org
Subject: Re: Kernel panics with recent 4.9 Kernels
Message-ID: <20190207191359.GA14298@netestate.de>
References: <20190205091239.GA3687@netestate.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20190205091239.GA3687@netestate.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hi,

no replies to my mail. Any suggestions what I should do or where I could as=
k for help?

thnx,
cu,
brunni

On Tue, Feb 05, 2019 at 10:12:40AM +0100, Michael Brunnbauer wrote:
>=20
> hi all,
>=20
> with Kernel 4.9.150, I sometimes have "kernel panic - not syncing: Fatal=
=20
> exception in interrupt" on two different servers. Dunno how to reproduce =
but
> may be connected to high network traffic. Find screenshots, config.txt and
> boot.msg here: https://www.netestate.de/kernel_panic/
>=20
> cu,
> brunni
>=20
> --=20
> ++  Michael Brunnbauer
> ++  netEstate GmbH
> ++  Geisenhausener Stra=DFe 11a
> ++  81379 M=FCnchen
> ++  Tel +49 89 32 19 77 80
> ++  Fax +49 89 32 19 77 89=20
> ++  E-Mail brunni@netestate.de
> ++  https://www.netestate.de/
> ++
> ++  Sitz: M=FCnchen, HRB Nr.142452 (Handelsregister B M=FCnchen)
> ++  USt-IdNr. DE221033342
> ++  Gesch=E4ftsf=FChrer: Michael Brunnbauer, Franz Brunnbauer
> ++  Prokurist: Dipl. Kfm. (Univ.) Markus Hendel



--=20
++  Michael Brunnbauer
++  netEstate GmbH
++  Geisenhausener Stra=DFe 11a
++  81379 M=FCnchen
++  Tel +49 89 32 19 77 80
++  Fax +49 89 32 19 77 89=20
++  E-Mail brunni@netestate.de
++  https://www.netestate.de/
++
++  Sitz: M=FCnchen, HRB Nr.142452 (Handelsregister B M=FCnchen)
++  USt-IdNr. DE221033342
++  Gesch=E4ftsf=FChrer: Michael Brunnbauer, Franz Brunnbauer
++  Prokurist: Dipl. Kfm. (Univ.) Markus Hendel

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAlxcg3cACgkQvo+oDi22HrlYMgCgvzVVI0bEQ35zHQgDRjN+n23y
nqEAn1ln+tuRY7YSRnzoRCQZc8ODNvBJ
=Rv+H
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
