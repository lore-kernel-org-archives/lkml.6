Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7A5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB47214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB47214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeHVJzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:55:49 -0400
Received: from sauhun.de ([88.99.104.3]:48168 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeHVJzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:55:49 -0400
Received: from localhost (p54B3399D.dip0.t-ipconnect.de [84.179.57.157])
        by pokefinder.org (Postfix) with ESMTPSA id 9F9922DB8FB;
        Wed, 22 Aug 2018 08:32:19 +0200 (CEST)
Date:   Wed, 22 Aug 2018 08:32:19 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] dmaengine: use SPDX identifier for Renesas drivers
Message-ID: <20180822063219.lxkrx3neq5mzgeoo@katana>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-3-wsa+renesas@sang-engineering.com>
 <87k1ojfdao.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iolgkshk3prmjusl"
Content-Disposition: inline
In-Reply-To: <87k1ojfdao.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iolgkshk3prmjusl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fabio already indicated samethings on [05/11] but, we want
>=20
> 	- GPL-2.0-or-later
> 	+ GPL-2.0+

As I mentioned there, too, https://spdx.org/licenses/ wants "-or-later".

> And, we need to care about MODULE_LICENSE() too,
> because sometimes header license and MODULE_LICENSE() are mismatched.
> # I didn't check detail of this patch-set...

I did check this twice and modified where MODULE_LICENSE was wrong.
Another look may not hurt, though...


--iolgkshk3prmjusl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt9A3IACgkQFA3kzBSg
KbYhMBAAnKAm6wFrBl15XBzcAsuSdyaNch6Tox4nP6NlUpDkCvSMwLv0ZrUmtsB7
nNHnOccGDgu5hPmwemf/UqV8swGXVRH4JCTgdx0eIgC2PemSrtfB0DHMg119d67H
iiawf2RnYDBb5J17AYhaNO6hJHEJRfKRy4vB61dO/zikxEX176Fs2j84QJcqE/rp
oxPuQbqBJlYYh9TgQaglBQg2WQfIpYzdST1UQzu8m6UVXHcJle3WA3HDaUN+dAkk
8kAQip4NnSiUEkBPHjmAWKMZHs1wc9oX+0Dor36bcNks0NVZ3oW693NpF/NxaMfG
GKNioPN1OnBlWqeRq1VV8E13NLg/zmIF+5m2fSy1/zmC1zNtyPVobbuR93BOpAw2
IGox56ooXeM2in3U566UX5QmUYtyMDFcmSoC50rXg0UMcSnJRrvl3AyWfkuFmcqV
oqkFz6jVRfpNnLJ0s6/j+tgzqJtwMe9nhdVe/KMFEv3YZebiKyvSuAs9v1UZmWdn
FhbIjRnjC2wcfiE5yP4LnpB5Of4uVA+GR53OWpKKEGKfoTLrIVGgc9xXVnEDoL3o
SN8i8kNNkAb1oNJq0+ZhH32QnVkvXuoIDO09wx1sLnXO2OgrUXJTR5UkpeZJ3T8F
EDNdVSrM0CYwSueqeOLDOxXsIpE4PeaTsT9A3zKbuhKeetMlJsw=
=sCoJ
-----END PGP SIGNATURE-----

--iolgkshk3prmjusl--
