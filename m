Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E475BECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A9B21530
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A9B21530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeIZWkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:40:47 -0400
Received: from sauhun.de ([88.99.104.3]:54716 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728503AbeIZWkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:40:47 -0400
Received: from localhost (i577A6E88.versanet.de [87.122.110.136])
        by pokefinder.org (Postfix) with ESMTPSA id 70CD62C0114;
        Wed, 26 Sep 2018 18:27:01 +0200 (CEST)
Date:   Wed, 26 Sep 2018 18:27:01 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     linux-aspeed@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: Re: [RFC PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: Add
 'idle-wait-timeout-ms' setting
Message-ID: <20180926162701.GB2736@kunai>
References: <20180910214519.14126-1-jae.hyun.yoo@linux.intel.com>
 <20180910214519.14126-2-jae.hyun.yoo@linux.intel.com>
 <a81a6092-a9d0-78d5-3596-cddc5d6a0713@linux.intel.com>
 <20180924215850.GD18592@kunai>
 <2c8563fd-0641-5237-0026-f559c480ad91@linux.intel.com>
 <20180925082717.GB2270@kunai>
 <7b4e5715-3a87-8f77-8d0d-4647f02c87a8@linux.intel.com>
 <f20a2e1d-e1db-1e63-3df8-ad650b931f7d@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <f20a2e1d-e1db-1e63-3df8-ad650b931f7d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Should I use timeout in struct i2c_adapter instead just like i2c-mpc
> does?

I would accept that.


--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlurs1UACgkQFA3kzBSg
KbYdWRAAgd9KqRsqZO/I6SWF9Y1Q7nfCO2fz5OLKF1sR0SW+vtOk66U+HVPJcknP
hHny/DCujDrLMMnhjfCwNDm4JYqRepAJnM7cCUgMlcHayKCX4Xc7uQQK884YuxJ0
URDnuunW27j16EEnVoj0MYjrhLHMFRxLiqkO4PuNYLv/ivAb8jPEBbzzknDP447V
CWv6wlzcRgML1DUAS9H1bVmEydKlXsliQm0614zu6gRGOMZrHnTJwoNirUPEXTpD
R3JY4p5AHXaw6t6haEdsSDlj+vQsMGGnL1+QIr51vMKSY++rHb+Vt+CWGA6yutkK
NIPEAuEN2z0jSWtO3TFPpzh9cwy8Y4Vn3/2/Qme3MTh0+URZlyIe+ZjC0tug/GTW
L4T7oV6Qw3F0RLkX/wI4vf21IRYry2yd1qePnDFAu5NtqipRpMc8Mx5m86VFoCQD
RCx5sNxD9qGI2yfqZk2sqly/wOssU8FSMiZPdOvwqENcaV0bdMrTGrgqo/FOUtsn
gB6xdN3SNTVhaTHo3sLdou+7g+aZdZJKJjUQQXxhR26JKLrkxSc4LHiaEmM2Dv/k
gJpx4VQIjOPAKHVz2DDanSOXDqFiVxazUajSmzvXXDfE9Roys41vDj7bZ4+ikxJy
5VSac74TGdHLfTWhKWZ67HZPT0JcxgdOlLjtaVHZeisOI27BAmw=
=gHIN
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
