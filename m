Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D23BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BD020811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbeLTSjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:39:10 -0500
Received: from anholt.net ([50.246.234.109]:49752 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731945AbeLTSjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:39:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 675A910A225E;
        Thu, 20 Dec 2018 10:39:09 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id DYxrUe_X1-RJ; Thu, 20 Dec 2018 10:39:08 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 4FC4510A08D6;
        Thu, 20 Dec 2018 10:39:08 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id DA0EE2FE36F2; Thu, 20 Dec 2018 10:39:07 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        agraf@suse.de, afaerber@suse.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
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
Subject: Re: [PATCH v2 2/2] input: add official Raspberry Pi's touchscreen driver
In-Reply-To: <20181211112408.9524-3-nsaenzjulienne@suse.de>
References: <20181211112408.9524-1-nsaenzjulienne@suse.de> <20181211112408.9524-3-nsaenzjulienne@suse.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 20 Dec 2018 10:39:07 -0800
Message-ID: <87r2ecdovo.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:

> Add's support to Raspberry Pi's 7" Touch device. Instead of using a
> conventional bus all information is copied into a memory mapped area by
> RPi's firmware.
>
> Based on the driver found in RPi's kernel repository.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

While I wish we could just have a native driver instead, it does make
sense to have this driver upstream given the constraints.

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwb4csACgkQtdYpNtH8
nugdkQ/+LY9jN6gEKsBN58yufoqoWA2ZTKuYIcPGi94pLuVG/WJ+JHu/FRnHCFln
+I+BrPqPXPFndixY6UStBgj+xDPqUXbwbrXO+C4uc//0cdROP5zi4NLN3Pu+6agX
VgwbpP4SUHhMVlq8MS0zywRtkyYF2Zp8rFho9QI/+E1/4ITOto+Goj5WESCXIGNg
IpO7/yY0g+yAZca2UtK2OUDZyWRFmUBymXqCQhJ6lyH9AhwNxbOBxfNZWzvZBXpr
kZhWtCVys9IDGCfzMLfz/IKwYwZF2kNtxVm3unIQbFN4REf1RnQj8VD5X5sVHJ2B
Ju5ZpksCTevQfHy4JL/sxvAaNJ8BXJ84eIuvHzXVqFCO0lqClRrnr77G3qZdsUC0
vo3v8IlEhb6QtLVQ7SgkG4CuN4lIk2eI9Y8Adpia5iR8CZW1JnZDHwWn/ccgduoJ
PwQpDJJeAothSpa7NFbmkdMEa1qEP/AZ5ZchsPiRTocLKS3f/dWJ8JbGJ/tc70WZ
VumGiaPsR1dGCjEabyKSAKQklLcJb3J2uIDfhhPAybEhnS2xajRnyRCtAw/aR1Gg
JoVn8JwuUDiAnw2zLbljouX1VqTXdNNNPOZZAVeOTGOcVShWT14gtekWXwh6noJO
kzdyZTrj+9lkJTHMv6/5tRUoKMBqem/dCjUGwwJNqxHcUMHNgPI=
=cJa8
-----END PGP SIGNATURE-----
--=-=-=--
