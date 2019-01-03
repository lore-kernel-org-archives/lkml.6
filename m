Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D837C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFE320815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfACTNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:13:53 -0500
Received: from sauhun.de ([88.99.104.3]:55186 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfACTNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:13:52 -0500
Received: from localhost (p54B3379A.dip0.t-ipconnect.de [84.179.55.154])
        by pokefinder.org (Postfix) with ESMTPSA id E98202E3614;
        Thu,  3 Jan 2019 20:13:50 +0100 (CET)
Date:   Thu, 3 Jan 2019 20:13:50 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     manivannan.sadhasivam@linaro.org, afaerber@suse.de,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@cubietech.com, thomas.liau@actions-semi.com,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: i2c: Add S700 support for Actions
 Semi Soc's
Message-ID: <20190103191350.ud4fbl5wx3hazs4m@ninjato>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pxiyn77e74u5fpf6"
Content-Disposition: inline
In-Reply-To: <20181211080448.24007-2-pn@denx.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pxiyn77e74u5fpf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 09:04:45AM +0100, Parthiban Nallathambi wrote:
> Add s700 compatible string to Actions Semi SoC dt-bindings.
>=20
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>

Applied to for-next, thanks!


--pxiyn77e74u5fpf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwuXu4ACgkQFA3kzBSg
KbbVsw/+IgVQLFBXRkETFjun9/mUOF1Li/1IfKeT418b5XHu9xk924nJeaPQNoAl
TWiJhDhcoD7nx/2nE6h87lnBgYdmrfukgukqGszt2iuXRE6ObKGVY8g4TeCWkJPS
+KoifU5j4oah97ZStucLlHJrBM1y1YrBBIjHC21ntpKiOyYcPjHry7uTCkrQOXOd
VsGHsGQmSE1CCcNlRfX9Rzhr8z9zzpnTg5AOHZCE2SEw2tM543cTFgJ3GTHrjeEr
qqxU/CQ3f/ALcimX6YSBmejqXpTBS2pJG1R0bLQKj50aCNnaq/fNpwVBNvR4+497
CLNlgPWWscFtMXbNT1Nz+sKzNGEZDViPmGH/zupL6hPgYrAUtfZGnZcugeVpEZOY
9zq6Tte9Ekg2iBLP+PTTiNjRq/h0LA+l3HWiSwwstMiDkGC23D67zTVZRN/6Salo
ewQADA9X67j3FkFKUOEvqEZ6rO8//SyG0I3eF/MOkHrtb5lEJE/7HKd9B4KqIT7w
4+iouUUoY8Wscao0miYCDNwFmRQmpeGC0K8mVFJnYvsxkIN0kXU6oNx/VJWxaWEW
MVGlJLg20VfMNFs0KkdBZrT6Wiei1iB/qwRZKamVEQeJ9biePNyy8C1KBfN3BPyx
8oegVkJ383+d5ot/Z6mdPtY15rvG5XWXpou5o7NIFVdBHe5FSE0=
=KmY6
-----END PGP SIGNATURE-----

--pxiyn77e74u5fpf6--
