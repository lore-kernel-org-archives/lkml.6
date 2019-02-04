Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17782C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C3720815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549308254;
	bh=NS+y2tCqdaKuu1ZayjYqnOpKphAW1D7NuEqCXds8Nnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dDytt6iTcyFeqNOSkDSG92t1cwfhPZbs2iDv5uHKJU9A0QENRDE2f78svip48NQqx
	 c7ag5MvGWDPSYBo6vcc7DV7JFlefByVFa5W55JvzTUSVYJMiIyX9onZGK0O4rwIOHd
	 APGAC6ZXwwRXEFLYuvxHpPktzakCMwACEIcZd1yI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfBDTYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:24:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58510 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfBDTYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l8HbsCj3aAZbUpyTvTxWERjGloL8ifcRWY6O1dxoB5E=; b=g4oH8m/AkRdbt1YlBXgZRsily
        9Li2NVnHy/E3kfizaDEAziW7cIrwSI9fexpnBqsDVAwOlBjAZFOFa2lEJ0UjVxP3+Mvz/Liw7+7Ju
        ON5PCh+yRdOFlTgZziG5BEmmgtI3vsabySdnwUlUAhQ+fusSZpB7EsmlzCtMWNF8vR3qE=;
Received: from [109.236.136.146] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gqjqd-0005qB-NX; Mon, 04 Feb 2019 19:24:03 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 073C0440082; Mon,  4 Feb 2019 19:24:03 +0000 (GMT)
Date:   Mon, 4 Feb 2019 20:24:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2][next] regulator: axp20x: check rdev is null before
 dereferencing it
Message-ID: <20190204192402.GJ23441@sirena.org.uk>
References: <20181222113159.31029-1-colin.king@canonical.com>
 <66f320fe-7df1-2715-ec55-ef7dc3493aa0@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Content-Disposition: inline
In-Reply-To: <66f320fe-7df1-2715-ec55-ef7dc3493aa0@canonical.com>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 07:13:30PM +0000, Colin Ian King wrote:
> ping?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxYkU8ACgkQJNaLcl1U
h9AkAgf8DRY/M2KADI04y+c/5wdEOwRNDEtB1H4XoXx4KvqiCvLI5yVO5fCb3EKU
K7CKHWAKLLpbR5EWt2gTo9vEPD7Yae8dYgVkDwaQvD9v7ou6gdeiTZ9TIo38W8Jm
DeidhT6XOog2YeRaTg3DZBg34sxpN70U66t4hqShg2hdXGXSCkBFPjIwE1GS3I0V
RXVW7fR2xj0tg0qnqH4PKchuxMYFGSdOfDHHwa2lyGMlzKZIyisymHSUSh1vyzcf
E6CIuJH4q30yXLgoqfVOCJzHKT79AEm5F+J6DSfZb9Dx72qP5+hs4PdsYn2qd9ti
5zN/CJy+wqmIQFLJkOMHJWHh7Bj45A==
=3DON
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
