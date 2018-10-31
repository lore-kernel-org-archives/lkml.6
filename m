Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E517C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212ED20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212ED20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbeKAIfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:35:14 -0400
Received: from sauhun.de ([88.99.104.3]:59788 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbeKAIfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:35:13 -0400
Received: from localhost (unknown [87.114.85.207])
        by pokefinder.org (Postfix) with ESMTPSA id 1C6762E35EA;
        Thu,  1 Nov 2018 00:34:50 +0100 (CET)
Date:   Wed, 31 Oct 2018 23:34:50 +0000
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] i2c: Remove unnecessary call to irq_find_mapping
Message-ID: <20181031233449.GA8321@kunai>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 09:59:57AM +0100, Charles Keepax wrote:
> irq_create_mapping calls irq_find_mapping internally and will use the
> found mapping if one exists, so there is no need to manually call this
> from i2c_smbus_host_notify_to_irq.
>=20
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Applied to for-current, thanks!


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvaPBUACgkQFA3kzBSg
KbYfxBAAtKkdgSH7diyovqtOOPfMLlgAYE2m7svqntlXaDoBV3uUZJZJX7h7EgfO
MqFupkK70VWjOYO6hMl/Jsk5NPtjOcvQb0TLQFXOAo+KDIK3P0iFuWl0o51CZKJq
WFgXea/IublAzqCBFSsceZp5BX21/41f9syvXCBFwR7e49+LNEObVBsYjhOqMiof
HvxcQ5+EzMZLg3IRSN/0qx/HLGTH/AcqTnHCBWn0elt87msk+hpDAJ19tgpdZ5Ho
BaCA1Jx3wUxrdhJwCfgvYNDXw6M+5FJ7pQVUmcjiJmIp4mp81vEkXfGO/KgLR/hz
dVCPP2eBw+AEGoYfsFixFU/eiG4/zyhH4F91Ykz+2c7qwOm/rMNThRaxvTD2Q9wk
o60anL3+UgLtcrO5U/VuYryKfEONlGYtK2dYH8ccKyvN0l/JexyvdG7O2bjU5KWX
/3Ywa5KoFCJRurYkHN2+19505H/u4XiMFQonNE6kTWaLJi7xemMKb5bpNiAKwayz
L+0Em7ZoD94H/xbh+L2grFZJTOOGNqf4hFF+epLg6eV3UnwySEmPLdcgGR6J3ygn
iisuoJnxIRUL1M87Q2vQmKZwCkWbqTkx5fY+NlQZ+jhJWAvDrMbYinIRC9Se9XLa
uy7jtlTGBfZbCwjVzCVn5QeSVcA6L3MoBNhyhVwnx4dBbdOuk5I=
=g1oi
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
