Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440DFC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06605204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06605204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeJMDKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:10:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58428 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbeJMDKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:10:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2EB8020DCD; Fri, 12 Oct 2018 21:36:00 +0200 (CEST)
Received: from qschulz (LFbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id D8BB52072C;
        Fri, 12 Oct 2018 21:35:49 +0200 (CEST)
Date:   Fri, 12 Oct 2018 21:35:49 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/7] mfd: axp20x: Add AC power supply cell for AXP813
Message-ID: <20181012193549.kfebhxf3j2cq35uj@qschulz>
References: <20181008181908.9456-1-oskari@lemmela.net>
 <20181008181908.9456-7-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wg3yyrjf764d2ysf"
Content-Disposition: inline
In-Reply-To: <20181008181908.9456-7-oskari@lemmela.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wg3yyrjf764d2ysf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Mon, Oct 08, 2018 at 09:19:07PM +0300, Oskari Lemmela wrote:
> As axp20x-ac-power-supply now supports AXP813, add a cell for it.
>=20

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks,
Quentin

--wg3yyrjf764d2ysf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlvA95QACgkQhLiadT7g
8aPibw//Sj4mE8rYAqniJP81JTWlY8h3pGHp+rSxrsTCsPevzNiZFoxCIBYuw2aN
y9nvvy/6G2cxAs345ci/K6dFpjfYdbWGlgdktcYyZIwmVhagscL9Oeo+l7b1RBbs
D34DL49Qkd2VqiJWj0W5Icd3Kl0I1svd1sxpBCNLNJ4uMoNnvBG6f3DrM/hsxZKb
84ZWsreuTxDJWh/zGrUgZSH9SPuA1s7H5SEIwbpeeyuR1eUVABzSxLmnvx4orJC0
xwHCgmC/eUyyQyDCjFBnZxn4jbhrUn9T7kxtyoG77R/dQdDqjuQVQeA+gbiI0lET
0TMPP7ZKGP8//YnwnMA3HuF6NvOIOutnbFwVxcnc8kdp1Dt8j1BK0QNJLELS7I6c
nv4M/r7CMUNXhH5QY17B7r0mVDomZsq7B5VuiBdQHnqcKvr1g7/ZpIJs8mmljK/G
q6CmdcKchX/1VkZfc4eh08yAQ2+NFYofsiJIbISGLtNgxRcPRfaqTu0J6Zvz0jFv
3yQOUPzuqHRNJnoU0O/y9DZVoEk+2j054wQH+N98d/shlOv6pPBih5Y3vrAA6GM6
+UpJvFKo6nl8cNgBpUZe2vSghdDTzcxOrLt8+ytZsHt/2XUGfVWGAz+DLzVzWDcH
VNMubmROhI1aTvx/bsjwesInuA6dZn/FI8DtKV/dI2uRoczxsRU=
=1kQd
-----END PGP SIGNATURE-----

--wg3yyrjf764d2ysf--
