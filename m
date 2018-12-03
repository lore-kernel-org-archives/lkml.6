Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D8FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EBC2148E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EBC2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeLCJYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:24:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39151 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCJYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:24:13 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 50163809FB; Mon,  3 Dec 2018 10:23:56 +0100 (CET)
Date:   Mon, 3 Dec 2018 10:23:59 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, khilman@kernel.org,
        ulf.hansson@linaro.org, len.brown@intel.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] driver core: remove define_genpd_open_function() and
 define_genpd_debugfs_fops()
Message-ID: <20181203092359.GA21500@amd>
References: <20181201015154.4718-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20181201015154.4718-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-30 20:51:54, Yangtao Li wrote:
> We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define such
> a macro,so remove define_genpd_open_function and define_genpd_debugfs_fop=
s.
> Also use DEFINE_SHOW_ATTRIBUTE to simplify somecode.

"and there", ", so".

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Otherwise looks good.

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwE9i4ACgkQMOfwapXb+vK+3QCgrzj/A2MVArH+6HYu9tslOC3+
FEUAn3yBGHd80WYr+KsdPk9YQZiQpKta
=Ore1
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
