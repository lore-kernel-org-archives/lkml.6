Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6173EECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5E321523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5E321523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbeITPU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:20:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44290 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbeITPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:20:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 05995263B3F
Received: by earth.universe (Postfix, from userid 1000)
        id 1D59C3C0A85; Thu, 20 Sep 2018 11:38:18 +0200 (CEST)
Date:   Thu, 20 Sep 2018 11:38:18 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Liu Xiang <liu.xiang6@zte.com.cn>, pali.rohar@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com
Subject: Re: [PATCH] power: supply: bq27xxx: Add support for BQ27411
Message-ID: <20180920093818.y366exb5vxdkz22y@earth.universe>
References: <1532266436-20182-1-git-send-email-liu.xiang6@zte.com.cn>
 <20180916113523.fq4n7nsasigy3wyg@earth.universe>
 <3da8eff1-3d4a-4515-c855-34aececc4d71@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zoueqmltw5wajpxe"
Content-Disposition: inline
In-Reply-To: <3da8eff1-3d4a-4515-c855-34aececc4d71@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zoueqmltw5wajpxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 17, 2018 at 03:37:18PM -0500, Andrew F. Davis wrote:
> On 09/16/2018 06:35 AM, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Sun, Jul 22, 2018 at 09:33:56PM +0800, Liu Xiang wrote:
> >> According to the datasheet, bq27411 is similar to bq27421.
> >>
> >> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> >> ---
> >=20
> > Looks good to me. Do you plan to test/review this Andrew, or
> > should I proceed with merging this patch?
> >=20
>=20
>=20
> I do not have this particular hardware for testing, but the patch does
> look correct,
>=20
> Reviewed-by: Andrew F. Davis <afd@ti.com>

Thanks, queued.

-- Sebastian

--zoueqmltw5wajpxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlujaoYACgkQ2O7X88g7
+pqa/w/+JnUDYDp0GGxwPC/roCyfLHtK7pZH2EQEvoUOc4Nn2MZ7hpGyIORlMW3h
Q3HF67rxvClJaAC3mbMy1YrFfwmn3gj6AVLq5g/RGXD2sbwW8gMgjnBXybeIqnMn
XTsi8mKYO0Zx/BREMnzsESrXL0zvWSJwSr04777dNO+jLN5NNUVih61EtrfgGK+/
64iHp3EfkqfDEdI2qpPWTD70fejDO3Y2RTaENiZLBLdyt0jJV4zQYCikOu2Iobyj
/2nTkRN+zgP9u5Y4vGNu0G5M7DmKlydBqwLduQ+u2TeIQPPTsiPTXiFvVpijCviE
tYgQM3lWCBP1VchAbcd8G1CY+TVV3N+xXs4nW3qO+HBrRhi34APGkaJtJDAACcme
6g6mXSZROQuud5EAqeaQIivBv9Sb8fUOAp7VcQc9oKRirbPkAHvFuHh3a7R9JGMp
D4z/hqwCOEfipHRp5/3yTCj5T1tdy5WObCy6Dgx7qUspBdlkP3feddqir1dKqM1w
HnoTuEUpJUKbcqhfrf2qBILT+oYgKO0GYn0d8e0jjVXxU5F3xucOOT+oZCuKY4Bq
KXgHdkr6R9fAYT+9OALuwSrjosOWJIR2HKnfNQ7P+941yPGpAzjWZntgHN9C+n9/
5kAW+tlU8jp/PVNQuy2kOigzteOQNd86BnVzh0/hVKcMsN+O+vA=
=ieU6
-----END PGP SIGNATURE-----

--zoueqmltw5wajpxe--
