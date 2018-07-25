Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB612C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A2120843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A2120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbeGYL3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:29:14 -0400
Received: from sauhun.de ([88.99.104.3]:35034 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbeGYL3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:29:14 -0400
Received: from localhost (p54B338F8.dip0.t-ipconnect.de [84.179.56.248])
        by pokefinder.org (Postfix) with ESMTPSA id D4DEF63B74D;
        Wed, 25 Jul 2018 12:18:11 +0200 (CEST)
Date:   Wed, 25 Jul 2018 12:18:11 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tmio: remove unneeded variable in
 tmio_mmc_start_command()
Message-ID: <20180725101811.6yk2zwszxnglwbcx@ninjato>
References: <1532508374-28957-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nytesogl7eas6chi"
Content-Disposition: inline
In-Reply-To: <1532508374-28957-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nytesogl7eas6chi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2018 at 05:46:14PM +0900, Masahiro Yamada wrote:
> Pass TMIO_MASK_CMD to tmio_mmc_enable_mmc_irqs() directly,
> and remove the variable, irq_mask.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--nytesogl7eas6chi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltYTl8ACgkQFA3kzBSg
KbZXIA/+PT9xcJ/J1LK8EN5l3KaMInvK0UpkRkGfevWGmdDxE5SK/OmQZu276ZmQ
3hqZpbc6t5x0x7q5Knvk4c1RJGORvR9Mb34mJ+CeoL/dKbZNxNb/+H7WEe/bWe58
pkdMy7BGQSZ2N8nUPXvDKMFkGFIkQdztiQnGHO7H+DP7RyR8IYbjLtQaEKHUqX+/
5JB5G8souuInfPot8z/B2JVm0gRz9CXBhVxpPHK6XGgF2soeVWLTZvoucamunFbR
TA40iBe4A4PoOM+14hXyO1c1Ge4ZF3M7vmbIBpCOiWV24TEJKCacvkdkwnys3Rzn
Zj0KUEsRzRQ8hJE/fzYPWFnYO4zAvGXBY+vTxa4pyDg1+NfjAwpz5iehKlOug2sK
x+a1DN0s2cW0m4qEVy7PNok9QsjtA3YjTMzmqyDQ8IYjXHA2GtvPq35XLDs71/fc
bLvHsnKxvJ6CVKI6x3AnfmjL8WBjuGMXO0HVSjMra93YuzSItWUis4rHc73wefB6
dUOVXkhKclnum8k2XQRsg1CuMwLmZ0zw4T8so+Xrw4y0Xg5v5CmYwCyTNS8yB6gc
ATgQT0lO7GUlS6rTOppFHcgc2a41ah7nGZbmp9QaocGtspb3Llh1PS35pB9qR/Ip
U7t4UskTSjwgoEyztgTOZMfUjn2kNFzpEPF3qxwtGjcd+MFK+BA=
=sRwi
-----END PGP SIGNATURE-----

--nytesogl7eas6chi--
