Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDD8C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094D62084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e68tyaUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094D62084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbeJ2S3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:29:37 -0400
Received: from ozlabs.org ([203.11.71.1]:43243 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeJ2S3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:29:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42k8kZ5YPnz9s89;
        Mon, 29 Oct 2018 20:41:42 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540806102;
        bh=X2sjNFYVllI9+HyQm6KX7WlRkKlMpyVZ0tTH/0cjHlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e68tyaUdcCJZvzldMbPI8rjnAuWCfIOxbDuhW5j0mEh9/D7DCGT+XqBQTIcIQHKpd
         hyuC93bkwBW0Sv2IiTFYjRukKMOqANziTgtOwtWQGjtX/fREr6IT/M3sQs81YiNmw5
         ysdLi6D+/Ds50Ys/2HeYwmIJ1ToHTSntX1ibMpnbSXSFrExqN3j8YnEip5ZtCDzfhd
         Ov1QS8DlOhV12GB3LeBC7Ec5om+LPDXvaHTxGvWF/fjB4Bpk6sn57VTptYG1l1Fet/
         Q72TfjkzufzqC9IogMOk8LpCoJQ5wGyS0u46DtybTIYL9cEpGKtNRFOzqW2lvpRyql
         999rs0HnBO2WQ==
Date:   Mon, 29 Oct 2018 20:41:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Damian Tometzki <linux_dti@icloud.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: linux-next: Tree for Oct 29
Message-ID: <20181029204142.7dbce8d8@canb.auug.org.au>
In-Reply-To: <20181029063319.GC8104@Ubuntu-DTI>
References: <20181029170212.4a34959f@canb.auug.org.au>
        <20181029063319.GC8104@Ubuntu-DTI>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kMAZnIBV+rv7r=E2MmPFb7x"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kMAZnIBV+rv7r=E2MmPFb7x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Damian,

On Mon, 29 Oct 2018 07:33:19 +0100 Damian Tometzki <linux_dti@icloud.com> w=
rote:
>
> on the site isnt available the new linux-next ?
> Only the old one.=20
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

It seems to be there now (at least for me).  Maybe just mirroring delays?

--=20
Cheers,
Stephen Rothwell

--Sig_/kMAZnIBV+rv7r=E2MmPFb7x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvW1dYACgkQAVBC80lX
0Gy52gf+Lr4Pl8+2o6VV+fjg5pZ6FeMAcTZ9qDmZT6lo3y481f/lPtkk/XFYLmUF
woBW3HKMQ051XsAjbyTTA/fCy0z0bVqH3c0kkDnt1ZGebCf4w5NbNFU6tp84Yxli
LFfbO/NWTwR54ArtwvlPIpm6PpwDPWp9HNcSdJBAO/9w8YAzXy4uJdrlth/3wdoH
eZHHOFhAfsxA5fFRApy/WqpHRFaJlxfcCf41k9Rb2D5LxbfWbxa507S1ZPIbZC+d
GB58AVEDABdBvZOAza/P3BDmFaFyC3TeQX6zm25pWHxiOgHOQ+JMgthMUCHsf5Do
xw51KJzFNi+6IOxEiiV6jQ4mc7fm4w==
=ZXK5
-----END PGP SIGNATURE-----

--Sig_/kMAZnIBV+rv7r=E2MmPFb7x--
