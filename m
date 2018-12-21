Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B197FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2A421977
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404488AbeLUSut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:50:49 -0500
Received: from sauhun.de ([88.99.104.3]:45294 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730799AbeLUSut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:50:49 -0500
Received: from localhost (p54B334FA.dip0.t-ipconnect.de [84.179.52.250])
        by pokefinder.org (Postfix) with ESMTPSA id 889542E3542;
        Fri, 21 Dec 2018 19:50:46 +0100 (CET)
Date:   Fri, 21 Dec 2018 19:50:46 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Message-ID: <20181221185045.5lw3d4y3znvfdlj3@ninjato>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
 <20181219172250.ytronxeq2yc4vp4r@wunner.de>
 <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
 <20181219223341.GA998@kunai>
 <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
 <20181221145022.umsugdwadw5a5ag6@ninjato>
 <c1518533-ccc0-1a82-31b4-959682fb9b9e@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xapu6r7mgpyebcwy"
Content-Disposition: inline
In-Reply-To: <c1518533-ccc0-1a82-31b4-959682fb9b9e@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xapu6r7mgpyebcwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

> Yes, I agree with that analysis. All mux actions eventually end up with

Good!

> an __i2c_transfer() call on the relevant root adapter. Hmm, but not *all*
> calls. How about SMBus adapters? Should there not be a similar WARN_ON
> in __i2c_smbus_xfer?

Yes, there should. Yeah, that's what I like about our way of hacking; I
somewhen thought to not forget about SMBus, nevertheless forgot about it
again, and then there is someone else to remind me \o/

Thanks,

   Wolfram


--xapu6r7mgpyebcwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwdNgEACgkQFA3kzBSg
KbaRnA/+Kh2Zw+bQP/rVQJRA+DlW0Pfer3ht2Ot+W456V0UD1pV8LLILytqqit+s
EUNkI7E0DqTTY0SPmj8UYTWOShV+a+jUpbXLxs9A+KAE2oa11k8Ktyls6DIDv5Xa
h47CLMIto1P25c568n/j7aT5jo//UqV+7RsSzkrceUgc7qM4M/8s9GD8zRG068I3
RvieQkk8pUFYaTC8H9jMu7Yz15bP/L7cv5xK1mS1tgiSnFUnYDtWBSl04aCtpbVL
g3cGmYZZbo1672l1Aj1UYbhNHpI99buQQgaguPgYycYbOC99I4XjlypKoc0AfltX
JQeJayLzlc5Yl2ljPkwFrRzMLCIvKgX29QFrhdw9qwNm8uTqLtCkqMKpoGfRBg1X
RAcBzpOBZ47nfqt7YFKKvf4mhKs7OaAVcjkk2xMTja0lzGvVE6Zi+MEqwoLIS8NA
8rXsfcREPRJ2kV6YhZCl2/P7rhlf7mgQjVuCE7HTTC3hBp2EjgkmNk0JunJXOHfo
Ci6pcMeZZHIajHAbwZRsS6H7uJHV7ygIWrj0VTD03vaHAQ7+j6uNEmxndrDlN/KX
orGXFxj4/Ot7xmUSIS/z7IxMrYVIO3aT/BgZuvlevYpud8l/6BnCOKHelktEjGOg
qz4XWcEKtxc0Z1rbkBqSU12YDXwNKe011FBjwWwK7Lm5azy2b2o=
=6tUM
-----END PGP SIGNATURE-----

--xapu6r7mgpyebcwy--
