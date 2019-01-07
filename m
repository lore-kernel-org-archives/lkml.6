Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8F5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84B5206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfAGRrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:47:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47425 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfAGRra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:47:30 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 51BF3808BF; Mon,  7 Jan 2019 18:47:23 +0100 (CET)
Date:   Mon, 7 Jan 2019 18:47:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/5] dt-bindings: leds: Add pattern initialization
 from Device Tree
Message-ID: <20190107174727.GC933@amd>
References: <1546596524-19863-1-git-send-email-krzk@kernel.org>
 <1546596524-19863-2-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <1546596524-19863-2-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-01-04 11:08:40, Krzysztof Kozlowski wrote:
> Document new led-pattern property for initialization of LED triggers.
> The property format is trigger-specific (except being array of
> integers).  For pattern trigger, the explanation of pattern format was
> moved to a common file shared with sysfs ABI.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwzkK8ACgkQMOfwapXb+vL5pQCeO4MLUeeMzDKjRWC35yefPMHF
9FwAnRtlHMrMObXpRTe6v+tAd/9mW9QF
=Uqhn
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
