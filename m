Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BA4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D8C218D8
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfACS7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:59:24 -0500
Received: from sauhun.de ([88.99.104.3]:55052 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfACS7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:59:24 -0500
Received: from localhost (p54B3379A.dip0.t-ipconnect.de [84.179.55.154])
        by pokefinder.org (Postfix) with ESMTPSA id 399392E3614;
        Thu,  3 Jan 2019 19:59:22 +0100 (CET)
Date:   Thu, 3 Jan 2019 19:59:18 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] i2c: reject new transfers when adapters are
 suspended
Message-ID: <20190103185917.zfcw24n5w4n4qu2q@ninjato>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
 <20181222202623.4521-3-wsa+renesas@sang-engineering.com>
 <5e560c2e-4da9-05ef-9bfa-3391fdd8ad23@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="waep5l5pjqydoewa"
Content-Disposition: inline
In-Reply-To: <5e560c2e-4da9-05ef-9bfa-3391fdd8ad23@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--waep5l5pjqydoewa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I share your desire to have the check for this shared in core code,
> but I'm afraid that just is not going to work.

Okay, so this series is definately not it. Probably the previous one
which exposes helpers is not a bad idea after all. Because it is
ulitmately the driver's decision when to use the helpers...


--waep5l5pjqydoewa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwuW4EACgkQFA3kzBSg
KbbIYA//U3lleoAK/oWl+9UNpk7CP0tKUplkb/9WLfa5od5R+/aqf5OcavI6ebxa
WELpu0Hu849QTMrm5eYiADrtR4nRdsCHwxtUTfpgbyX63j8DIb0PoQOX6T7vDHNm
ODoIzVQ/rBEK0CFBGGUhqBrU6ZeH2Cgp30WsgB76KhRQptrtK7why4J4afBlGeMS
ZwEkd+bHyY4iFB4DY685UcvK4x0W+PJbmgEDnSG2ArR4M/G9M8RTljd+5aYO96zb
feEp0CTL3huFaVRyUKam6+V8aQc4FgLUl+WlSzlK4zdZ+CVUlxB3r45KA9QXDhi0
xxScjdMoYWAhQ1VZPCMSYgCzV3duiChgztBtzI+uiSOlI1Og94uu0VzasIQ7diNM
VeOgKLEiO4viwncZOY/cg/tnwz/PJFjubY2xrXdWGURnlNBGfxznso9FCnEy06Pk
jWShb8+X0q3NQFMepdD2DlzQYUYGguEANRXkkRICBqXoHhjo8GOyd1Rf7HiA+hqO
cYYHo3+zY6hllamSTkuEHKLLGPu7GP+seUyVXz2MvEgq3yL763MEviUCCt1/xb/G
5v2XkY0Jv5NaRj6n0xD+xj1lS//vUNDtIf8JegowCQqaAAsLXJeT1/MJyo7xMQvC
YggEZWu+12HQvPZyq446l9wP46xV8D95GukSI6HCnJsDSqDaTkA=
=ujG8
-----END PGP SIGNATURE-----

--waep5l5pjqydoewa--
