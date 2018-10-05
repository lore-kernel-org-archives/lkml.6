Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BEAC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4437F2148C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4437F2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbeJEXHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:07:41 -0400
Received: from sauhun.de ([88.99.104.3]:40330 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEXHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:07:41 -0400
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
        by pokefinder.org (Postfix) with ESMTPSA id B3C994A1D32;
        Fri,  5 Oct 2018 18:08:18 +0200 (CEST)
Date:   Fri, 5 Oct 2018 18:08:18 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] i2c: tegra: use core to detect 'no zero length'
 quirk
Message-ID: <20181005160818.ta2ngy4av7mwpakv@ninjato>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-9-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j75xnhkbcuolmljp"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-9-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j75xnhkbcuolmljp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:12PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--j75xnhkbcuolmljp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3jHIACgkQFA3kzBSg
KbZCShAAnKs4K41P5qCG0kGY1iFAOtC3xA1ZPUDjfkva0GCFDLdc96AxOo0oRiLQ
wUsBnK+uQ5kzbfXyY+htm3/jlEU0rj+eRGJBuvdSVaEgKHDFoef4yjK0VYnv3BMP
qAEN8UqKIV8tTKEN0EIPqpSw5TX/n2TVkLORsNVkGg7PaWJtANYTLQWFx6IySZsW
KAMq868YBtjXn9ZayCKwrT0YFrVmG4L2TpgGtyYyyEjOT2MxVL57MXKtzh24ZQ0B
rwVKCOgUXEAww87fvaXc9H9ex9fvtxRNwAzpxWPnoZbxoqZhuCccrvxvuOGEWAFW
MekUtwytiSkvxNLyc09o5RtKzZmFxTKOzpa1Tmg9zgSMWEWmiZHUBkP8h2uQsi7V
XANzc4hrBu5Qp/qdZJCaUlP/O1HVR8pWwL7R6YYoWrn2fOZIbAEq3qtJB+/iBigS
5n4naNC2Op5KT6/1v7N7CwkRJHmn1i64ZVEAp6MrBNS39dDTEVmyq4pyiRlbR7/v
yBlU2gFg1ZHvclBn5xgP1vWU+UDmgvyQbUwMF3vBmKuRCeYxbqIo6V698SGFsnTN
2B8dU30RfHdMLp2x/HoMRJipZxeubAHpz+RpLAB7akzbhSpso8yiQulYroQzacG5
UDf1nxO1CjuX57BBv3ujUsCWkOZoZCrLzPuFgaekZciPfhfmr0g=
=mJp1
-----END PGP SIGNATURE-----

--j75xnhkbcuolmljp--
