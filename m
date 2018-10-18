Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED10BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0F121476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0F121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJRPhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:37:05 -0400
Received: from sauhun.de ([88.99.104.3]:44438 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeJRPhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:37:05 -0400
Received: from localhost (p54B337AA.dip0.t-ipconnect.de [84.179.55.170])
        by pokefinder.org (Postfix) with ESMTPSA id 0E2402C78BA;
        Thu, 18 Oct 2018 09:37:21 +0200 (CEST)
Date:   Thu, 18 Oct 2018 09:37:20 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-i2c@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] i2c: designware: Cleanup bus lock handling
Message-ID: <20181018073720.GC882@kunai>
References: <20180923144510.4564-1-hdegoede@redhat.com>
 <20180923144510.4564-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <20180923144510.4564-4-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 23, 2018 at 04:45:10PM +0200, Hans de Goede wrote:
> Now that most of the special Bay- / Cherry-Trail bus lock handling has
> been moved to the iosf_mbi code we can simplify the remaining code a bit.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvIOCkACgkQFA3kzBSg
KbaetA/+LRrivW0GvsZp63yTkQVZPYV9czDnMWMbL18Xl26imiq/IbidehIBYZJp
iFI41dphMeijZYFqZhhnU1a0m3IVhYX/0IAafsGh/TuwC8Ytgsq3FyzK0pAqXs/Z
bekD1llGOAv6zVxojIVQgR0hjhdqJLPaM15ePT30nX+FPeFb/8GhbV/OeCWWXdpl
MZn4u2bISHTSIfZLQoIwUwJKVWFq0Uk7d+cKNRJzuGD8dhK+yVD5fxuu5kgVIHva
LWd4yvlO9Cy8YBXCgoK96qiwvYBZ5YzxkTlrJs55RhTRomj4AJdtvonMyX3WxElV
Kb2ydsEVGMdsk4gPA6+fGsCoZQoHISOhc+VQqhgzy17fQBJb6MxWy5I7lDjGe6Bb
ECiNg0+MRiX7Z1BKL6I9qXtFu/u1tSx21BcJql6VcM3JZpRAanx6MGqssEE6JKez
7wBAh1SmwuiHL+pY9rwfjtuC4wiPTCkRTvXMM9G2ot9nS1Bf9ODdmMQtuLzb0gjD
B7T9a2VANhhhwY7Jm00ts8imKQOVNoo2A5pXo5eMurpsBlzpwk2T7AoTu3zx7suF
u9f3u2RW781tm/dOxjCRk+zhKH/5T2KzB8uhEKC3GZq4WdABWhTBLafCkggAFzyq
c9UpuKhxDFlZ6IfbBE9Ohw8VAt4Km55ZX8fVs26rQJhEge9Sozo=
=jUUZ
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
