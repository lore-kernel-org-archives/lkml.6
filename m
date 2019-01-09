Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDFFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CFD206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547053050;
	bh=wfdEjxpAJ4QXeepN+OPAmEvEbCGPVY4MGjfiwIUCrhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d8yifjcnXYJqO4AOz2y42/MJ2ilSaQ3S3cHR0QUhNreKTG678aV49sjawXG0iKpQB
	 UtiH4Vh3aO7GErbSy7GByP/etNW9mbEHIL0DxLEEJDpPUBJasOdEKM7Cokl4CoMukC
	 94rNQSOhX2Q319Ufs5zmnPrHDj1RPj++7OqbSZPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfAIQ5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:57:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43008 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfAIQ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GvYq4vyRjqFQymgiui7P+XqGYvBX6YU3Js1Sl+P4P8Q=; b=sfXCxRNHaZrSJ5ywr7tXNaRp2
        iPb7mhy5LZSpXOuZzqUuq4CskicaTM+3BPwgalfUPkdw7F9L5QbgyL9zQNi9BgsDIXz5nOhzzdaWt
        0/DuPqVeFRYz2GsZN2bAyd/GteJo6FnVlqjVtxYz9pgnFhLOKp6Ma6V+Dzq7cW1lRS6zg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghHAB-00009u-EC; Wed, 09 Jan 2019 16:57:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D8D831127528; Wed,  9 Jan 2019 16:57:06 +0000 (GMT)
Date:   Wed, 9 Jan 2019 16:57:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux@armlinux.org.uk,
        lgirdwood@gmail.com, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Message-ID: <20190109165706.GG10405@sirena.org.uk>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Content-Disposition: inline
In-Reply-To: <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 10:56:32AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Add helper to check if regulator will be disabled in suspend.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

This feels like it's the wrong way round - if this is configurable I'd
expect something to configure the suspend mode and then for that to
arrange to configure the regulator appropriately (along with anything
else that needs doing) rather than to infer the configuration from the
regulator state which feels fragile.  But based on the cover letter
that's kind of like what the initial proposal about target states was so
perhaps this is the way we end up going...  this certainly looks a lot
less impactful that the target state stuff though.

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2J+IACgkQJNaLcl1U
h9DcRQf/f2syn6A2vAA52taqMOX2yicco2vyAygNn47KH3gVlPg1zONPpEQpIgbA
bLBFQrcsF6qDNKhaFtuyoAf6OhTW0Zhx7GMGpiUAeGO1MhG4YH1KYw+bGMG6BxW6
QwaIOK15x1wagCtuI+837xmUUaWDHESLog4uvgpg7lEjZxfeXgsiPc9pCkLlrI2o
2ed96DyT4s/wHdwz61gi5INpScrynAEfzkyHhluYnHVES+6yS52E3NhipLgqbIj8
EhunSZJQFh+QpM3AG5ithO237q3mvPsKV0tUmBjWRZsuL/xrUlqd26J7iDye/52r
CZzk8FIhWeH/0fODpyARFAjqacYa5Q==
=Oh5J
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--
