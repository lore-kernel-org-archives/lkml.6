Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE17C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB7C21B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfBKQTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:19:45 -0500
Received: from sauhun.de ([88.99.104.3]:56306 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbfBKQTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:19:45 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id 6A25D2E3542;
        Mon, 11 Feb 2019 17:19:43 +0100 (CET)
Date:   Mon, 11 Feb 2019 17:19:43 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] i2c:ocores: checkpatch fixes
Message-ID: <20190211161942.ckuys4vyagbwaklq@ninjato>
References: <20190211160529.23858-1-federico.vaga@cern.ch>
 <20190211160529.23858-6-federico.vaga@cern.ch>
 <bbaaa303-75f1-9272-c01f-914175237f05@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ilmmbb5oktml3kgo"
Content-Disposition: inline
In-Reply-To: <bbaaa303-75f1-9272-c01f-914175237f05@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ilmmbb5oktml3kgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
> > +	ctrl =3D oc_getreg(i2c, OCI2C_CONTROL);
>=20
> There's a pointless double oc_getreg(i2c, OCI2C_CONTROL).

In case you need to resend, please update $subject of all patches to
have a space after "i2c:"


--ilmmbb5oktml3kgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhoJoACgkQFA3kzBSg
Kba1Jg//Y2TAKnvmcdIGORStIcuiD/0IlmwxPPAVZeBtUgU2an8cczAtGq/dNPNl
gN1bCNz/GsHf4f/52RFV8VIQGBUfEYCLeS5vnaIAUefnG6IT7+i6OSwDAucnxWz4
zsJBJ5VFmojraNVuIo3x5RjOBHqeuKhMyIlwcl4GkRYMTp/vwqXs09GwIMltsq8c
hJ71wJMHD61J1U2zv5aOuzXrlnn+WqSQsaOWv+zF5AcdxCkSrWyZMBKa00EBBxAM
u+h7Y8zwDy28MO92ZLRngAUHsdM6zA2sjGFCelg9XYUl/3mgcABiIXfDVuYbuiv/
DmYfRILT6voASocPS2kLInjjNpKBojw9FuWnDt1fos9i/KU9Hd1hR8sialiLOL46
0EpDuOAx0D7PmAHiOiNbBi6jM5N/cPj+ZeacpCwdGaHuF6IdrUwBrtkrM9ZDw8jm
+yEQyvhVwQrAZaFBqHunsC0CMnMbuT/xxyTxMWxBcZCub6e2bSBHaAFEfuodT1Yh
gLJZ8FBlMTl/5pJsCzN+EcPUqGWQEmUbFK4BmmJUmPYboa3syz2C7W2l3hmu/6Xk
9BzKkFWz2MBnRp/d2aKl7LZ2NaZhwNjvJriXBcBSsU+wtTA80ylCI8bdyyMclPPi
uHl127swpiVim4KgBYjAQFIeNbv8AlovjRle8C9R8Cj5F8kO0/o=
=GpBh
-----END PGP SIGNATURE-----

--ilmmbb5oktml3kgo--
