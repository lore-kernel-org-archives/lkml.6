Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA61FC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD5E2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD5E2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbeKUAqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:46:40 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57279 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbeKUAqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:46:39 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F3CAA20D73; Tue, 20 Nov 2018 15:17:16 +0100 (CET)
Received: from qschulz (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id B0C5220D2E;
        Tue, 20 Nov 2018 15:17:06 +0100 (CET)
Date:   Tue, 20 Nov 2018 15:17:05 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] net: phy: mscc: fix locking in vsc85xx_default_config
Message-ID: <20181120141705.44odry44hhdy3cge@qschulz>
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
 <20181008100728.24959-2-quentin.schulz@bootlin.com>
 <mvm8t1pazea.fsf@suse.de>
 <mvma7m3n9l6.fsf_-_@suse.de>
 <20181120135508.paxzs63cqy2llc7d@qschulz>
 <mvm5zwrn8zu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n5xcw7r3bck7sftm"
Content-Disposition: inline
In-Reply-To: <mvm5zwrn8zu.fsf@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n5xcw7r3bck7sftm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Tue, Nov 20, 2018 at 03:01:25PM +0100, Andreas Schwab wrote:
> On Nov 20 2018, Quentin Schulz <quentin.schulz@bootlin.com> wrote:
>=20
> > You also need to prefix your patch with [PATCH net-next] instead of only
> > [PATCH]. This is specific to the net subsystem.
>=20
> Why next?  This is a bug fix that needs to go in now, not next.
>=20

Indeed. Use [PATCH net] then.
Please refer to https://www.kernel.org/doc/Documentation/networking/netdev-=
FAQ.txt

> > Use scripts/get_maintainer.pl on your patch to get the people to put in
> > Cc and in To.
>=20
> The same people as the original patch the added the bug.  Why would it
> be different now?
>=20

First, people may have changed mail addresses (especially maintainers)
and that is picked by get_maintainer.

Second, other people may have worked on this driver since the patch was
introduced and they might want to know about this change too and have
their word on it. This is what happened with this driver. Gustavo and
Heiner sent patches since then and they have already been merged.

This is also part of the contribution process which is defined here:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

You have not answered my question yet. Does this fix your issue, yes or
no?

Quentin

--n5xcw7r3bck7sftm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlv0F2EACgkQhLiadT7g
8aOEgg//SEW1tvlbP8HIMI9Azhv0DP9ED+wigV9oT0h0ZxbRMpVqwKOSlT2sJX8m
Q1qYCfyePxN5+F7ALFT4iYHmneUqPTkX8fbDf+Ij91O+O77lk+kgf69TdJhIugaM
oH68FXs9mdkZZElqxMG7iuavsloLOaz8nPlbPpLujWkD+ggVUlz3m4+d32T5jY8P
nTxVF/cij8U2gjVBHyHrTde7OpnD1tQmGoL3C+yLSUpJsuWBfxp8twq3g/YXNHmb
5k8YPl23lNSvscbh4j41Vo/yN326Ooager5AViiknhAYfPLbukotSyzH/hAx9KcK
SRnuqMnBNlgKZkaRGuWYGqbIf+Rq14f8DLntOCyBUP/pdEHApHAlPLzwF/qHS6k9
QsW1Rxck6fDmmUGdYxlRsJLpjkQjeZmGgn1Q24ZbhxFC6s8Z7f5cmgeL1WBVdkhH
AKhWSwmYB3Bsp8OtFcsKvNC/6jMGBU4BAihVO6DUhD8t/OyozJdaAy/pu614uIYN
IcnZ5dBXZ+7Jh2sLC1M/Gn82g0XPr7ugf/OQMgzsh3n22Ybpo9ziguz5TeiYFaXK
qaB4BoNo003SUR53w9Iwy5KVGYiCs5W7ZdgcCqrkK4Ht9b7uPzBaqYwG0evHHhgw
xL/6FgQYLxCPn9Ccg/P6ytLiC+MRN7FXzuoldiNtlmNQeHvzUmI=
=85Mb
-----END PGP SIGNATURE-----

--n5xcw7r3bck7sftm--
