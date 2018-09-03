Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92316C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3A820779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Fpw7ZEjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3A820779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeICVDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:03:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41728 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeICVDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vKVF9CMS2CpPe0YRD5VzVs7G2FYnz7ogRhmLO1NqdB4=; b=Fpw7ZEjWgHab99SMksryYxilf
        FL2FkYCpe0+a/uPjqtW4MsbOjRA9qRDdyVB781KHHZ3O7aRJZvHltwxTKUiMoUi5qGLoGP0MM0jWG
        EIfX9Y8hXPzBzaHea4Qpkr2vY8HHq+j4sVIlZT5GdU56qOmzfW5xHZZGWEqIbAnIaEmTk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwrw5-0000TX-2T; Mon, 03 Sep 2018 16:42:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id ADCB411227AE; Mon,  3 Sep 2018 17:42:44 +0100 (BST)
Date:   Mon, 3 Sep 2018 17:42:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2] regulator: fix kernel-doc function parameter and
 warning
Message-ID: <20180903164244.GT10302@sirena.org.uk>
References: <c71b22a5-fd31-0b19-4b0b-244f01b11afa@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/FJxnyttrH06HRq2"
Content-Disposition: inline
In-Reply-To: <c71b22a5-fd31-0b19-4b0b-244f01b11afa@infradead.org>
X-Cookie: Inside, I'm already SOBBING!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/FJxnyttrH06HRq2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 09:05:20AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> Fix kernel-doc warning by using correct parameter description:

This doesn't apply against current code, please check and resend.

--/FJxnyttrH06HRq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNZIMACgkQJNaLcl1U
h9Ae4Af/SlJOyRB09h+f0AmgBYsl5SdIUI6SDoO0vTD2VXE/Y5RQibLGZwv+2nAE
QFpWvkwkGW0aSJuz5Ac9UwnLiEIXCQizr7/N+vobBTTvaxWSv6/DZUed8Yl/oEGn
+kIphZGZU50euklVRpAVy9p1AK0S5yj/SmdUVCpHCm/+3KCwMQi++GYoAhf58bXy
97t6ITJdcWaCO3wr6C87vjVXExyjoFqZo0ubA8m5iePhMA3gUDKgEcZut+VrgJeC
Ui4RILero+Co+ct9MLG8Y4yAiIDTNXLX2EFJeakMl+gMm3aU+hupkPFFADJAZHGN
NC5pu9XPcCF3dbfKIJMr4YVYCMtLdA==
=WLl0
-----END PGP SIGNATURE-----

--/FJxnyttrH06HRq2--
