Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A849C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD842084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD842084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbeLKUkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:40:19 -0500
Received: from sauhun.de ([88.99.104.3]:45686 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLKUkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:40:19 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id 599C74C0E8F;
        Tue, 11 Dec 2018 21:40:17 +0100 (CET)
Date:   Tue, 11 Dec 2018 21:40:16 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ajay Gupta <ajayg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: nvidia-gpu: mark resume function as __maybe_unused
Message-ID: <20181211204016.yrtpw4oodeets64e@ninjato>
References: <20181210205356.2846843-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7plmlgd746tbu72r"
Content-Disposition: inline
In-Reply-To: <20181210205356.2846843-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7plmlgd746tbu72r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 09:53:45PM +0100, Arnd Bergmann wrote:
> When CONFIG_PM is disabled, this is needed to avoid a harmless
> unused-function warning:
>=20
> drivers/i2c/busses/i2c-nvidia-gpu.c:345:12: error: 'gpu_i2c_resume' defin=
ed but not used [-Werror=3Dunused-function]
>=20
> Fixes: c71bcdcb42a7 ("i2c: add i2c bus driver for NVIDIA GPU")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to for-current, thanks!


--7plmlgd746tbu72r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQILAACgkQFA3kzBSg
KbZC3Q/+NqUuLEXbDtQQwaAfqsEIqzJvjH4HXSuKXfgV8jfdvDNLDZ4zQwygKzD/
Z+oBuVIUdC2abTJMGPDFixz2j8MjsWuDo7uEEfPrsgG5fLC0yN6ffMIboxYO0MdC
qL7Kka/uELRe+//MNQuVipn5/Ytg+6lLQgxljBD7n4mCm/5rzEpTCG3yLzRZi6ak
q50WwfKAHOQ3TNy+UNHtTreM3RWhYpc7Y3ahZr8UhQTATcfCspLFGwf4GOxuNIo5
UZwR53DGx+UwwP0r3plUA4b56QmvZY5U7j1BcOkmpotaANGbMufhvNzOkACf+Xs5
Z8nOa/XfTRy2oecC/J7dkGtexnbZwoDiKM/JQigdoUdlwYjW4MMllbzYGoHOiHeJ
iTf5K9FF2+tCtxxpA6/Pf/1pFw/6OSyoSPXQRcq6qyXL2Ea/xBAUni7FPk7WfYKo
1FQyBP0iM3uxGvkBJZxJhg4mnwKcbb3nqzKuHHt2pcQZIZ0liR0J0/rpiFRYjsdo
xkwqnxQha9g26izGokmFAQaHIGsP8Ymms2Z7pzZoi6yspov+gHTgXp3/SriRgXOF
mHTBziwPl5h8+3i6hkO9WcRBHWZf+N+6gLtWFCFOCimu/Ps5f5U2E+tRoKby48zC
RDw1fGPxAhrE58aL/TU99Cxc5weNn16sKFylDtov+sZhg9X/YZE=
=j1hl
-----END PGP SIGNATURE-----

--7plmlgd746tbu72r--
