Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C35DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E3F20883
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391241AbfAOWtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:49:03 -0500
Received: from sauhun.de ([88.99.104.3]:54150 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387714AbfAOWtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:49:02 -0500
Received: from localhost (p54B332B9.dip0.t-ipconnect.de [84.179.50.185])
        by pokefinder.org (Postfix) with ESMTPSA id 2CAE72CA8AB;
        Tue, 15 Jan 2019 23:49:01 +0100 (CET)
Date:   Tue, 15 Jan 2019 23:49:00 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/5] i2c:ocores: improvements
Message-ID: <20190115224900.xwggdpx5heaamoe5@ninjato>
References: <20181029145051.31984-1-federico.vaga@cern.ch>
 <20181127113821.GB1107@kunai>
 <14601911.GrvbWtgO0l@pcbe13614>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gsv2citdpoizx5tt"
Content-Disposition: inline
In-Reply-To: <14601911.GrvbWtgO0l@pcbe13614>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gsv2citdpoizx5tt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 05:37:07PM +0100, Federico Vaga wrote:
> Hi there,
>=20
> I just want to ask if there has been any update about this patchset that =
I'm=20
> not aware off. Thanks

I don't think so. Peter, what is the status of this series?


--gsv2citdpoizx5tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+Y1wACgkQFA3kzBSg
KbY+Tg/6AiZbK9k0e5433bsCuTdcA4BkMwiSxDEbX5qkeDpaWlI9iPqAXrZ2NB0u
EoXVntsbDor6SQfeqEgKpbYmB0xGQpvDdgnqOau+NbkpskB0MoEOl5jm1u0vCv6h
8DH1ol3nntRWt9HhsA1jhfqgO9vtYS8xly8pyb3wJrDQ5/THW0XjuuG0b4w4pbPS
rOzO5ADiXotJb8ZqmjTL8ua0bNxD4+uJsOJ72jMO0/+w+hYcreZAF2fAnIQq7D8d
1wPy9RjRJeKxx9UXtrrc+xQF92ZGZHSgV2jtHDxO3C6XPwRA1HAq7T/AvvK6jTSS
muEJif8jDdXGqqzs8T/SD1Ha/6ibWCq1zLMsssN9h9rAieQEX+2veCmUOd9rAGqG
ry/K+/AEF+vTP7eym3tRnvzM3LvgJZtqPIiSwfICt3hOjJKRQWE31yJarvLg/WtD
O6uTqkmctyg459O88W27516pn5ywty9RBUknWs2rcEKAPnt5rOubxYFmLUh0kPln
KT1scQzB/EUrD5ujTLLwfU8W6XsnKF9q7Q3+DLlq/ZYec7rBmOGSWHNDRBW7hlht
sFEQorGA9X91hG/B3KVESA+/C2C4OcGPrPFwUmqBZOfxrY4hmpyBlPL7sQ2tFPzS
1F0vGzwlEIalQhcbRIp47z9D0Nw6QgakyHoBboxmeVXiY48JyJc=
=wyYU
-----END PGP SIGNATURE-----

--gsv2citdpoizx5tt--
