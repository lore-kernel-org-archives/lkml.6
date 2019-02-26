Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5619EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3121521850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfBZQuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:50:04 -0500
Received: from sauhun.de ([88.99.104.3]:55430 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfBZQuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:50:04 -0500
Received: from localhost (p54B332DA.dip0.t-ipconnect.de [84.179.50.218])
        by pokefinder.org (Postfix) with ESMTPSA id 707654A0BD2;
        Tue, 26 Feb 2019 17:50:02 +0100 (CET)
Date:   Tue, 26 Feb 2019 17:50:02 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Elie Morisse <syniurge@gmail.com>
Cc:     linux-i2c@vger.kernel.org,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Shyam-sundar.S-k@amd.com, sandeep.singh@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Message-ID: <20190226165001.GD839@kunai>
References: <20190226161243.GA21539@syn-yoga530>
 <CAC_JBqrE_g-neObMMvsdAG4USDqgc+oqAs2y6WYRdrT6PBAiSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
In-Reply-To: <CAC_JBqrE_g-neObMMvsdAG4USDqgc+oqAs2y6WYRdrT6PBAiSQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Elie,

> My apologies for the time it took to apply those changes.

No worries. I am super happy that you are still around and willing to
continue the work!

> I will also start working on an alternate (v17?) version with only one
> module and replacing the platform driver by an ACPI lookup as
> requested by Bjorn Helgaas, unless Nehal clarifies how AMD plans to
> expand the platform driver.

Sounds really good to me.

Thanks,

   Wolfram

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlx1bjQACgkQFA3kzBSg
KbZOhQ/+NBQs5SOdpsf7Wt/SPhAygK8Mn6k7nlh7831boPsk1zJwaspsUSPEl/Gt
0al6+WnsyICu1Z7UXSzCJYJP2kEuyD8I6ld4kDM1dshsbbq9ld0csA6ZMMdsdfW4
7hkLA4R4vO4EIKXVvsuqM3SL31VbdwYM/HtMayS/vxGoxVji/uzWjgWZMhiI9QNT
PBjaGX2xUiMvNSTormh67w8P6FE0YpcEu8S6zx61C6Uyel2jLOY9J745tYvr2rs+
wjBTN1inpTjegHKXkocg6bii31oqPbd7l9rsjVnXt0pO0hC9TCS2eWO4pDh8rBRa
+P+GHTyBz4/mKaA9PG8MjptJ7OkTRaG7duYZmn7Et0RCVzHoeHexg5YLxkFkKqtP
BwjD3eaAnodNRqIZB02Sost+3G5z5PU0xNt2dgz+R6B5bZolbniJGqNondy7hd6a
5jzszB+pK+8PbgAuqwfG+BHErj7cXjBFco201vfIjP6FJggIwpuGKpqx11btigRl
HACMLD1f9yJK6PXMXNOLy3S9g2SksaMUljN0dznFuLlaOaDDlgK6dl+M6kkRROBa
PGMmktVvuWo+rT+0adZlEJotRs29JLuME5tj48pBsBhWe6KEykubErMLnelA0By9
Dkn4nIkRf2wQKSFYSR2o34RcJtWq3Q+/ML9uWuB52nrKMiJ3s6s=
=9O1G
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
