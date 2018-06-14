Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B04F9C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7152F208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7152F208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeFNH0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:26:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41258 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752781AbeFNH0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:26:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7BB9620719; Thu, 14 Jun 2018 09:26:34 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3063B203B0;
        Thu, 14 Jun 2018 09:26:24 +0200 (CEST)
Message-ID: <99b2583187fe9925251029e876b061aac9172597.camel@bootlin.com>
Subject: Re: [PATCH] Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com, stable@vger.kernel.org
Date:   Thu, 14 Jun 2018 09:26:24 +0200
In-Reply-To: <d5357ae3-9dc1-b0ac-47bf-8742d55c4f3b@micronovasrl.com>
References: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
         <d5357ae3-9dc1-b0ac-47bf-8742d55c4f3b@micronovasrl.com>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fAJmF27SYGowJCOLH8Cy"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fAJmF27SYGowJCOLH8Cy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2018-06-13 at 23:52 +0200, Giulio Benetti wrote:
> Hello,
>=20
> sorry for my ignorance.
> I don't know the right patch workflow in the case of "revert commit".
> When I fix this bug, should I have to re-submit the previous patch=20
> entire plus bug-fix?
>
> Or do I have to submit patch with bug-fix only?

Yes, that is usually how it works! The revert patch will be picked up by
the maintainer (Maxime), integrated in his tree and eventually merged
into Linus' tree (along with stable trees).

Fixup patches for this will need to take into account the revert patch,
so it becomes equivalent to submitting the same patch with that issue
resolved.

> Thanks in advance to everybody

Cheers !

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-fAJmF27SYGowJCOLH8Cy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlsiGKAACgkQ3cLmz3+f
v9G0mQf/ULb339blSIkYnLow0k88c8mID4981TPKLS5xBO76sff54JRC8LS2akuh
+e1WQcwb9BI0N3quUuUyyMwrlyH1aNzQOdo0VkGo5XdotNR62ZZBR3X6W2OTdeTs
DipI6jB0rtAq4EbL6ZE0BnbZVZl58Hf+0OtmiAF4RsXqDHrgkEQ688Ixcn219dn5
738fJdggyTxO2SdXisQOELnKDEZ7zRvVEpzxUDEryW4IisfGszt8VlPMxgfAy5l5
5AI5jAS/BFFccDGlUfk18KsqXvfS3k4mZeV/+2PB7Lhv2jA7CdxzhsOo0dybgoRj
29DHuPCcECI+XrcVEbxk10ROcUx7aQ==
=Vo1P
-----END PGP SIGNATURE-----

--=-fAJmF27SYGowJCOLH8Cy--

