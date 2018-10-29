Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87734C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449D42084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449D42084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbeJ2Rkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:40:47 -0400
Received: from sauhun.de ([88.99.104.3]:33228 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbeJ2Rkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:40:47 -0400
Received: from localhost (unknown [87.114.85.207])
        by pokefinder.org (Postfix) with ESMTPSA id 473BE2CF60D;
        Mon, 29 Oct 2018 09:53:03 +0100 (CET)
Date:   Mon, 29 Oct 2018 08:53:01 +0000
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Korsgaard <jacmet@sunsite.dk>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] i2c:ocores: do not handle IRQ if IF is not set
Message-ID: <20181029085259.GA4101@kunai>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
 <20180625161303.7991-3-federico.vaga@cern.ch>
 <CACXmViZZ3SBPbV4AXK6EsJPfD5TJqEU_-Q36+vz5LxTk_pzq4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <CACXmViZZ3SBPbV4AXK6EsJPfD5TJqEU_-Q36+vz5LxTk_pzq4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2018 at 04:12:10PM +0200, Peter Korsgaard wrote:
> On Mon, Jun 25, 2018 at 6:14 PM Federico Vaga <federico.vaga@cern.ch> wro=
te:
> >
> > If the Interrupt Flag (IF) is not set, we should not handle the IRQ:
> > - the line can be shared with other devices
> > - it can be a spurious interrupt
> >
> > To avoid reading twice the status register, the ocores_process() functi=
on
> > expects it to be read by the caller.
> >
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
>=20
> Looks good.
>=20
> Acked-by: Peter Korsgaard <peter@korsgaard.com>

I assume this patch will be resent when the other patches get updated?
Or shall I pick this one independently of the others?


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWymcACgkQFA3kzBSg
KbbkThAAkno+UvEC0fsht0p1uwzti9jL8JMH50loKl1WczNQ4Hp4Te58W9XJEUZf
xgPOpFso7/Q5tI0eOHoJOXGxWgpIGXYtxLVuIM1cghRD5XRD+m9UnOMW8XzIoc7R
SBpmCFNGuE98fsZ/PUbSADKuiHLV027+iQ2zuAPyIXYAH70v8PerRz7MvxJyKbBE
LVnEQjFXOkOGM2ZixZ5ImSEElDHXNpxBlj6H34UC9NgtpkDFp9ToEngYfWXE/5p8
V0dzDuOS7pGFmN9koVlH/7o4CEQ10AMnWeFTBqXcUGc7YDAnu7ywNkXnogFySVLO
CiRciV/YY+8l2pTsOlhO+CaTBo8RE0GmbKee2T9oXPlt07eboqKDK2DjfRLxJcyH
xfGxUZLgTKaVt1vNAeTtZi0siUXBo2mnHznDbxxMExlanLlCyH93okyEPwFrf23d
g4sBfYvMWDIywFlm0XOqfUd6NM1jBu3/jvMMH0I453Yoxg53Bffd7usdbS01tuZR
PzJhDgeBXG4xnxrQDI4otHUyTK1w9Cu2hU53tW5H82Pe/gb350hIElODuZnvJc3W
+B+G89L01n82xyXFjPN0nsey/n2QriSI5mbf6rSiZE5j17Rl1jt4Zk8t3yPNiqH0
sxuOvuLmrYSrpriJsIJqfvJ486fZeFeyIwjJIEnKvruzZn9COHM=
=nbLE
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
