Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD98EC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E492087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E492087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJMDGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:06:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58148 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeJMDGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:06:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BE634207B4; Fri, 12 Oct 2018 21:32:19 +0200 (CEST)
Received: from qschulz (LFbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id 73860206A2;
        Fri, 12 Oct 2018 21:32:09 +0200 (CEST)
Date:   Fri, 12 Oct 2018 21:32:08 +0200
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
Subject: Re: [PATCH v3 1/7] dt-bindings: power: supply: axp20x: add AXP813 AC
 power DT binding
Message-ID: <20181012193208.7rq4ukonobqkgrlk@qschulz>
References: <20181008181908.9456-1-oskari@lemmela.net>
 <20181008181908.9456-2-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rlkcrtl66eibmebk"
Content-Disposition: inline
In-Reply-To: <20181008181908.9456-2-oskari@lemmela.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rlkcrtl66eibmebk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Mon, Oct 08, 2018 at 09:19:02PM +0300, Oskari Lemmela wrote:
> The AXP803/AXP813 AC power supply can limit input current and voltage.
>=20

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks,
Quentin

--rlkcrtl66eibmebk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlvA9rgACgkQhLiadT7g
8aN3WRAAimDQafFjFU+84EnrqfVeTLrvSoS6mkpsGFJHwtpdgvALLHhfU2uTgVOs
/Mplrj6/CGEAszLLv3cioYkDiu9RX7JUwthEgFyUcl6wd8BzZk/AWRqYOQKjGlb4
RuEvHe5G98WO9wAE8TbqAWPnzTDYgg9eOA0ThYX0EbvGafXAArXxtHs/bWuIhkPv
lssEBG3t7D+ujXA4iQjU1GZtHJ/XRPIejhfL0QTIPjYI3A7wn72Z66vhVPt9OfLj
gULQGjbWknKMnhZ8nYxXu8OpzWQEWIoYwXHoSEX4tK52CT5Bc7yrOq0kjt/HrPMJ
AzqrR52/y5T/oS/AUHiAWJpUqLuTTNrHrnKPU7IvW6Vdawc8EGzUTlONIreIu91N
Nxk5RNKTgkg5kNoeSwLPmhzrt8PPyZ+SZrTi8UsAdabrR4PAnI7uZU9mUerr8vYO
qOC6svTgRNktoYQ7SEVLj80RysHLe2WQzD/p/tTFcFrvXyx7vyVjNGeUuXem8tam
fM8umpPwRIl45ECGKZG+HuRwb2rLlETwk37NxdzRh2NdeL2+AfmcLEUvCccEYP/3
+dpjkb2pSrwt02pN6HbL0B895A0NDDYd71SgxDKDQhBiIF3dWxkO5u4xjh8EFP4g
fSgL8SUiTa0FuMwZLjAfYmStFz7u8Vcl0Tzh0a1iqrJm/ZwEfDg=
=B93E
-----END PGP SIGNATURE-----

--rlkcrtl66eibmebk--
