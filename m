Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEEAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7175F208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7175F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeGaIWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:22:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53963 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbeGaIWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:22:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6606F207A8; Tue, 31 Jul 2018 08:43:33 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2902C2074F;
        Tue, 31 Jul 2018 08:43:33 +0200 (CEST)
Date:   Tue, 31 Jul 2018 08:43:33 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     andrew@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next] net: phy: mscc: the extended page access
 register is 16 bits
Message-ID: <20180731064333.fkkbgnat3gdn3fhs@qschulz>
References: <20180730125313.3405-1-quentin.schulz@bootlin.com>
 <4dd7d451-a1e3-cab8-dc5a-6666c5d29089@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="64r6gjhm5kjlvbil"
Content-Disposition: inline
In-Reply-To: <4dd7d451-a1e3-cab8-dc5a-6666c5d29089@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--64r6gjhm5kjlvbil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Mon, Jul 30, 2018 at 09:53:31AM -0700, Florian Fainelli wrote:
> On 07/30/2018 05:53 AM, Quentin Schulz wrote:
> > The Extended Page Access is a 16-bit register, so change the page
> > parameter of vsc85xx_phy_page_set to a u16.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
>=20
> Since you targeted net-next for this patch, I am assuming this is not
> yet a problem, but would soon be one with the changes you plan on
> introducing?
>=20

Yes indeed. When I get the quad-port PHY things to go as planned, then
I'll need sometimes to change to a page that is above the size of a u16.
For now, all the pages are accessed with a number that is lower than the
size of a u16, so it isn't a problem.

Quentin

--64r6gjhm5kjlvbil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAltgBRQACgkQhLiadT7g
8aNk4A//djVm3SUcdyWMY22zTkiGXBdNVzbvE464sZFNEXISb/NpTQzxoujYX7FR
F0pXrmBmm8mZaNLZBYijnl/Vk8PnwGjadE2YnL3b04WFFCa/4jrmHE6eaznrk1qo
yGKcM5tvGH9ldOMnp/lcAP6U8iYUZXDaILFjCfdHuNyNWWr9fErMqoK+bBHS3/Yd
k1AB0/Z3Xu29xL4/FDvFQEHq0JtfmQdsniIcTj4aNDelMfO2CL7spMWndlNlyZxg
iplPzxo8rDHaeEznm7EBDqizIJ0YlDWRdAye4QGylHh23TW9IOV05apaGiUXZUZm
u8I5AJVi3Qw4mUnUMcABq3oeZktM8vcFLT87YiCvkzQSp/H0LsHQCHxcfaKzI6Go
7SKe1Cs8QqsirXiYEJdA6Pm7Kg7Y3YMzGRgqRZpqLYYPw5HlBODh5m8Pleoeb8Ls
Mx8DFb7F/KuRj84iUw4hfyJn9FUMzq/p8yv9BX7yqXMG7iDqMU1AhZgpqsxn9q2t
rYuSkztsxavhWraPQL67sfqA/CJ/QpQZyuH6WHzsPx+MwmiFqzLuUgSghC1rGVxC
PICe7d8QenN7QDgBTmWG+ydKx0HNOoSCCT3MfZIHbpah55d+CJ1N3q9ibionbUAk
7ooV3gqQsjYbFk6kUGOqSEuP5RL2Le1AMWdWt3zYRfFNi/cQjuI=
=HUlx
-----END PGP SIGNATURE-----

--64r6gjhm5kjlvbil--
