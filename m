Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962C3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DAD20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549027246;
	bh=i17ZV6s+GeNZpWJ38Uc76AWq30RuRZRu+esau+7fuD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=DpvULtb+oH2NJlQQuom2mc0A6rQ4WksHYg1MRAvdHtui9vXAvgU1DFbtEvqqLcCst
	 exZ/LCCfaM/+9+AoerQFnJexVhr1zAJHAFxhSa5cusHsxOXJDjKk4zGtapBfGhZG+V
	 MG8wMj39MOBElfIUuz+l+Jcjs09UvB/IPd4ai+rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfBANUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:20:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:3630 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfBANUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:20:44 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 05:20:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,548,1539673200"; 
   d="asc'?scan'208";a="123164770"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2019 05:20:39 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     iommu@lists.linux-foundation.org
Subject: Re: [PATCH 13/18] fotg210-udc: pass struct device to DMA API functions
In-Reply-To: <20190201084801.10983-14-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-14-hch@lst.de>
Date:   Fri, 01 Feb 2019 15:20:35 +0200
Message-ID: <87a7jfodb0.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@lst.de> writes:

> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

In case you're taking the entire series:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxUR6MACgkQzL64meEa
mQZcdw/+IrXhj2e5ZoNBjEAFCIYS3Ad0nXXzb9LocZ8HVA2Ill1N+x0u9dTCQj2A
d08tzuiwdLv0QP2YIpl9AVm+bmb0Fknee+ENoqjKhjbArhv1M2QY2XTdV3QZT1IN
CDY3zD0IN4mHHg+4rYyOHVXLu/vX2Yoh8vL9LFHJevlUcgPE0HPiwBsP0cNocYxv
5u+mdcIgNG5M352Yau0cZ+q5QKi0kycwKWdZsJL3X0cqAK8iS1IMwWGd1/hf6KnB
UrCRw/+NbCrv0SapHXrw+wJN3l/F/5HMTdh19pqq5yO1pRJOu2fcsv+/CKgyzYkT
lRsvuN0FUHj/7sMBK3f8BnKU0hQhyejVKQr0rbZ60rQfO/Dram9SVRFk97B/81xM
iwcMQhBD5Aw1gryOuoQx26knqH59lIjq0G7tf0j8xsQJZy2WqXJSrx6nBJRXsCzn
8qqdOKpK4uCkOrLCe+7yuYHaIicput48fxOjdtgnSFpKqlRNXEnMXYKGFrYmodFu
KVRdLd/muq/dGAfKgLwzCYVlHNvcsAs+Q2vpJ4IQuG9AYG5RDr9z3X4oQbFJccUd
YM7+vhctcxYzE+WqO96dq+mVcGl8hyidqRgpZ6BNDl34FO3W3ZrZNFQvwEkz0cfX
RfAUjYGlYlkDLcCpu3WrzurP1ByBfL8HfMMpqW/of9Z+nOb9rLQ=
=fqaM
-----END PGP SIGNATURE-----
--=-=-=--
