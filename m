Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E922AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B995221A49
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfBKMp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:45:28 -0500
Received: from sauhun.de ([88.99.104.3]:54108 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfBKMp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:45:28 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id 474532E3542;
        Mon, 11 Feb 2019 13:45:26 +0100 (CET)
Date:   Mon, 11 Feb 2019 13:45:25 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        peda@axentia.se, digetx@gmail.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V18 1/6] i2c: tegra: sort all the include headers
 alphabetically
Message-ID: <20190211124525.dzzh7tngmffkk6af@ninjato>
References: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d352keorujvabowe"
Content-Disposition: inline
In-Reply-To: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d352keorujvabowe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 10:59:37AM -0800, Sowjanya Komatineni wrote:
> This patch sorts all the include headers alphabetically for the
> I2C Tegra driver.
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V9/V10/V11/V12/V13/V14/V15/V16/V17/V18] : Rebased to 5.0-rc4
>  [V3/V4/V5/V7/V8] : Removed unsued headers in tegra I2C

^ Header removal should be mentioned in the commit message, I think.


--d352keorujvabowe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhbmUACgkQFA3kzBSg
KbYSxQ//e/gxU8fLaob1TH+ps1GGb1ZDlRPA3oj26n3B6m0eoAZeRFHk5sYRJMKn
yVlMoCiwMVh+TiSgdGXHs3AulDkMIGBfh3XhGGM3RpzxJt3S0HDctJye2927DJAJ
kZU0Yq7g+MONt9sOwE2vGi79HvTPmwupFW//ZE7wuB2WYiJtx5w9LU9FVwlxdxnb
9EaVfI6EfD0rTSZVtBqaxEjuUwE5dbQVSAZEDApRNdw/64HThtPl1y8p8IXx+rKF
Glm5l3kSbn9+6KsoOKxSwlHMUmCw4QUpfKZopLuSKILWrmMNJ+zJFS65trFYj3MP
vdeF91Fw9OYeNajkxCZ0QgU7V9+3jYT7rh0vRXXBTpVXkuEqt57Xno7C+uJg/7ox
UjMwfzzW+1ouC3YWp3XwnpR1OhhqAwoDKfnlqOGMa+fbzH3QC97zzkvnO2PeGPtD
N17PO3ntxst6p2JbnX4pdXN4RgyW8f1yD5Gm7gHnfJlQWJgcQQCsf6je1k07Pk+Y
efjY6GyI644Gyqc+4ndb0MgG8J4Rd6oA+/gSPJFqwSCMlfjlsvga5WnEVVZqAAB3
wBxOvnVMEuPJW3dAXMKDRytj/46vQS/bwpMEwZqCubvswjT9HJJk1WQwgF6CVsJ2
2EUK7/vHADJAHIgs3iPgfPp+W19DofvB8Eo/QzQzeLn55eorc58=
=OfbP
-----END PGP SIGNATURE-----

--d352keorujvabowe--
