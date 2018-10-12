Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A47C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B52D214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B52D214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJMDHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:07:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58214 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbeJMDHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:07:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 405B7208B5; Fri, 12 Oct 2018 21:33:30 +0200 (CEST)
Received: from qschulz (LFbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id 852BD20DD8;
        Fri, 12 Oct 2018 21:33:17 +0200 (CEST)
Date:   Fri, 12 Oct 2018 21:33:16 +0200
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
Subject: Re: [PATCH v3 3/7] arm64: dts: allwinner: axp803: add AC and battery
 power supplies
Message-ID: <20181012193316.p7ph7qfl6x5mao4o@qschulz>
References: <20181008181908.9456-1-oskari@lemmela.net>
 <20181008181908.9456-4-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cdsluzrm7zn63g3d"
Content-Disposition: inline
In-Reply-To: <20181008181908.9456-4-oskari@lemmela.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cdsluzrm7zn63g3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Mon, Oct 08, 2018 at 09:19:04PM +0300, Oskari Lemmela wrote:
> AXP803 is compatible with AXP813. Add DT nodes ADC, GPIO,
> AC and battery power supplies.
>=20

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks,
Quentin

--cdsluzrm7zn63g3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlvA9vwACgkQhLiadT7g
8aMqkhAAiV37F/mli5ezA/lOLoko71ieVcEru4rwWBc3baCz6zf/cPMVZa0ur6Qn
Fasv1PQk/KdofCo5bxqSP7mdMbX5E2uA64cj59GpZ614hqQA3RrYl57LMsV0ErN4
jIyK7sitkOnA/LWSGFloCiggqTwxndxmIi2HTGSgVML+2OVUjzXuQ5hizlK4PAyt
giFk35pvpS/08CYfXU7uRQUMexIDw39zLMZ6zCV84D0qp8VVvIKxQ8CQ8USNCeHb
EsdiAv9jB4B6yylaL/uVC7CC8oCgnju4KKhOycFstt3Ga+fa/2vzxdeQCCQCXKst
BfC5dSVi83Q+Pg7A4utyor1vhG+sGbDdRQUJX2FJzfELYRpgGuO3R8+py3TZ6icc
JjOWntOBsxgmE8wNq1LFvVXAtnRBOXhCiDAS28elnZYIaseJK9F3Kqzw6Guyrta4
UQDEE0RnUV59B1BP2HpBI+ZVWFXLDeTtG4T+i4PBvX2X+V+RiYPnd4ry7qxxb823
idsROFEkRrQtkAjHPQACxSJ9BkXeWMf37cIJmNcgQ89TaZE0ZCZblyRaah6xzJL9
GEEVM1sOabfq/ZfeHqioRuLfsc1WVSfl6k6Bmtv3pQXw1tGC/eyCt4hzCLsqZvC4
gQcT9rFyEigyxX2Gibjud7TWukWZ8nwOYylYvmRHqkTsZf5xdD4=
=7cwX
-----END PGP SIGNATURE-----

--cdsluzrm7zn63g3d--
