Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82125C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1E720851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1E720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeKUAYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:24:37 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56890 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKUAYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:24:37 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EE28920D31; Tue, 20 Nov 2018 14:55:19 +0100 (CET)
Received: from qschulz (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id A7D0220745;
        Tue, 20 Nov 2018 14:55:09 +0100 (CET)
Date:   Tue, 20 Nov 2018 14:55:08 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] net: phy: mscc: fix locking in vsc85xx_default_config
Message-ID: <20181120135508.paxzs63cqy2llc7d@qschulz>
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
 <20181008100728.24959-2-quentin.schulz@bootlin.com>
 <mvm8t1pazea.fsf@suse.de>
 <mvma7m3n9l6.fsf_-_@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ntnyqwowhkgpjtiz"
Content-Disposition: inline
In-Reply-To: <mvma7m3n9l6.fsf_-_@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ntnyqwowhkgpjtiz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Tue, Nov 20, 2018 at 02:48:37PM +0100, Andreas Schwab wrote:
> Don't use locking phy_read/phy_write functions while inside
> phy_select_patch/phy_restore_page region.
>=20
> Fixes: 6a0bfbbe20 ("net: phy: mscc: migrate to phy_select/restore_page fu=
nctions")
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Have you tested this patch? Does it solve your issue?

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
anyway since it's to be done.

You need to send your patch as a mail separate to this patch series.
You also need to prefix your patch with [PATCH net-next] instead of only
[PATCH]. This is specific to the net subsystem.

Use scripts/get_maintainer.pl on your patch to get the people to put in
Cc and in To.

Thanks,
Quentin

--ntnyqwowhkgpjtiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlv0EjwACgkQhLiadT7g
8aMwkBAAlxyAg33/B6pRIqeuRGnreLcxBPkH2jhQsxDU/vaKz8rt51V2AVQI6DfA
A2cLtqV8S0yec8Z3ZoD4bQGCqTwRm2pm/28jILlfZIHrX6hkDdi1Iqtb1cDh2oc1
7DLnPtg+t9XHQYeYbouDw1bsNmDToN/ZQHU11r8NPUdKFhgs2On0rQxygOqKX6DE
ZJhfdnFuKGeqKnrbUZYy4CU8o7n3cCu0DoMQP48Etn/K+mlHnvSyj4r/RFDw21pD
INhNvFCjcfsKRbHNx5i48KX23wb74tec11J7Y95MLxoRRxU5F3hWUhGrrV1br7M4
JCz76BsLnIr+wmZsoEEfri6yWbeoZIq+WJPW0S1N8BQhez+DWZCLyLjpWawxuWFQ
ohveKoEuR4NXjhuqLEPvKHTISAG4tHkUiLV9M8I7zgLUOvdd17E5vA/G6SAbuTc7
12IWm37LdUp+9e8Y9rTWdubBg51bfIUb43KriB9hWek3XVswi7QkVKEuFzLxz6Ws
KWXKOP0IaxbtS/i6Rdn1SIJ8GTfoikAzDEMFgNths7R8Fx1fvONMEKTeYb7JF5AF
FWad5HJm3Br6fZyUqbvpFFJ+poebiqavH1LNE8HjTxbfnuetu/RPZaFQ+JO98MBN
ewcszCCIwphpF0i8juSBwr9nRRBZhNZFgpEvKDbzl88VfyU37yc=
=FCjc
-----END PGP SIGNATURE-----

--ntnyqwowhkgpjtiz--
