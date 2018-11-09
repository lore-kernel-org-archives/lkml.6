Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F5AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9950420840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9950420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeKIL1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 06:27:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:17880 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbeKIL1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 06:27:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 17:49:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,481,1534834800"; 
   d="asc'?scan'208";a="106691275"
Received: from mkofke-mobl1.amr.corp.intel.com ([10.251.129.171])
  by orsmga001.jf.intel.com with ESMTP; 08 Nov 2018 17:49:33 -0800
Message-ID: <362e4f52443572ea1ff7cfa691a56a848bcdae67.camel@intel.com>
Subject: Re: [PATCH] e1000e: Change watchdog task to be delayed work
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 08 Nov 2018 17:49:32 -0800
In-Reply-To: <1541290645-25033-1-git-send-email-bobbyeshleman@gmail.com>
References: <1541290645-25033-1-git-send-email-bobbyeshleman@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-fmUk3QshV8/PXJ8S4H7k"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fmUk3QshV8/PXJ8S4H7k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-11-03 at 17:17 -0700, Robert Eshleman wrote:
> This completes a pending TODO to use queue_delayed_work() instead of
> schedule_work().
>=20
> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Dropping this patch due to the problems seen with it applied.

--=-fmUk3QshV8/PXJ8S4H7k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlvk56wACgkQ5W/vlVpL
7c7oHA/+MvRJnw5IvM32vnb/4FgzZdE7NHPW73hCdTydXqIDCmq9n0K5rqkfRSwJ
erzLVJihIMtWeTANkmercPQx3a6GqxelDRAPwVeXyINjtz/Yi2nDczykmfqBa2mC
cMu+3udPoX0KmZ+aYceSopeiHmoaVsqh/GGNtzOiHgl2BTGyOhgpgCCqO1Qp5iap
4nBTKr5imoATgGVVPIWhpNlc5RmukfRYoXWsflavjHhoCNm+tWpQPWmBAV+x4GVF
8a4ImB6HIl+x2vGjh+KXwdqlazHGN1THhWNC7wzfMv1sWbGfwuNWfN63SpAe8i3J
nqPhRcFwWax1JqvGA8Ek0o0n5EegqsNqSYIxAjVizeofWTanqz0IG9NyN+jPiQN4
tszc6RFTiooc88vopWkok+i3BQA4V2RKt/cmQkNZN+9FfAo1izd6WWKayl7bACny
AkPjRE7XVl7BPo9/+PAJvY9RocVEzWuBpsBcn7aRw+LONd41DjCOVoGWGT0qYHWK
ktXAhL47wB4sRPFp41i33zqeoHtJAWLA5CHr9vgOi+GXRijbavZv0WkwX0yRIcZr
IxgiA04OxwWhmakjoxz/OSvCOBwfJ6DTa1rwEv6oLWdXtfHX2NCSvUU9LLYpKdW1
d9h0YhlZTaJQPe1G8JI1iuUluaLAW0pomlCjle26676LVvOpU3U=
=GX5y
-----END PGP SIGNATURE-----

--=-fmUk3QshV8/PXJ8S4H7k--

