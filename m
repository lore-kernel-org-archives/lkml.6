Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC63C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B387220855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QnAVNjzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfBTAVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:21:45 -0500
Received: from ozlabs.org ([203.11.71.1]:40111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbfBTAVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:21:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443yvp6vf5z9s1l;
        Wed, 20 Feb 2019 11:21:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550622103;
        bh=E55cyGzZiZAzDzjZXH30KD1LtPcdBnJRmmmpAxmoTFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QnAVNjzIYkNFS+RiS/OQL3+pKDn8mUEoaeP0DAvvrPZxd3p+P7I2nLPRw7V3ZNSgQ
         9QLwhjhPar6ifPq5sQ+FrQ7hAnKBA2P5KI0rCwlzHoCWqdiMUQoxAd1cZTg246SGHX
         PHZESg/ZoGQSr9HNT9FKdFsW/M5lG0G3KIf3bPV6u0k8wf39q1sphvf/WhzQm4Ixq5
         MN/AAkSfGD1xrk93c2cW9PBRDMBS924fkxPj/axH1Ql/Ej8cAbI+ZyCAU1g05aW8tn
         hjTYL7I801Kj+gt9mN7n2pnPFKeTenPQOePuwVmZP8OXodQiHs4PoaMV/pGHoEPFEm
         GvyYVTZbRtjLg==
Date:   Wed, 20 Feb 2019 11:21:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: please clean up the v4l-dvb-next tree
Message-ID: <20190220112142.4a58bb6b@canb.auug.org.au>
In-Reply-To: <20190219211007.4a916a62@coco.lan>
References: <20190220105703.69c9b582@canb.auug.org.au>
        <20190219211007.4a916a62@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P4qXaA_cA_bBnDlHQ4OI2UH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P4qXaA_cA_bBnDlHQ4OI2UH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

On Tue, 19 Feb 2019 21:10:33 -0300 Mauro Carvalho Chehab <mchehab@kernel.or=
g> wrote:
>
> Yeah, it had some branches that got already merged.
>=20
> Just updated it to be in sync with v4l-dvb tree.
>=20
> Sorry for the mess.

No worries and thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/P4qXaA_cA_bBnDlHQ4OI2UH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxsnZYACgkQAVBC80lX
0Gxdfwf/WveTLJFp7akTrDvdO1tqCdHf3+81ptcJm3IQ93yrzBlcMJIl/RD6QMSn
Ig3AwLVxXTxGeTxAMjOAERNn/V2jlxNmV+tL0eaOst0fK+QayeH+VzDDRn+VaOid
wtLVG4ktbasMFTDJQ2wVrjHont6wB08165qJ3vUXnjPi8uDGMlFaeXUYAdmNu0pM
IrqAaWamuQ6RuqR/M6zkVaFyDqojx6PwGznzEJC/NoE7E43OnfU6GTsQ0HfzeRr3
qtAv+bucSY8bFn4vY8xklfWID2cwHKPm7jxK2xgmGisoIUEeWX9tc8p/hECk76RH
3hmWhk3OMYSVWuUBWs/pZgcrCezpxA==
=DaZN
-----END PGP SIGNATURE-----

--Sig_/P4qXaA_cA_bBnDlHQ4OI2UH--
