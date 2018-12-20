Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137A1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31D1218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389149AbeLTTMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:12:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:33006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730859AbeLTTM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:12:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68393B0D6;
        Thu, 20 Dec 2018 19:12:27 +0000 (UTC)
Message-ID: <2c433e120c2cf375b7d431f79ce6bfbace803c7e.camel@suse.de>
Subject: Re: [PATCH v2 2/2] input: add official Raspberry Pi's touchscreen
 driver
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Eric Anholt <eric@anholt.net>, Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        agraf@suse.de, afaerber@suse.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Mark Jonas <mark.jonas@de.bosch.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Heiko Schocher <hs@denx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Zhu Yi <yi.zhu5@cn.bosch.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Date:   Thu, 20 Dec 2018 20:12:23 +0100
In-Reply-To: <87r2ecdovo.fsf@anholt.net>
References: <20181211112408.9524-1-nsaenzjulienne@suse.de>
         <20181211112408.9524-3-nsaenzjulienne@suse.de> <87r2ecdovo.fsf@anholt.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-VNpI8kJnLV6TKHOFqu+A"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VNpI8kJnLV6TKHOFqu+A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-12-20 at 10:39 -0800, Eric Anholt wrote:
> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:
>=20
> > Add's support to Raspberry Pi's 7" Touch device. Instead of using a
> > conventional bus all information is copied into a memory mapped
> > area by
> > RPi's firmware.
> >=20
> > Based on the driver found in RPi's kernel repository.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> While I wish we could just have a native driver instead, it does make
> sense to have this driver upstream given the constraints.
>=20
> Acked-by: Eric Anholt <eric@anholt.net>

Thanks Eric.

FYI I did manage to access the touchscreen after altering the native
driver (edt-ft5x06). That said, as commented in the cover letter, it's
not good enough as it breaks the camera. I plan on posting the patch
and an overlay. I'm just waiting to see how these first patches are
received.

--=-VNpI8kJnLV6TKHOFqu+A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlwb6ZcACgkQlfZmHno8
x/6Y8ggAi7oMS/uM+2GYb+jaxFtxar1otppH5rs755UJAiVYcVw66W8wfOz5hKKt
1V92UBBGnfrvGlZB0vZsDyef+C6MFuBWNwUdiXatgWO+keAVKAg+EqiI7jH84GRj
H3TD3urFXUGGsknN5ZSZA9OpFFDtWguW+hn5vDfSmK4SuxJV6/wa9DWgKuk+y+H+
Uc6CNc0wlNXnTFHns9mi8moujpph5BEDdUAm/6EXtw/uxNP01LhdARBc0sCGrRL5
LlOMTZOggkd2IxCVbB2xtK2HKEIrVmDvqOfgZKjbYo6a2RI4g/F6vjxxBxUG0Tpr
31bZdKMfgVlNnGJilD5XxXE9pEzEAA==
=uELI
-----END PGP SIGNATURE-----

--=-VNpI8kJnLV6TKHOFqu+A--

