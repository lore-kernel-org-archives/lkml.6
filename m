Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5279C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F54220825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F54220825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeKJBg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:36:29 -0500
Received: from sauhun.de ([88.99.104.3]:46236 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeKJBg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:36:29 -0500
Received: from localhost (p54B3380A.dip0.t-ipconnect.de [84.179.56.10])
        by pokefinder.org (Postfix) with ESMTPSA id 78DEF3E4482;
        Fri,  9 Nov 2018 16:55:18 +0100 (CET)
Date:   Fri, 9 Nov 2018 16:55:18 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Vignesh R <vigneshr@ti.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Strashko, Grygorii" <grygorii.strashko@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add entry for i2c-omap driver
Message-ID: <20181109155517.GF1031@kunai>
References: <20181108091931.3342-1-vigneshr@ti.com>
 <20181108091931.3342-4-vigneshr@ti.com>
 <20181108092320.GC951@kunai>
 <d57ace5e-d42a-0a0e-2813-4a25cc6b37bb@ti.com>
 <20181108150231.GF56134@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline
In-Reply-To: <20181108150231.GF56134@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 07:02:31AM -0800, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [181108 12:28]:
> >=20
> >=20
> > On 08/11/18 2:53 PM, Wolfram Sang wrote:
> > > On Thu, Nov 08, 2018 at 02:49:31PM +0530, Vignesh R wrote:
> > >> Add separate entry for i2c-omap and add my name as reviewer for this
> > >> driver.
> > >=20
> > > Thanks for stepping up, yet out of curiosity: why not maintainer?
> > >=20
> >=20
> > I wasn't sure whether the convention is to add Reviewer or Maintainer
> > entry for individual driver. I would be glad to change entry to maintai=
ner.
>=20
> Great, yes please do!

Cool, thanks all! Tony, I took the liberty to interpret this message as
an Acked-by so I could apply V3 of this series right away.


--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvlrd8ACgkQFA3kzBSg
KbbfFQ/+P5ALnhyR70cHolGU5QzSpS/F5HghAOsLDbh6KM7qKXh+W6BXKMWpKs4y
pWVM+4g0rjaDbFMh/toX01FcSs2uDCONxFFN/e0bmQTrGaCVcBGqu4+M7mps1x9g
bZtGKkX5aM0P53g2qCjAfjEcM0GAJ5upAvcblH3qojxnlGdQLjc5hRmLwelyJFhu
cc3KvF1YgL/+nlc3Mf4O4Seaq7ZKlCsB4ntH+Tob+uJ3ubh5/1QKwP/CfMKioaou
VJ6X7uuHgXleyJNxhhgzucxjl2kY0NJwMTGGFUPMUhDTME2/SBYe6s8bIsclZJU3
0FocEKayk1c0BLoxNjWUqMImUdB9l1nceodmy3xHqijRE5TxI9IRpWFB3SQ5Wx+f
pZwMK5J/4bUOr3u9OyXk4m6qJqk4+JuzaBL1BY4G6DRY63J8bV9gLoPRY+p94nHi
jd3aaXWKoo1yvigH0mfetjiCLioZ40FIHIFDzKLbz3L6JV9Iw+Ig30u9pAK0SZBa
zbhPb3G/p4OzhOmtswRygnN/P+UCo8cQ7alpJEXmc5mJseTFajABw1zlGfm4MOel
t2FNOaRgjDDaxL2uCqz0JmWUiJcCY0EOj2FQUFaFr/UBMYQIEZGB6T20SD1sfjaO
FeKWtNxdXiRRYqJwPykNTLzlyK0lbCWzO4M/E5+38mET28LaZcI=
=E6jG
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
