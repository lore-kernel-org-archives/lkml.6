Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13319C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D198620870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D198620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbeLKU3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:29:34 -0500
Received: from sauhun.de ([88.99.104.3]:45544 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLKU3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:29:34 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id 290384C0E90;
        Tue, 11 Dec 2018 21:29:32 +0100 (CET)
Date:   Tue, 11 Dec 2018 21:29:31 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     qii.wang@mediatek.com
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, ryder.lee@mediatek.com
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20181211202931.xav4gzi7rzh2scgx@ninjato>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qookkrqmaew3bmbg"
Content-Disposition: inline
In-Reply-To: <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qookkrqmaew3bmbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +  - ch-offset: base reg offset for multi-user.

What is "multi-user"? Why can't you add this offset to the reg-property
directly?

> +  - mediatek,share-i3c: i3c controller can share i2c function.

Please explain in more detail? Is this an I3C controller?


--qookkrqmaew3bmbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQHisACgkQFA3kzBSg
Kba9lA//XQcp5LIyZqRaesg1uwwq1/DUnhfyqYK9Hyq5mqOGd+wXFZbvCUWicwwk
/N7FXIICvbEgzyhzItu4d2m5blloyJiA4rVxPAYo8MihORADU0Eu9qJLwI6XUGUH
kLe8/GrqWqg8DkGw4xNx7q+QpO52y/Fx7Lit6K2FmCAuMUTU8hkI05Mmm+eFaYGd
/Wxq2KZTaeDQsT0qLpRXRDi6hVMWamhgfNHO5WPcy32rHAMJ17e6iFOQaOv5FaaZ
dQmTrp5Wn1mRaKrLKuTACkz5XUqIPNxV/w5ZHWRFyTbEr5zKXdcdcYIPYjNd/bzg
vkEJR5Ith3YlmjU7YfVPyUBm0y7VGjeDXr+KL4LoVcUD/kbZUT+/GGTmAL5PZvP1
qatQcUvPiR62LTEi2nZaMjNFwg+9k9BC5WjARRzSi3Ev/2gHA7gwcCgnJEBmwp89
TaysiINGGxzRzfYnn+wL2ja3lYyJr7iYie9JAqzLHM8Q120KgavZEHyHJCWdOvX8
sMVcLh6ld03+J8iFtiNJemPiRl4jFMkg0rQs11YeAZJu/H0rVdU2Bvbk1yJ2QaaK
a22CduYq10DwPPwCrPh4GMGK3Ohi+md5XcUgDTnnc/JVD+hOHSOBtYOHkNp/nYBN
fnM1q9BoJlE+irfzbAqx64BX+a6rrg5KeAWy+f21+Z7xwCW6gII=
=ZORW
-----END PGP SIGNATURE-----

--qookkrqmaew3bmbg--
