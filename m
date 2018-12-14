Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C83C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E3520892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E3520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbeLNMcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:32:33 -0500
Received: from mx1.emlix.com ([46.4.235.150]:34310 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729974AbeLNMJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:03 -0500
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 72F462605F7;
        Fri, 14 Dec 2018 13:09:01 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] scripts: use pkg-config to locate libcrypto
Date:   Fri, 14 Dec 2018 13:08:56 +0100
Message-ID: <2004385.IFYbe2Do0L@devpool21>
Organization: emlix GmbH
In-Reply-To: <1637606.U1sPAt16y5@devpool21>
References: <2429714.x0fLlpPdDl@devpool21> <20181124055339.E3B9120881@mail.kernel.org> <1637606.U1sPAt16y5@devpool21>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3571005.DoNfETGKzA"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3571005.DoNfETGKzA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Montag, 26. November 2018, 10:13:23 CET schrieb Rolf Eike Beer:
> Am Samstag, 24. November 2018, 06:53:39 CET schrieb Sasha Levin:
> > Hi,
> >=20
> > [This is an automated email]
> >=20
> > This commit has been processed because it contains a -stable tag.
> > The stable tag indicates that it's relevant for the following trees: all
> >=20
> > The bot has tested the following trees: v4.19.3, v4.14.82, v4.9.138,
> > v4.4.164, v3.18.126.
> >=20
> > v4.19.3: Build failed! Errors:
> >     collect2: error: ld returned 1 exit status
>=20
> This sounds like it could actually be a problem, can you point me to the
> full log, please?
>=20
> > v4.14.82: Failed to apply! Possible dependencies:
> >     Unable to calculate
>=20
> This would either need 8377bd2b9ee1be35b39b5523f640a2b75ddd7c4e as well, =
or
> a modified patch. Manually fixing this up should be trivial. Just tell me
> which way you prefer.

Ping?
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart3571005.DoNfETGKzA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXBOdWAAKCRCr5FH7Xu2t
/LErBACUnOOLVkL23/QHuS+yA5Bgy7Yi6IrIxdne8krSW58vAFQkF0jHLpge62MT
dNhUVejxRl7VZsjszTAA0PqTMrGZQiv9EnDj8YLvbVXkkJpq97vleL7SydKB1Iz1
NJl39f5KabKc3fIRxdjZxDLhbJY7L7xJGwJN1WRDzHcVw3ZH+w==
=36HA
-----END PGP SIGNATURE-----

--nextPart3571005.DoNfETGKzA--



