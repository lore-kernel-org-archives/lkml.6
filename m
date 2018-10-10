Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B68C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D0F21479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D0F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJJOEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:04:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41763 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbeJJOEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:04:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1B7DE20787; Wed, 10 Oct 2018 08:44:02 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id D1C7120726;
        Wed, 10 Oct 2018 08:43:51 +0200 (CEST)
Date:   Wed, 10 Oct 2018 08:43:51 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH -next] phy: phy-ocelot-serdes: fix return value check in
 serdes_probe()
Message-ID: <20181010064351.lsntlt45ujhms7ge@qschulz>
References: <1539136824-44940-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uqmvk2lc7u5vyulk"
Content-Disposition: inline
In-Reply-To: <1539136824-44940-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uqmvk2lc7u5vyulk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wei Yongjun,

On Wed, Oct 10, 2018 at 02:00:24AM +0000, Wei Yongjun wrote:
> In case of error, the function syscon_node_to_regmap() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
>=20
> Fixes: 51f6b410fc22 ("phy: add driver for Microsemi Ocelot SerDes muxing")

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks!
Quentin

--uqmvk2lc7u5vyulk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu9n6YACgkQhLiadT7g
8aPOwBAAlgPT4wvAX8gVnmzktWqa4tX9gQY8wpFIbMhzgOxdcMSX/DUtMJcv66zN
oLGUzEqy8WZpkh/tkKCsa/h64ZUZE1LLBcHkh7YDu8hRZmvv/tJKdLBOnYaMO0yG
e4guaI0r6jlbZGMZgRCgyvLDNhfUjIii6zewHJngt8WE1z/l38N1tmo/XwDwBcIK
EmPsZIVF4WoPdoKi6WJOuxeTWNPbi59NITUxRsb+127g71iw1B5FzLG1rCRGTNkF
EKuU6fta6+QQovLWo2CK3tuL8h2mhrwRtFYGvWCCtCr/hlMC3TuiM+qHPFYC/GQY
H5LAGIp6sNJ1wssFCxVU78O1YEG0ZYwGjUgSZq5nQgr2JUwT2RkRkrBmFndHMWKN
6rOFweOegQr4LO3TsCfwu/7wDxnbUa6gt0c1bqmHI60jWMulfFysgtJho5zpp35K
DufpZuKRhQ+54D2Zb5J9RfGxsp+gB29possbcG90AgEqAogetd99QE0hu5xO5QwV
GLOiFQPywki6cJSiYPDxSHlzYAJNGdwuOgvB8hfcDK5yNNtBz3zva95MiEGEU1Br
N0nQrLNArbCPrnUaWUQdhPllRwCN1WkO0if0iIAFFuELENZ4CobtywYKWJpt/Ofv
5Fo0eAz5EtMaRm2X9EvvBuEpQzbvtwjKcStqmvT5OzDIKEyFsbg=
=tRhA
-----END PGP SIGNATURE-----

--uqmvk2lc7u5vyulk--
