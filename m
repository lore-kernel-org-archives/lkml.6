Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5F9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B892214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B892214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeJJPzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:55:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45050 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbeJJPzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:55:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 57DCF20898; Wed, 10 Oct 2018 10:34:32 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2488F207C3;
        Wed, 10 Oct 2018 10:34:22 +0200 (CEST)
Date:   Wed, 10 Oct 2018 10:34:22 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 2/2] net: phy: mscc: fix memory leak in
 vsc8574_config_pre_init
Message-ID: <20181010083422.phokcciqdkzm6u7w@qschulz>
References: <cover.1539159556.git.gustavo@embeddedor.com>
 <6161326e265a99f8ec8e0f7028790a0131c5404e.1539159556.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k52oevuihyj2ev4i"
Content-Disposition: inline
In-Reply-To: <6161326e265a99f8ec8e0f7028790a0131c5404e.1539159556.git.gustavo@embeddedor.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k52oevuihyj2ev4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Wed, Oct 10, 2018 at 10:31:39AM +0200, Gustavo A. R. Silva wrote:
> In case memory resources for *fw* were successfully allocated,
> release them before return.
>=20
> Addresses-Coverity-ID: 1473968 ("Resource leak")
> Fixes: 00d70d8e0e78 ("net: phy: mscc: add support for VSC8574 PHY")

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks!
Quentin

--k52oevuihyj2ev4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu9uY0ACgkQhLiadT7g
8aMohBAAlQkYmbTdzStBkzHF5bBU4ItEg/jl0yjL/1tHSy2l4R/tJTGpatX6h61/
bwzx/+M/MLxpbcNSPIgUoONRWELGqM8oCSSYYO7sXxNLnB9x7HsNUziPg2X4zDY2
Ie7Ot/vm+gwdNd+Hs9KzCng98bUC8gR1CQqrd4o0fSQg3sz2GpW2ExC4xGa9s0PZ
crd88sSjCy9BRou/QKXqQyF2p8mqPGPA36hMnnHEooWkzYJskJkuuwtQOIrvBAZ+
e459/3bqV5qFeXiT+rxVx7MKZ+Ede7v7v3Ahm9Zjee2yE+us3RDydZXg+TMqtUvu
UY74G0pJDP6gt6blbN9YhLNqG5q3HBUTPsooYLJOhUCSg+GQ2exQUAaeaAeTf/B6
6lOuN+vCYotXHVCy5h+TZUeVDbAT748NCM/49NxPzWASAGqtp06OLV4GhCwrwbIf
CJJWB1+QgnYDoQisTcQ4/AaTOGfTKDCJRU9KSs6ghIDQraQRP6VkUOt4WvZbQ18m
4h2gDFIfn3jMktifUK6c/EmIde2ILBlQTBYq6SvrHISXDdBaDMvdjn05J260YZZS
DNwsnFpz56DmByVYDKEpb1lu1MwHpf95fHMgq+kIuevo69PcrB/TGADEeukRUKCu
cCDEbPPFV7qHFof35GJ31VIRKkfAru9uW2acCmaNwNVnTSj0UkU=
=Llml
-----END PGP SIGNATURE-----

--k52oevuihyj2ev4i--
