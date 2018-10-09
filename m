Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88083C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E8120835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E8120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJIRM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:12:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45797 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIRM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:12:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C759B207BF; Tue,  9 Oct 2018 11:56:49 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9367420712;
        Tue,  9 Oct 2018 11:56:39 +0200 (CEST)
Date:   Tue, 9 Oct 2018 11:56:40 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <arlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Maxime Ripard as drm-misc maintainer
Message-ID: <20181009095640.ye2kh5gciktq3kf6@flea>
References: <20181005160256.200162-1-sean@poorly.run>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="saf22wwguyfxbilc"
Content-Disposition: inline
In-Reply-To: <20181005160256.200162-1-sean@poorly.run>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--saf22wwguyfxbilc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2018 at 12:02:22PM -0400, Sean Paul wrote:
> Unfortunately Gustavo has decided to step down as drm-misc maintainer to
> focus on other projects. Thanks Gustavo for your dedication and hard work!
>=20
> Fortunately for us, we have a wealth of people qualified to assume a
> -misc maintainer role. Maxime has done an outstanding job with sun4i and
> in the community in general. I'm really excited that he agreed to take
> on this responsibility and I look forward to working with him!
>=20
> Cc: Dave Airlie <arlied@linux.ie>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard  <maxime.ripard@bootlin.com>
> Signed-off-by: Sean Paul <sean@poorly.run>

Obviously-Acked-by: Maxime Ripard <maxime.ripard@bootlin.com> :)

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--saf22wwguyfxbilc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu8e1cACgkQ0rTAlCFN
r3Tpqg/+Kqli7JMJQpMnNh5tOfuHvapyZaBxTNhbwLvtKex2ot0yhYjrJjKcNEi9
SDTRBB74QlBXofmHZOHbvcO1a8niVWWQMPrDAHvcYMsbax6VfVbFmpHFIDLPeV2O
0eMIYwoSO3EP1XlDsqY2TmoBPZmZnu9Xbjr+8TOqC5mPFGCmqzj0K212svMTnNSe
OvSatydW+Y6UYq6COoMjlhBFePn9jzwCayp5ENrZeMUGgKXxepS/Mjv/D9etHgou
BfrZheJj9NTZ4bb1z9iqrgsIGCBw7kC7xN9eTSjCYMPluc0Co1XjGGxKzlPMEZ/C
2MlWcAgU+NGZbUMhhsL40zs+Xrd+8QVB/u0IbNZNsvifo+XvsMxiCPcL3AtxfCGe
LsIDOwg4+943w+mTiO9YS0VCbTeyZklEMtvKLPAbKmBn2PW8sOoyuUTzg7pCOwDM
0vyTrbHVWX6m2ld9GRqJ6h/jrdao8xh3pPWOV6RP69lU4DwZH0b8TLkVOHh7+xG/
Pn1KcRIwIc/wBGVVoO44fiCQ4CHxYJdKpvjvHXyzM09UbhhqOr/gQvBrG55LdKl4
PboBOKZDVeQTELWa8j+kWTrTnA2wimGY/IrP/8bb/GhuPEBESA5pJzjaQKcXPwcy
pwzufTNO7AZlXDoldOvdhQ39m7T3v6MUZhFgK/Dw2HeIhboqEoA=
=+kEu
-----END PGP SIGNATURE-----

--saf22wwguyfxbilc--
