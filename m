Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79926C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF052146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF052146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeK3VBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:01:52 -0500
Received: from sauhun.de ([88.99.104.3]:56464 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbeK3VBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:01:52 -0500
Received: from localhost (p54B334EC.dip0.t-ipconnect.de [84.179.52.236])
        by pokefinder.org (Postfix) with ESMTPSA id 592B42E3542;
        Fri, 30 Nov 2018 10:53:05 +0100 (CET)
Date:   Fri, 30 Nov 2018 10:53:04 +0100
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
Subject: Re: [PATCH v5 05/15] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
Message-ID: <20181130095304.GA1079@kunai>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20181128114535.80223-6-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 01:45:25PM +0200, Andy Shevchenko wrote:
> The caller would like to know the reason why the i2c_acpi_new_device() fa=
ils.
> For example, if adapter is not available, it might be in the future and we
> would like to re-probe the clients again. But at the same time we would l=
ike to
> bail out if the error seems unrecoverable, such as invalid argument suppl=
ied.
> To achieve this, return error pointer in some cases.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwBCHsACgkQFA3kzBSg
KbatgxAAob8ByaeD+a5hXFcsADxN47hMoRQWCjmzwp7C8iIQhGAVYnXwU+mabN3h
p7hLzaSGoM76GqF3L7nFZel4qS643B3AYCfd2KHZcp+9cQwXfL7XGXdWJ1IFrycV
1hvYPdLTf72sBBc95Cswt9D8v340aX0lTx+sIFUXnIbmQVQ8YVfQoA7SnCkIzDsw
WFJZerxwKzTxaS1TZ/ARZn0TxBURp94AadqZGibVxNeXgsTI5e0Jvudl3n1CtZW8
Xcvt6SfnL4T3DOxuinhHOm5qDeThHfsq5xoK+30dyjzpylMnMI8Fg8Lir5rqigDJ
gxZfko4HIfKAlh4iUxLcqBim3ou5K5IzqZocIHEHQ9RQdHRcBEqAGmZkyqpeGDhW
p/njU8Vz1DySJn1nhw99TMGgsSeFuljCyBhxB9L0tAQlltCWJjlyerfb6Qsz8bDG
ahkAzFDBZsWKNFuPLAss/tn5jpOGwg3AY+2Mi1d4miyyLIazkIzBMIJtdbuE3faY
YU43zdGi895xX/r/d3LTEIQ8ZSbK+oFq2cfQ9Ks/NKLC56fq46/jzBdvJWg7yGui
MyVyWc07Kt8MLban4qXPiYTbCkyGrHVWwObK4ZTNysdOZH9pBYTP3HHLGkvCiieh
5w5SKyUMIBR/t4mTcUIy7J9sc3RiLbL6PyfcEmVQvnFlSeqwcqA=
=yHaq
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
