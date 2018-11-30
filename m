Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F2CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817332146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817332146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeK3XZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:25:11 -0500
Received: from sauhun.de ([88.99.104.3]:58134 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbeK3XZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:25:11 -0500
Received: from localhost (p54B334EC.dip0.t-ipconnect.de [84.179.52.236])
        by pokefinder.org (Postfix) with ESMTPSA id 97C412E3542;
        Fri, 30 Nov 2018 13:16:03 +0100 (CET)
Date:   Fri, 30 Nov 2018 13:16:03 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/15] i2c: acpi: Introduce
 i2c_acpi_get_i2c_resource() helper
Message-ID: <20181130121603.b4k4zam2einjfo6c@ninjato>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-10-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s55zzmyaiqje7y6c"
Content-Disposition: inline
In-Reply-To: <20181128114535.80223-10-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s55zzmyaiqje7y6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 01:45:29PM +0200, Andy Shevchenko wrote:
> Besides current two users one more is coming. Definitely makes sense to
> introduce a helper.
>=20
> No functional change intended.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--s55zzmyaiqje7y6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwBKf4ACgkQFA3kzBSg
KbZJ4RAAsTTwYZFyj8gLvH2/MtntN5QlmqDMwnED9VX6ZYy9OqNC7Tq/fgEsWmJq
Dijybu0FJ1j3nft9+dCf+Jmh8fPEhOLbmDvcbrm+6wqYMZZOTxL2/kocW+cavqv/
5qBppngw9YCQEBPxWP0XvuvFQy09fqvn4KlCOEBxd1BpmqwTnmXioGRDWuiw8HEI
hYY0VIgIApJPPsjAQ+LoPcqvg/uvqdNZqCiUP+HMticMcrsQzzp0IGXOhJdgaBCX
TdjMcXze1hx2abwCmockjYWNmtmRlQzfU+CslJuI60y89qYymD9cA0XzfxyEBh+M
MxgK9Z1/Pvu2EtEOdgTYP6HeOWiobbLSzLtJzt+fTuR/xk/Er6rYTJXSAL2q9OP2
1OpaosCYWQoTnEkbveV2sigB69CZ6Ox3isEXSj62MZhAI6c74N+CAIH8t49t/GSi
OmjhkLTkiPQwYkAaLezUBgb0T7V+DbbS252EfeuCzpxTM8nJtNI28+9lum/OCO5L
AZXFLkxcyxMy06SKE95i4aPYC88zq8C+hpq4TAZWjKXhRKML1DZ0XtI8B3vv2yBu
5Wf9MS+pr/h4B0vt4sU8cDieplUnSbmc7TmXz6VAeZZsdgwuoThjjkZ3Ztn90Kqt
QE31YTGOcJNasWeI6LVOZsiYkDV/RmntwzxV5lEXOmcAFujzyFw=
=XmS3
-----END PGP SIGNATURE-----

--s55zzmyaiqje7y6c--
