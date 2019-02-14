Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FAFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A98821928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393826AbfBNQvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:51:14 -0500
Received: from sauhun.de ([88.99.104.3]:54056 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731118AbfBNQvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:51:13 -0500
Received: from localhost (unknown [83.221.228.209])
        by pokefinder.org (Postfix) with ESMTPSA id 2CBB92C2817;
        Thu, 14 Feb 2019 17:51:09 +0100 (CET)
Date:   Thu, 14 Feb 2019 17:51:07 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, Peter Rosin <peda@axentia.se>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
Message-ID: <20190214165107.3kaeiml7nc5zl5v4@ninjato>
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
 <de27b8f8-ba8e-fca7-6bdc-cdd580d959e6@axentia.se>
 <cdb66da2-4886-e3ba-e78e-264bd4b5b73c@gmail.com>
 <20190213083519.tynjs3ef6tnvvsms@ninjato>
 <b299217a-454d-6d3a-9c48-3500a95040a7@gmail.com>
 <20190213145557.vdxahpsacgy4oznl@katana>
 <BYAPR12MB3398B0893B586A587CBB3F1CC2660@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ql5yo3n2roeoied3"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398B0893B586A587CBB3F1CC2660@BYAPR12MB3398.namprd12.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ql5yo3n2roeoied3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Appreciate if you can help fix the comment while applying patches.

You are welcome, Sowjanya.


--ql5yo3n2roeoied3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxlnHYACgkQFA3kzBSg
Kba1hA//dPQM4ZvlsEkk6tomTYMwWdGV2oKYM1eork7sZ/z/hXgm3lWpvzTmHOCn
zGBQXXVt7H1Bt6Btks0bd7JlqPOLsrCrKScBrm/8x3tSzWDo+tO3iXXu1cegt4kW
Aaa/FWr5oIdjZigk2Lv/unBVWOZck87rVN7WiBXSAQXsEkZRAf0Rbu1bjuD80huE
6voe3Dkk0MBgRhQA5HLYg3JkEQii0kUQ46EFrWHQFdsNeNqK1Dzvkbe3yVKBKDBK
h4owR4cDUvPqTttTmZhBwr9aSGfoXznO0hcSnpwnIzpVG0rPVqlPx41SIAZAElXd
ILveCTD+FK4IcK3tp7KNHh7V+mfk5WDCtthCT+/1g3MaCuuYEXkEkbZy+48sqmxY
BGBoC65oqrm7bK12hFykRlTAYdiZQppL8cuD/P0ONVrTKKmNGYu6fWC/2dkV9jzG
2Gz3QkQcRyGDBGAQo1sszLK846xhIjVyE7a9VtlXblcHf98QtiwvSwtHWMHHIySu
dCK+HfWKAcTyFA5PcktdhxrOqjxTdm1vQy/PlOMIPyQwQ9rBdKFxSP43UMnZFzs6
hJSNrslyj1xXtVGM3Pt14R2qB6r820306utg9oj60sZuWehr6pPeEugNApY9qbz8
K7ZMP7LNE1UU3+zro7gV3MHrVqVEwIifCG84bFGSTeT3VBSmxM0=
=fUJg
-----END PGP SIGNATURE-----

--ql5yo3n2roeoied3--
