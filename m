Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 97A6BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECA42087E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECA42087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755213AbeFNN26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:28:58 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41079 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755010AbeFNN25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:28:57 -0400
X-Originating-IP: 208.88.110.46
Received: from localhost (mtl.savoirfairelinux.net [208.88.110.46])
        (Authenticated sender: hle@owl.eu.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C0B19FF802;
        Thu, 14 Jun 2018 13:28:56 +0000 (UTC)
Date:   Thu, 14 Jun 2018 09:28:49 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH v3] staging: pi433: fix race condition in pi433_ioctl
Message-ID: <20180614132849.GA3737@hle-laptop.local>
References: <20180614005414.GA1974@hle-laptop.local>
 <201806140913.Gd9lGmBy%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <201806140913.Gd9lGmBy%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on staging/staging-testing]
> [also build test ERROR on v4.17 next-20180613]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]

Already fixed in v4. Sorry for the noise.

--=20
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlsibYkACgkQLVy48vb3
khmbBgf+IwjRlBpW38bnQaiHjhYjNXva1FPaTNiXrxHeOKJh6sV0GTz1NRDEsPmf
DiAK+u5aU8gSrLF00PrTunEo1kwMSNRhi2zXi29VXMhZ+wy9LZixnDprv7YuQg9X
bkJVIdo7yh/V4R2NkAzu9XQyXjxqS2XATq7Z/rgny8HN/J503vI++B6dqTRtKAue
Z7uO2dHPo19NkiGbAyzH2Ir4ncXN0DVK4wLq2VoLl3mYhPdfhUzjuCpGNXk4O809
BY9sB9R514vckm8pAZdY0CzFNixV3s929CSpHgLn0n+A8FTdxjNNRG74zuW+3LUA
5xq+eY7pdkmnXAc2t+4lbjh8S35CRQ==
=RQ9U
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
