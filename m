Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35837ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 16:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E305621473
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 16:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E305621473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbeGORXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 13:23:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41773 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeGORXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 13:23:01 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1BDDE8055A; Sun, 15 Jul 2018 18:59:27 +0200 (CEST)
Date:   Sun, 15 Jul 2018 18:59:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] regulator: bd9571mwv: Document "backup_mode"
 sysfs file
Message-ID: <20180715165926.GB10023@amd>
References: <20180713154720.18316-1-geert+renesas@glider.be>
 <20180713154720.18316-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20180713154720.18316-4-geert+renesas@glider.be>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-07-13 17:47:20, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


> +		     following steps must be followed exactly:
> +		       1. Configure PMIC for backup mode, to change the role of
> +			  the accessory power switch from a power switch to a
> +			  wake-up switch,
> +		       2. Switch accessory power switch off, to prepare for
> +			  system suspend, which is a manual step not controlled
> +			  by software,
> +		       3. Suspend system,
> +		       4. Switch accessory power switch on, to resume the
> +			  system.
> +		     DDR Backup Mode must be explicitly enabled by the user,
> +		     to invoke step 1.

I'd add "please don't design hardware like that" :-). Anyway,

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltLfW4ACgkQMOfwapXb+vIx3ACbBcTCUi/PPHfqfdSn02WIKtLs
my4AoL3X663508fomzXWo409JeBMNQCB
=RVAr
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
