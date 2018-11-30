Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A6DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A30E2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A30E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeK3W6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:58:53 -0500
Received: from sauhun.de ([88.99.104.3]:57782 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbeK3W6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:58:53 -0500
Received: from localhost (p54B334EC.dip0.t-ipconnect.de [84.179.52.236])
        by pokefinder.org (Postfix) with ESMTPSA id 9B6D12E3542;
        Fri, 30 Nov 2018 12:49:50 +0100 (CET)
Date:   Fri, 30 Nov 2018 12:49:50 +0100
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
Message-ID: <20181130114950.av6pnedcqu27jyjc@ninjato>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-10-andriy.shevchenko@linux.intel.com>
 <20181130095533.GC1079@kunai>
 <20181130105759.GK10650@smile.fi.intel.com>
 <20181130110652.ckj75wrxxaez2sq2@ninjato>
 <20181130114543.GM10650@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6gjjnir427zmfyyw"
Content-Disposition: inline
In-Reply-To: <20181130114543.GM10650@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6gjjnir427zmfyyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Is this something we have to live with or which can be cleaned up
> > somewhen?
>=20
> My opinion that we might need something like
> drivers/acpi/acpi_i2c_lib.c
> drivers/acpi/acpi_gpio_lib.c
> etc.
>

Collect all of them in drivers/acpi/acpi_libs.c?

> But better to ask Rafael and Mika what they think about this.

Sure!


--6gjjnir427zmfyyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwBI90ACgkQFA3kzBSg
KbY75RAAg+ixCqXr69OL6aIb6Ji3HNoXn8t/ztlQsaYfvgulytbqf6/ux7S/6bk3
3rkDWINLSyTT/lxAQuZncFLBqqqkoRNF9jACaqOiX7tHc/tPOjaoGKRLc0cvQz+C
gvDCGVHi3Dx8vysXvX3/WAADa+2rEvrg1OjWBlR0bLh+Y0ONfqEnbWRnAj7TDA0x
m1PDTFkshdArH6y2Qx/HDctKPA279ZPaVojLLpQJJ1ResABa+4tpYgRR55ED/3R1
vwZU+KVSVIQhexjUmqW+gfKYT3MLJYHD3uKB5bU+k11gpbRp3c6Odozb3d2xvY9k
5LoAYZ38Jd7lgoaHl2pQJzpm3KzU5OvPcz3p5IvpUHf0E37rrnfBHjigTYqixVGr
czVTxxJvbn0gKRaB51XBJoynG3hFXj5LOAOHKlLe+xOcHgLqAj3K3Axr1Iqfh0tn
O9G3EwKT6o5AgxnaP3AL14sZ8v5CGfd+LH2OIf4gfddgM7mON1HwXZSXqFD1qFqO
hUsnfAu/ewi/wF0aWuo8i0eQkfYgVxxZwmdgqDFEFzcRUOaT0K92Dd3uQ1H7/1Ic
czQafctql4NBi/w0h1VLJIxOeW4Cp8kKslWNyb9CFDRXRvIf3GAt/lvoorF1LOCB
tHB25A37P+6x89RwRYts3UnXE0VYvAx/1PBmYlvh4H7gOLXQ9h4=
=bd2p
-----END PGP SIGNATURE-----

--6gjjnir427zmfyyw--
