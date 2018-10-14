Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0E0C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79D9204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79D9204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeJOGSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 02:18:06 -0400
Received: from sauhun.de ([88.99.104.3]:38498 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbeJOGSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 02:18:06 -0400
Received: from localhost (p54B33E30.dip0.t-ipconnect.de [84.179.62.48])
        by pokefinder.org (Postfix) with ESMTPSA id 4B04C2C786F;
        Mon, 15 Oct 2018 00:35:35 +0200 (CEST)
Date:   Mon, 15 Oct 2018 00:35:34 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: uniphier-sd: avoid using broken DMA RX channel
Message-ID: <20181014223534.GG3260@kunai>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
 <1539356258-12374-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OFj+1YLvsEfSXdCH"
Content-Disposition: inline
In-Reply-To: <1539356258-12374-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 11:57:38PM +0900, Masahiro Yamada wrote:
> host->chan_rx is NULL when UNIPHIER_SD_CAP_BROKEN_DMA_RX quirk flag
> is set. In this case, it should not set up DMA.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvDxLYACgkQFA3kzBSg
KbY9khAAoHCwQFucHtw3l83bHMbMnG/2J0ScVnEdsY2d3izomHfJZNCSa9Ser/gp
2IPqGrfhGSmO8ISz7yHeHpR7rM96N6KhnCQsAd/lvzPhlzcWfhlYtLrZls7lpJIj
/sTWD7kj4h0NvVkI1RgUu4AGchchBaX6CD2FbON6T0ktS4Omti8yjwf9mLKm0r9D
39R5vcmPqHEGBqGAWfpKSRRxzge5Q5tHVv1nb64xTAR5V6sIlBoRDwvfuuG/NyVk
+QCx/g7UbXobx5oS8O5fta6FMAFFRvF9NiT6rEWBOUM1Z7MiP2yfAspLZIxVt7fy
1SJAavmrDC9huuL3dsl6KKWlc7JH/BNKar2gq17/XpDlBVSejWppIQo37Tqnou8C
YoNPjtHFtk81kQ/Tb/6w0b9SLlZ51+PTSvYCxMMxEzrsJu69jNUKLkhjJ75cgIUj
kOUSa3E98yPTOo1ZLBVBllKa4sEcbQdEU5xrzMpQTutx2JXfMVKeX3w+CsLnH7E+
fX8EAUjaRu3vbhnd/3lD05Xwk49QEIY6y7f8yEuH8/uNGKuoa0tZNz5b+oQXLd7d
tV7dpfCVRib7ZUGOobZizVHrMwR5n+zOHSAVmdn6E0nAJj1cKM6sKN8tEaH3fx0O
myIXWHecDp8nc8hKLycZ6WmqDCh6ULdrE0Vp024+6wRJmth927Y=
=pBgP
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--
