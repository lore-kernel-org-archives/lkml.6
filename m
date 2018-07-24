Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A66FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF7C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF7C20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbeGXIdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:33:07 -0400
Received: from sauhun.de ([88.99.104.3]:54572 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388364AbeGXIdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:33:07 -0400
Received: from localhost (p54B3332A.dip0.t-ipconnect.de [84.179.51.42])
        by pokefinder.org (Postfix) with ESMTPSA id 624926345DB;
        Tue, 24 Jul 2018 09:28:00 +0200 (CEST)
Date:   Tue, 24 Jul 2018 09:28:00 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH/RFT 2/6] i2c: imx: use open drain for recovery GPIO
Message-ID: <20180724072759.iirtq7qhydn4ep34@ninjato>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
 <20180713210920.3648-3-wsa+renesas@sang-engineering.com>
 <1532350048.3163.101.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="skzrjsklhy4e4dwq"
Content-Disposition: inline
In-Reply-To: <1532350048.3163.101.camel@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--skzrjsklhy4e4dwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> I don't think this matters on any of the i.MX platforms, as the GPIO
> pin configuration (including open-drain) is only taken from the DT
> pinctrl, with the GPIO driver not being able to change any of those. On
>  the flipside this results in a near zero probability of regressions.
> ;)

I see. Thanks for the heads up.

> As this is obviously right even if it doesn't have any effect on
> current software:
>=20
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thanks. Yeah, let's fix it. It might serve as an example for other
people.


--skzrjsklhy4e4dwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltW1P8ACgkQFA3kzBSg
KbYdPhAAppSjM0SiZ8UDMEQHF9emyutkO1hSHCJ4vhBCqrOES9NpXTBRT3fmVwsl
Sw6D1VwDETyIFIj4LNyZwBc//lLednhElmgPygr3TQoSjdNnoKlvoZ2+pwSDfFam
Fulr2dfaNv/rlG+pin+ROGZN4SM2FHIPBUIflqK3xt8nkhNWCFVfVyseQBvTF60N
RswcuVF/kke3ilsjnEONyZ3HzaL7XXFk5A0kjX7GRBbhYOqXoZbIpgxSU8IQ4Syw
8kItgDn9DnrtnWjLg/HZsFD8FENPkXqMcei5fVnRZgDSzKHXn3wraZNe9adAjCHG
CjuoKuCjLjSVrY35tb9lNWa8NYhEOPE8Avn922nlgS7kGn6ACX/vQUDbRPQxic9i
C20/mTvh6IfhQpoyAsxAeqIMlxdX5n9IA+R0v8e/Az9Y/dTo6Pwl0YVeyPNmrbCd
X28csVWqYu3tJ7Quizg/c6DeYl40G0RQgvQymtINNjEBnqK8nKAqu3KDqA8GLFe7
R+RiDeN7Pf0mUVkUj0kZMcpyXwkBdzM6UvPnVaxTNbJQZMwk+Kx624VHWRyqJEON
HQsMblFcFhmmNkXfeJdI7EiqkURq5TGgYh7vK7NOTevPuwYIewOhFzKVQzyaqQ9o
Qgk3NTHfBA0gI1q72iRCVcQS4RB1pWFB7N+mDIKaeImzieMh+1M=
=Msjr
-----END PGP SIGNATURE-----

--skzrjsklhy4e4dwq--
