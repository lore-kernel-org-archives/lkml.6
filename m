Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B4CC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2141420849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2141420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLKUQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:16:49 -0500
Received: from sauhun.de ([88.99.104.3]:45450 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLKUQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:16:49 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id A00D64C0E8F;
        Tue, 11 Dec 2018 21:16:47 +0100 (CET)
Date:   Tue, 11 Dec 2018 21:16:47 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] i2c: powermac: Use of_node_name_eq for node name
 comparisons
Message-ID: <20181211201646.2mdjgpp4ilwzwvja@ninjato>
References: <20181205195050.4759-8-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="km33xnxufwac6hzc"
Content-Disposition: inline
In-Reply-To: <20181205195050.4759-8-robh@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--km33xnxufwac6hzc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 01:50:24PM -0600, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>=20
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-i2c@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-next, thanks!


--km33xnxufwac6hzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQGyoACgkQFA3kzBSg
KbbPEw/+L0vejcqiYVgjvQOhSRuegssHy7hONbA6r+I/ys7bfqO5LSl4oWZJQ32U
vQ0ugyxLVAdghU1RgWu0G8I4iazxA0kdn+dYJYd02tQsCyNNrvJN68Xp8rvSIOCf
H2eAN38HDfIIJxVBcxg6v+roiN0QBL3G+2HO1UdkAgni2rEOPDH2G62G0XKxVUiq
LOCz0kEqz2gZ0WlZyjV3+J1iP7HIyW6dqtiOuEkwO43UvOqKkYyccr+n18gSS57e
IEVK1JSfpf8ULyEl9gw01KTjPNzL2ZTIVLO3rLKRc4zMEQsSw7grbJHls3or7wk3
LKHvEMwDd8Ba2e0ukKZZkap1Vpz6wL8+Yj8aDZy9dZIzDZUIzaVHB18VyKd4p5Wa
hzXGTqg5WzZzoBp88wS3mQPKSwHpkm8ab69CBFSXOgduEo330oy4I8cOyPn+e3g5
Ub6bMH+fx/JhEv585+Bm1j5AN9hYU6KvBwxdTk7pDkb9e3d+ftqpPLAddJ6Od3P1
DvgU3QCf6pQoiwLO4pQ6kJUZACemldzo6Ycqvs+d3DqnkyVN7s0zpm5CSI26ycRM
oYGJQ8SLF5WORxOqN6j4qFJsFnvNKNIjxUT1NYD6rxFQH9JQ5A9tSTw1xFNGxcLP
7VrqEdm+5axqylDRa4+QqyNW7M4qMVqebS0/eGFeXcgpNzMvFb8=
=psiU
-----END PGP SIGNATURE-----

--km33xnxufwac6hzc--
