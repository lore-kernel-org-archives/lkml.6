Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E797C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9E120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9E120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeLKVCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:02:02 -0500
Received: from sauhun.de ([88.99.104.3]:45872 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLKVCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:02:01 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id C412B4C0E8F;
        Tue, 11 Dec 2018 22:01:59 +0100 (CET)
Date:   Tue, 11 Dec 2018 22:01:59 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Elie Morisse <syniurge@gmail.com>
Cc:     linux-i2c@vger.kernel.org, helgaas@kernel.org,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com,
        sandeep.singh@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Message-ID: <20181211210159.to6okhbaqpymoax5@ninjato>
References: <20181209155602.GA8414@syn-yoga530>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wghqmh4wfsvnb5a7"
Content-Disposition: inline
In-Reply-To: <20181209155602.GA8414@syn-yoga530>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wghqmh4wfsvnb5a7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 12:56:02PM -0300, Elie Morisse wrote:
> MP2 controllers have two separate busses, so may accommodate up to two I2C
> adapters. Those adapters are listed in the ACPI namespace with the
> "AMDI0011" HID, and probed by a platform driver.
>=20
> Communication with the MP2 takes place through iomapped registers, or
> through DMA for more than 32 bytes transfers.
>=20
> This is major rework of the patch submitted by Nehal-bakulchandra Shah fr=
om
> AMD (https://patchwork.kernel.org/patch/10597369/).
>=20
> Most of the event handling of v3 was rewritten to make it work with more
> than one bus (e.g on Ryzen-based Lenovo Yoga 530), and this version
> contains many other improvements.
>=20
> Signed-off-by: Elie Morisse <syniurge@gmail.com>

Nehal Shah, are you happy with this driver from your side?


--wghqmh4wfsvnb5a7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQJcYACgkQFA3kzBSg
KbaJ+Q//ScA4q0wj/5RXmv1TpYikIecDUlVYiO2UEQfaWzmj7ktGBFbf7Fn/1NLd
gm1AizqoVxmG0fJwnUYE7fbFi0FKz8vAUl4R0tXk5rRsMD5S+nOIljAEx6M/TUT2
TzjAKOTvCidmlWlmM1864CN8ZgBzC2zm111xTfGpwcsSAKKZXnV5S/CHP8fhfeZe
zAtnopg/sy/QhSnhgLz8cqynO0rC47Py/+W/82g08BkTDr13DodJsQ2St34Y8teQ
g/Otphjo7OG8yqG8INZJCVQvB8U6Pa0AGoPyhMddUqMUdbKjuDRiJqkzi8IxwpMV
AnFQNcwWVUD9ppW9cX8vBOn8e5SaMrXyKHsRFkYWHYppPpenm3CCkpPqq/DqsJiZ
s35YgTnTZMqGyQMcWFGUVRE6nC1FUzTYBs8aFlm5Ku+FY9SKUUUanp/aJvTOH14T
jDs5UEt5n+wDNLTv/CYsWq1nXNU66ys88POCRKCy4xqCijpp9amvRKA4Nb5EdQji
TI6EUcZQWozqzdC19+B2n+59w1jyr0HVjq1J9X0ivitGmHrogKcVIgRQaUlY6fp3
s6RbLwmrZRS1n0xAn9B21OMwcVVZffNWQsmjfEHlPmNS018ClH5TnBVI8j9O9lFM
e0AnqpoO9VhtMW79UfhoswltAdHnSRL/UP1ENWa1zIvMMvAz8ik=
=6Pk7
-----END PGP SIGNATURE-----

--wghqmh4wfsvnb5a7--
