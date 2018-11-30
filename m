Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8317C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DFA2147D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DFA2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeK3VCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:02:00 -0500
Received: from sauhun.de ([88.99.104.3]:56482 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbeK3VCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:02:00 -0500
Received: from localhost (p54B334EC.dip0.t-ipconnect.de [84.179.52.236])
        by pokefinder.org (Postfix) with ESMTPSA id D33332E354A;
        Fri, 30 Nov 2018 10:53:13 +0100 (CET)
Date:   Fri, 30 Nov 2018 10:53:13 +0100
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
Subject: Re: [PATCH v5 08/15] i2c: acpi: Use ACPI_FAILURE instead of
 !ACPI_SUCCESS
Message-ID: <20181130095313.GB1079@kunai>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20181128114535.80223-9-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 01:45:28PM +0200, Andy Shevchenko wrote:
> Convert to use ACPI_FAILURE instead of !ACPI_SUCCESS.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwBCIkACgkQFA3kzBSg
KbY5qA/9EvhqGiA1GTiRhJB7+aXNP9yLzO5EFL6NWklE3BNhiixwahyTI6PGRcEK
t93xS+5Xi4+mENCVAxNG7V1dW2QfC9E6SKxAvVjnA2G9+fLQEp19KoXlUtY+j4Y/
iaR2lUFk1e2jJ8DrKNCY0UYCGNUxErS3cxSBa9aTh+PotdZE65sCmJjE6CrpdL93
b3QSSu6/Nob0QekUi+3eybWB5RXfDI5qmQHFFS4nNfUnfgoqMTJtxyU378gU7+bT
JG+DXwRojjDn4uSAxIukGhUXwFyiFlVpe7UbmOISNQq5HIk6mWsnNha8kyEN0+yh
uMh7qrz4vJtCPKsNkx3LAPIZFUwJ0V1NSiSKGG4RcDf8f1YoTxefMoDmdxgeen6U
Q1slrrisPXwGiIm5CwyRu7Bc6ecUEQA1PkcpL2wdJu2mJbXIl9EzIYGYNXv+/2Sm
7OLBfHAxIidWgRs5MQsm9YRNamk6s4ypS/vn2rrunrwFgB1+Ak4EPXdJzCcRSK6F
NLRSwqOWi+GT3gVUx+hMHyMysd39i26MbF3pcrsoHjwPVF9uXakdyCQOb1FsPjkP
tpn1hR9xlMxs20LvJyGEx5cMCe5I5oTJoie20eiUCK5O0vp5wCaCDZbNMEGaoNsx
P4lziNSPrsPwf9w9IJqvbD3plpSF0Ad8zEW+DxH1kwNXBkGY2aA=
=mhxM
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
