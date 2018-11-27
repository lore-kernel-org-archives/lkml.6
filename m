Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32C7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24EA208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24EA208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeK0XHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:07:38 -0500
Received: from sauhun.de ([88.99.104.3]:58322 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbeK0XHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:07:37 -0500
Received: from localhost (p54B33299.dip0.t-ipconnect.de [84.179.50.153])
        by pokefinder.org (Postfix) with ESMTPSA id 41B212E354A;
        Tue, 27 Nov 2018 13:09:54 +0100 (CET)
Date:   Tue, 27 Nov 2018 13:09:53 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: i2c-stm32f7: SYSCFG Fast Mode Plus support
 for I2C STM32F7
Message-ID: <20181127120953.GJ1107@kunai>
References: <1542625412-4277-1-git-send-email-pierre-yves.mordret@st.com>
 <1542625412-4277-3-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xssso5lpTBgMxDfe"
Content-Disposition: inline
In-Reply-To: <1542625412-4277-3-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xssso5lpTBgMxDfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 12:03:32PM +0100, Pierre-Yves MORDRET wrote:
> Read SYSCFG bindings to set Fast Mode Plus bits if Fast Mode Plus
> speed is selected.
>=20
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Applied to for-next, thanks!


--Xssso5lpTBgMxDfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlv9NBEACgkQFA3kzBSg
KbZiOw/+Jee9JoP7bjjU4zVwuoVhGhxaFggTJpIU8FDFAcWBj5Ulbkp/5WyzTyHM
g45KbRjdB+/Swh0qqFCbzCWscjnbbCoYo039Tu+UlrihPlh7jlmFwkW8Vh1kqZfq
BSKTYtZxXckJI4/qMNu0kEeFpZ9fCaWOeoMraEXj3ZF7GDY927KE1nXh+V8sjye4
Exb/+ko+BkoyADqOF9d9Yoe5ye8uX911HLT5D0IED1kG0ubIp9s8wIg6/J7ZKesN
2VT80R6w8PzKzxKBjqGfsV96jis3jRGGvJCFqv5WT8kEMKy0mkROI0ztbBBNwpUs
gpng4WboKMKvrPNXTpj+6OyVYFu2GrAeMfX8JA9vhrvJiom/UK+6g5lB5GoVUWL5
v6J5rBVBrLboD4rOAR7h2YIXFWx2JIyZR42Csi6vOS8igGJiaiKbu9xndqudks+w
mcVG5d3QU4jWUxWH2WLSS2Q7Zf3mO8jZGTlS+hozdJnWeAun4Sa/T7T6Z6h5SFMt
zLGWBgz9DF4SousaVfg4jxefcg+o6wAocYw5NJEf9ltxmu+nOd2cfwi6GcbEp2JE
Ks7E01rFZ1fIHQFbjGtDDyLwO38XrYBt+PK9IE+4Qt70Oxn80CF/WJGztqjCeSlM
2XDvGYx9k1Gtz+Kcmltqk434KhcwZAVWyiWQMaAshTqQELyQVr8=
=e3Kh
-----END PGP SIGNATURE-----

--Xssso5lpTBgMxDfe--
