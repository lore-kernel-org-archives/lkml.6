Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A352C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD15A21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD15A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeJIOnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:43:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42160 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeJIOnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:43:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 04B8220717; Tue,  9 Oct 2018 09:27:34 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id BB378206FF;
        Tue,  9 Oct 2018 09:27:23 +0200 (CEST)
Date:   Tue, 9 Oct 2018 09:27:23 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Update SERDES_MAX to be SERDES_MAX
 + 1
Message-ID: <20181009072723.mshyvplpo2xmkyfl@qschulz>
References: <cover.1539036280.git.gustavo@embeddedor.com>
 <3a1a95a4832af33dcd1842b0298d257bbcf1f5ab.1539036280.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="62cxvakkd2ytn7p2"
Content-Disposition: inline
In-Reply-To: <3a1a95a4832af33dcd1842b0298d257bbcf1f5ab.1539036280.git.gustavo@embeddedor.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--62cxvakkd2ytn7p2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, Oct 09, 2018 at 12:21:36AM +0200, Gustavo A. R. Silva wrote:
> SERDES_MAX is a valid value to index ctrl->phys in
> drivers/phy/mscc/phy-ocelot-serdes.c. But, currently,
> there is an out-of-bounds bug in the mentioned driver
> when reading from ctrl->phys, because the size of
> array ctrl->phys is SERDES_MAX.
>=20
> Partially fix this by updating SERDES_MAX to be SERDES6G_MAX + 1.
>=20
> Notice that this is the first part of the solution to
> the out-of-bounds bug mentioned above. Although this
> change is not dependent on any other one.
>=20

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks,
Quentin

--62cxvakkd2ytn7p2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu8WFsACgkQhLiadT7g
8aMl8BAAqrbt9R184yxGBaEGyA21uKcsKGZI3fq+kcmvkH229Y6dKUWuqK7xNo++
qRAN//jr9Vl5mcwXKPeeN9DhheaIX+O+mAHSVZG+E7xx/gA6uxhTxV552l0sSC8Y
D+7XRT0kvv3YXXoJj3lf6PewOKrW8PUOzQNprGbKAaDUZSfLglb6haC3/IwcNpUc
H2mju5ElUrzhfggDufAQd1TS7uTyoX0J5hkvC9pc1NIxcz+v7XZWBzZ6fUJPQV09
ASa5omZgaAPq2MV4/WTGKG6D2EO8Xa4FlWgsZ86PA1FOgwa0jpN+XIfkcarSF4ha
eNBKrV352Ib3MO7aRBy9wzu8iDFI5Tzu25CyTOPlac3xd1+3P/2VI26z033Rr1K5
s0fHT+R9ifRjh0MZ6Tx3tn2QY6gxEnA0AJaMiT+c1JJc0jQBwBvlCsloSUz1wVS5
5MO8lmmeEi1EljmnHTK5FY0Kr8kka180F1LEDMJAFfi4IBZhDAci9jtb/fNbQpJj
5WdYMKsx13LFGkRVNfkjg7V5n/s/fG0M7UAk05WW/0LT7lQWhNyCBYRkt48a1q04
zANiha7l8g/VALC/ueRBsCf1BpVR/cb0JD3F74avClwKrZm5zyvEYaqmqNpFS/K8
QOHCccKaTM1CiJbXtpTlB5T2464ooXKr3qEKIlnU8qlurcQNkMA=
=JOiR
-----END PGP SIGNATURE-----

--62cxvakkd2ytn7p2--
