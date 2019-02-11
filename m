Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EE3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A259A20818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfBKNGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:06:44 -0500
Received: from sauhun.de ([88.99.104.3]:54430 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfBKNGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:06:44 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id 67C072E3542;
        Mon, 11 Feb 2019 14:06:42 +0100 (CET)
Date:   Mon, 11 Feb 2019 14:06:42 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        peda@axentia.se, digetx@gmail.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V18 1/6] i2c: tegra: sort all the include headers
 alphabetically
Message-ID: <20190211130641.7yauphtuzqxmlaxr@ninjato>
References: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6qbno4q5ad255egt"
Content-Disposition: inline
In-Reply-To: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6qbno4q5ad255egt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sowjanya,

first of all, thank you for keeping at this series. Also, for Dmitry and
Thierry for their reviews. Hard work everyone, much appreciated.

I just posted a few comments I had. No real show-stopper in there but
maybe one or two discussion points.

Thanks and happy hacking,

   Wolfram


--6qbno4q5ad255egt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhc2EACgkQFA3kzBSg
KbbBAg/9Har/3buO+R9QOl7o4k6OoECw4sTxRIbTAVF0kIHg0D71EAdRImNhUdkp
jNSaDld5yHUhvgC0FYFQ9z4dHpY2idnUe4LPY/Hp3bpvvNcgw+acQG5kROz1swox
A0uGB00QuWOO6igo2bWQnvys8U62CvHCv3rYctv7E+5Qz2vm4KEU5zvlKQdIHF1b
+LcEuP4+PPNvRVp23wPzdIkQUcPVAwFvKSlLMA3F8NQHZvQbIPOcqucWIKgCkRtc
gy9fLHXEIyz7VFn8Ox0wePfWAwg65pT9YdptEY5vrG5T5cOXJaT14f/i1abvdZx7
Vq26cceoHSmTivjk7F/BhzdpMcSTgk6JzwF/7EjPTxdk5RITluSFlxIfuEstzZSN
BnhtoW35XoK6pmVkBuTqmMIb6f959hidxb/JTAAYUhu1+AuHGv2ClC+X51H5IwyD
k6srY3aDSXfAhSTE9AZsUl2MJnI+JygKF565MKfafq2oThzsUxVcUXvhCHiEhzgZ
YYlz25CPLaDIou3n6OXQZTlP1BDYkf6yh8qhmTFISWoOFUnZp0twDHgXJ1PDddlO
Kq75ggstrbVzqiLzMrHOGKh419LXBM/s+x6flVF+AEV11J/Vw3M9gKmZDEFpB/2u
hzRsu0yyJ7tBcv5u85OmHQbtHi/49wB/SLPYP9NBNh7uV3Sd0eI=
=+Xbu
-----END PGP SIGNATURE-----

--6qbno4q5ad255egt--
