Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4D9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FACD208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FACD208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeH0XdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:33:09 -0400
Received: from sauhun.de ([88.99.104.3]:35186 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbeH0XdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:33:09 -0400
Received: from localhost (p5486C20E.dip0.t-ipconnect.de [84.134.194.14])
        by pokefinder.org (Postfix) with ESMTPSA id 562B432CAE1;
        Mon, 27 Aug 2018 21:45:06 +0200 (CEST)
Date:   Mon, 27 Aug 2018 21:45:03 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] can: rcar: use SPDX identifier for Renesas drivers
Message-ID: <20180827194502.jtqq6kpopfnek446@ninjato>
References: <20180823133456.4748-1-wsa+renesas@sang-engineering.com>
 <20180823133456.4748-3-wsa+renesas@sang-engineering.com>
 <89e744d5-8739-5215-1b37-fbd2f4be7aee@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l7p7r4r3vorjq7mm"
Content-Disposition: inline
In-Reply-To: <89e744d5-8739-5215-1b37-fbd2f4be7aee@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l7p7r4r3vorjq7mm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Applied to linux-can-next. Please add a patch description to the patch.
> My $UPSTREAM doesn't like empty patch descriptions :) I've shamelessly
> used Fabio Estevam patch description from his flexcan SPDX patch.

Thx, Marc!


--l7p7r4r3vorjq7mm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluEVLsACgkQFA3kzBSg
KbZmgBAApXSSFHnCvU9S0O97SDUbrTBHBqztPVZDHZ6vFc6WibEJ0DEswVSUoa15
CEs8Y1TfXtT/RjvjGc6rqDDt4n9wjvw0fmPn3OpjEAoQUxLnV9ngetXEKDdGCWln
djpQb2IFzagXFkiNP52mAPw3crt4w+ylsRo9Gxtbvi9Nf96eKrk6IgweRGMHbiFl
zdxKcqJvN1k7QoYGMuYoD7fRFlrl2V/jAfAu2AQYbORVglT0G1SH17Gt2ZIqgocD
2/fXee2WCivvxHnYo0cnWUyZlMugX2D31y0MSnWsTQF46FNTCRL1LD4FmNIjg0aB
cMbiAzsdi/bLaHnV+ikM22Av3WabHx0MUg5+NeAb4MdWBeNzm1Oz20yO6OjJwie3
8nbn3WR3W88snZ7LXn/L3Tq9KQOFI+FazZ0Cr8umBao1eYexgJ+0d/BwI+Jzxwzs
RVoSKdqG7a7KIyzEWijXE6FlSaxs2WCiL3GtMatapE1I/2ds/STMeOl3v19XPweq
MQ+GTbUyFVnZ5V6tH2YeBrZcM6ZsXAPHx4QhSQegHa3Q2/hFKClYB0e/jZU6zYef
fjRLvs/j/fm5BBHKOJiXNRp+8aFipk4yAmjqQjxMaHkDDm9KO+PONWzuIWywBjrT
y5fA9tDTVSjNH6Ss1zOOteQIqjOI5+2z00e/dWvScTVa1E89csk=
=DTLn
-----END PGP SIGNATURE-----

--l7p7r4r3vorjq7mm--
