Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6364320883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6364320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeGLHmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:42:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51588 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbeGLHmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:42:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B8EA4207E8; Thu, 12 Jul 2018 09:34:19 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 89D4D20741;
        Thu, 12 Jul 2018 09:34:09 +0200 (CEST)
Date:   Thu, 12 Jul 2018 09:34:09 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/sun4i: DW HDMI: Make symbol
 sun8i_dw_hdmi_pltfm_driver static
Message-ID: <20180712073409.onkrxth7niearorq@flea>
References: <1531315367-190647-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r3ewoxaupisvl7zi"
Content-Disposition: inline
In-Reply-To: <1531315367-190647-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r3ewoxaupisvl7zi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 01:22:47PM +0000, Wei Yongjun wrote:
> Fixes the following sparse warning:
>=20
> drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c:228:24: warning:
>  symbol 'sun8i_dw_hdmi_pltfm_driver' was not declared. Should it be stati=
c?
>=20
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--r3ewoxaupisvl7zi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltHBHAACgkQ0rTAlCFN
r3RDQw//Y0F5/lq5ItRtavzvpMSsv8DMmtympz/s16gF7jRSeztMom2KhqRdKYDY
h90zUIlXHYuuED0n/O7bWK7hRFlx6MxROxI/CqFaEIqj4zaAHO85u2ZnsgAK6jO5
KPb+wlC75Dm01rwnsdcVoiPru2Qtzc6QtcW3TsRlbhc6FpUFcdd035ztntmS2496
UHAkKZViXu5A8y1U47E0ptTZfZUZRi7dSWbqbLfTTLV27IqLWrZ8HfQPZ5SBPkij
LQCR1lFr/ji+He4aDO4MWtH9g7j9vTjQTAbWEzoqxIr5YlU5uTv3HrqibBvghWtu
61OZSRXG9KkNYNeUx6uzJReqpSnqKVF4Jjn4TikI1eFyESDBD5p/uiRTncIEEFxA
9yYxvO+6b8q7t6JbaISBXcY9KVQwQj6cmSTOoXqLIDHE7p7SLNAJIeXgLCnxvWYz
hijo0fWm7onbc8QqqqsBTZG3FAYltTVMOQ/8xO5jauRG2MqAWC7vkOdJt0HRI0ju
YNZW9Odc/xf1X8GIkQkBmFnAH5GFavv2qvxUfi/UaX3B3RmdtH546dgAiYOfCUpT
obLkPdzcUZ63IB0+7UeCk2gJtCNTDoDzQQmiaAVNXbUp/IeVpZWK5Kp9hsdGpFs5
9yCS91R9Hq2b3bXbk+rWyGZOHmRBSDuYgy5dPYNR0lmQnJ+082Q=
=19B8
-----END PGP SIGNATURE-----

--r3ewoxaupisvl7zi--
