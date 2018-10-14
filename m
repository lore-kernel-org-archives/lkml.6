Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061A7C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60F220835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60F220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeJOGQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 02:16:01 -0400
Received: from sauhun.de ([88.99.104.3]:38464 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbeJOGQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 02:16:01 -0400
Received: from localhost (p54B33E30.dip0.t-ipconnect.de [84.179.62.48])
        by pokefinder.org (Postfix) with ESMTPSA id 4653B2C786F;
        Mon, 15 Oct 2018 00:33:30 +0200 (CEST)
Date:   Mon, 15 Oct 2018 00:33:29 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc: uniphier-sd: fix DMA disabling
Message-ID: <20181014223329.GF3260@kunai>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
 <1539356258-12374-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Content-Disposition: inline
In-Reply-To: <1539356258-12374-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 11:57:37PM +0900, Masahiro Yamada wrote:
> Once DMA is enabled, it is not possible to disable it because
> uniphier_sd_dma_endisable() always sets the DMA_ENABLE_DMASDRW bit
> regardless of the argument 'enable'. It should disable DMA when
> 'enable' is false.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvDxDkACgkQFA3kzBSg
KbbF8Q//egWXiLpPEMi7CydMxGxXSSOv4kYYnHrWPe+FW2b1LG4nTU36VQibTrub
Hk+U7gng3Xu2+MBTpvu6I1WrJ/thmdazuqa8RAqxfpHA318suhBibpR8EUfdEea9
M8Z+l1povsbHqVAkXsTlshySgxzlfjbih/NCTmBzq5/ZbIDC24buacZIsl3YQMDW
c05MLNRXJbHbKKJ1mOYJQfWV7aQCXwIlX2NQBN76w8xD1Y4MsMH64UD+asQNKC1h
G0KdvMIDh0DZ7kDB90ZJgrukVZ1cfH5NaYkQABbWhUop9QAb2Ua5sxYaqZhOT3QT
6HbBidN1n+CvxGlKJIFRmwE5z7bLJnL+ZpIRGhjMDUoiAO+5zNRGV26j6tshsz9C
KQ5r8i8fQYDPdpWZW2QBK6G3r3CnQLyF+Qid6I0RlvVHUdrQqZpRrfzFE9PP+9Jc
PTOo/0N3e+F2nk5qinW5tSTV6UIcoXqZGfFAcHtGuInDTevKk1aAIJZcrsYJfTuG
GOHNshlRNyRr0KlkPEfa68PcVdmehPzj0M3nkPaJm+Qw9NTIeuv4DyTtrV7IBL3R
Kbon9m2PPm+xYCM3ALaNYePbCRRsP40xnnSTUxXYSbTAvgVe/uQN2oIYl4eWa1Ep
gA/wqJq88mZPU+hZAy0XtRG66LYWPSLULzRyau++7LfofWmiAQQ=
=zpu+
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
