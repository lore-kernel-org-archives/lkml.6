Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D894ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFED21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFED21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJRQD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:03:26 -0400
Received: from sauhun.de ([88.99.104.3]:44590 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbeJRQD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:03:26 -0400
Received: from localhost (p54B337AA.dip0.t-ipconnect.de [84.179.55.170])
        by pokefinder.org (Postfix) with ESMTPSA id 3F8FA2C78BA;
        Thu, 18 Oct 2018 10:03:36 +0200 (CEST)
Date:   Thu, 18 Oct 2018 10:03:35 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] i2c: designware: Cleanup bus lock handling
Message-ID: <20181018080335.GD882@kunai>
References: <20181011142911.13750-1-hdegoede@redhat.com>
 <20181011142911.13750-4-hdegoede@redhat.com>
 <47ea8d77-83eb-8f13-720c-6dd11fb70428@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline
In-Reply-To: <47ea8d77-83eb-8f13-720c-6dd11fb70428@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 05:15:47PM +0300, Jarkko Nikula wrote:
> On 10/11/2018 05:29 PM, Hans de Goede wrote:
> > Now that most of the special Bay- / Cherry-Trail bus lock handling has
> > been moved to the iosf_mbi code we can simplify the remaining code a bi=
t.
> >=20
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >   drivers/i2c/busses/i2c-designware-baytrail.c | 18 ++----------------
> >   drivers/i2c/busses/i2c-designware-common.c   |  4 ++--
> >   drivers/i2c/busses/i2c-designware-core.h     |  9 ++-------
> >   drivers/i2c/busses/i2c-designware-platdrv.c  |  2 --
> >   4 files changed, 6 insertions(+), 27 deletions(-)
> >=20
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvIPlcACgkQFA3kzBSg
KbZbxA/+L/iMKMkRRkbJNp7Lvf5Bfp1CuWuC9x8IisQKY/jHDGxZIVlyjAdzOq/1
2fGtfo9ke5Aq2M+3UO/bWHUUplis5Svtvl2uE6b/Oa2KWuJvTAdTHz2vIiKAah60
eRlFcyJFaScPL5xQlETxcmQai1vjsennOuCe6Jsv1eNuKIttlYD1qZxIbQO/8kAJ
e8q7DdYR1FcSnwKMiqBoDOE9O/EKVtf7K60luGDFX4XeGTGlsHwRvjEKAchLum+i
ScGFNqVAQzCKPYtoWAJcwCJStUd6ZzR8UsqsZ6gjN+uEKh9SK7RyIGFJgfqD/Uj7
H9SY96lczgz3iHcy3jRnya1aFpIgDBCpbuWG5RK2pITNTxNgXZWwGIJ0WuH2wYLR
75SMxnZ+TxiLpXNHqhpR1CAN8f/E3I+Dneb9/4c4+M7MQFr9ap6rKUxHjRvoypOp
ixzNSVDCnpAIIk6xeKXoDWqzNOjYSHtqeswoXOEPH1YerDRQsclgQITtN0tW9HlZ
DBrgqTP2XFaNKr4ke4RM6GcaKHBKevt1TqPdPrz7iyWZubAg4J1X85VyJxKOZNax
YkePZUzNfCk6c3B+hYVtdd7b/G/tXKS4ZzfVqQ9W/spAtvsU7frSufJAizSE9JZK
i6oEZCHLILeNlBe8NmZf+02vIqcvHZVO5zFX+tMbnGmzBNoBTn4=
=6mQJ
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--
