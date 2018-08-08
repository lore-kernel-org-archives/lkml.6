Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C320CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A29C21A13
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A29C21A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbeHHXBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:01:40 -0400
Received: from sauhun.de ([88.99.104.3]:38272 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeHHXBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:01:40 -0400
Received: from localhost (p54B334CC.dip0.t-ipconnect.de [84.179.52.204])
        by pokefinder.org (Postfix) with ESMTPSA id DEA856DC3F9;
        Wed,  8 Aug 2018 22:40:17 +0200 (CEST)
Date:   Wed, 8 Aug 2018 22:40:17 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jun Gao <jun.gao@mediatek.com>
Cc:     srv_heupstream@mediatek.com, devicetree@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/3] i2c: mediatek: Register i2c adapter driver earlier
Message-ID: <20180808204017.yfne5q26lmeegyrr@ninjato>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
 <1530955795-17714-2-git-send-email-jun.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="edtn3rcstugf43bt"
Content-Disposition: inline
In-Reply-To: <1530955795-17714-2-git-send-email-jun.gao@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--edtn3rcstugf43bt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 07, 2018 at 05:29:53PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
>=20
> As i2c adapter, i2c slave devices will depend on it. In order not to
> block the initializations of i2c slave devices, register i2c adapter
> driver at appropriate time.
>=20
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

We don't do this anymore. Check these threads:

http://patchwork.ozlabs.org/project/linux-i2c/list/?series=3D&submitter=3D&=
state=3D*&q=3Dinitcall&archive=3D&delegate=3D

(/me just realized that patchwork makes it super easy to point people to
various discussions. Awesome!)


--edtn3rcstugf43bt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltrVTEACgkQFA3kzBSg
KbYICxAAo/n3OTlafeyeRr//nATBT9Z4QGjhugCIw5j1dZeXcVCbHuC6+m5jW2su
Q+JcZSwx3AG3VbgqG6ugJ0QUi94NXv459IbBRuhQQ6FukpKLFV1AwZFasDh3Rmqb
HfcxoTg5zCGEJLwc3nLSne/q7wiMzaImqREHanQUXY/iHIbWDF0g32yL4BSbx+6F
XLIbhAvRE0Xx52QBBQkYpB8FB82H6kgKXu5Kq/PRFs4XAhKtMTb+nMxQExCB8SWQ
yzFmb/6Img+vwY+180qSWlT4NjAYZ9kV5tNjA3qRCg7G1lOJiihjm5l30dZEkZOJ
hCgBh4FN1UMIWn90pgWDZXRNv9ByCvzaUk/NoeRJA8imyjjC7w5+5WVTqIP1oy4u
BRfEbQ3hjBpvm7kV699l78uv+Z6xayEvjHQrbMcTVh7sCODLerMk7Dfrp9GfgUG+
Z1Irc5DcHWDnfD3SyKR5s4XlF3ldND+b+bQEuISXfCgCypF0VVQArT8KSx/V45ga
lgwexvHIakklxVVnEWQhqnkYn5S79SlbHxfPW4hfPzs2EAf0e6PTN3iHMh/WLfKO
wg2NI8z0HkA2G928NvBBkSPZgrvDT26SlAytDreNRGK5Gr0IkKD0ed744ziGKeiV
msiRreTdwi0nKpoxbs1zsGRjsDwk1uaBH3OEpBHynKxSpnrUrU4=
=0m2X
-----END PGP SIGNATURE-----

--edtn3rcstugf43bt--
