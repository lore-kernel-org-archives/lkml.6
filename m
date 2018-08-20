Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AEFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CED21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CED21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeHTOdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:33:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37237 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbeHTOdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:33:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0C09820DEC; Mon, 20 Aug 2018 13:17:55 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id D565420DB5;
        Mon, 20 Aug 2018 13:17:54 +0200 (CEST)
Date:   Mon, 20 Aug 2018 13:17:55 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
Message-ID: <20180820111755.rzg7l2lznmbpuf2e@flea>
References: <20180804070355.14857-1-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3wnikgdamrq32ce2"
Content-Disposition: inline
In-Reply-To: <20180804070355.14857-1-manu@freebsd.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3wnikgdamrq32ce2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> This patch adds documentation for Device-Tree bindings for the Allwinner
> Thermal Sensor Controller found on the H3, H5 and A64 SoCs
>=20
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

I'm not going to merge a binding for a device that doesn't have any
driver implemented at the moment in Linux.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3wnikgdamrq32ce2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt6o2IACgkQ0rTAlCFN
r3TBUQ//Zzcda8FBwMHlOeqZgRlXnJc1Q9VU/IeQIRCOXWDjIeJCiYUmuyuDV2Ry
aF7wBQjAIHld6t4IzFchoBJTyykEBJn+l6d//2ap8qoG0TrmVevVwXVkN2Gsu7yP
SiqPApfsq6OT7WuBGi43PyfgwNNgwBTICRcYMAszfXJv+c0WK4Doapwd24RTJ4pR
rRmfCtU6bZlKdQ6Sj+eIJgKcuCSpkfiHCcogZ8CwanKWr1I9pPSRejzVLjwhTOtB
Bg5YW5PTdqrJ+wNh7JotWDFQTk9zGNy1qBnw2yNReynCnQhmYL1j7MhEAGcL3kDd
iS7pKNSFx+OhyO/KsQRYeFzTm9iMY/wNm+3w5/HJgtvhPBfYrH8uZ9035qlBXZlI
SNrr5A2fxguV9+Wt14BMIn+bcFrDi+WMD8JoJuAAp5YfpWZI369DSm+laNgRuw23
5ZPPMsIzMWvvWwH2h8cyByOBMQYW5e16MtQbmyyJsrKanuH5gVk76M3H8sE1TTZC
GpkvqQc2SrKCiRLSXXBEDJvU0v4PMjVHaW8til03/WJobRwEwMsm71CwIrxe5rh7
6OS7HvDxncKsa+GQZ/SN85/4p5P3z9Q1ZcyrK8xHhf8wRhi0YzvWwUV6ZWO9AG7R
0NJRPoyP7X/qnKiEEmmHtXIEmSmKQhjYgR//9hCo1CDH7dxde/o=
=0Njf
-----END PGP SIGNATURE-----

--3wnikgdamrq32ce2--
