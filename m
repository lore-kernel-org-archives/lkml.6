Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 14F67C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9D9208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wUcEe4ZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9D9208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935299AbeFMKqT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935150AbeFMKqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:46:16 -0400
Received: from mail.kernel.org (dyndsl-037-138-190-192.ewe-ip-backbone.de [37.138.190.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C1CE208AF;
        Wed, 13 Jun 2018 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528886775;
        bh=MiS06RXhRqd2+YKA+6JqOhDg8XPZSXaG7f6tHUrkNL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wUcEe4ZIWSDaVt2E1/YZE/ZMiNQPotbaLMeMqLyJhFb69VHaJT6G6jCOEmnD70Q8G
         srZGKkEsDB5f+RzcIoz+niz0V6f4RLNbceKSPeJx6uSCgdK1Wm1SlxcaqqV11JruD8
         BZWCpeEfAAXOUD3wfKq/cCTKBUEB0chwgdGkAMmw=
Date:   Wed, 13 Jun 2018 12:46:11 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Rhyland Klein <rklein@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>,
        Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 1/2] power: supply: sbs-battery: don't assume
 MANUFACTURER_DATA formats
Message-ID: <20180613104611.2jnwj5osn4ig5h5f@earth.universe>
References: <20180612202042.107603-1-briannorris@chromium.org>
 <CA+ASDXMuohDxvAXdnea8xAZyq6Nn4JThQFGTPPtxTzvf-2dJ0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g5i3aqss667oh6ng"
Content-Disposition: inline
In-Reply-To: <CA+ASDXMuohDxvAXdnea8xAZyq6Nn4JThQFGTPPtxTzvf-2dJ0Q@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g5i3aqss667oh6ng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Brian,

On Tue, Jun 12, 2018 at 01:23:25PM -0700, Brian Norris wrote:
> Eek, sorry this series should have subjects "[PATCH v5 X/2] ...". I
> can resend if really needed, but hopefully by now this is ready to
> go...

No need to resend. Patches look fine to me, but we are currently
in the merge window. I will queue them once 4.18-rc1 has been
tagged and linux-next is open for 4.19 content.

-- Sebastian

--g5i3aqss667oh6ng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsg9e0ACgkQ2O7X88g7
+pqXfA//Xv56C2rA/oAfduw9GRDEy/RCMu3h1z3p/d1+ECfF08VUz+grCAL5Uq1G
5liXLAYsKWuBxepynGqyuCDgTC8gpy3ZvqJ8xX4aapZHE3AT3/aW+yMxVjzBGkXP
XRmqaVPt/6pEFGxzIGe/ejJewSXVdWkGbGRTCls2ysW9jc5IFOk2zo2mgWjdN5q7
vuMtiF9L2RYDmN9nIk3Z7tkST66RFPjir24B4iKQSxkiIarJ2jjH5RH1qgcUPyZZ
yTGYV7Ry04pgT6Zil23AHs6kVUFD0T5y5CkS3UZxzl+1QnfmpXTWVKip6C8m2h5U
uJK0vWJkp69ebqUyk3krISomOgsZjjVlfU6bKw4Q0GU+3sxJaG9TxNDqMJuJpoH3
2UtTw1Fc/3HOEGzulPMD7VWDX8pRL+kky0pA4RZxTb/OfhoHaC78c0nPBMX9xiSp
HjPThUmLv9FTt3QxxgsVTqod3GPB6JpuqsR8NGIuOfq1xPCh1gjjK6/uuqjTg6Bz
y2PkNIzESLuL46U+ZdMzTgsbHxcGQSCvWSGe4f51kvYDrIgIi98P6nqiQ89Xyjeq
4hSF2lspLSr1sfBGx5ZzBJJkUlsQ8lElX+SD+tQZemVvD6HtjW+PGbVk8q/kJifB
Z8avoMtjDMkpaJxqgvM3FiFV9DoYYgTDbcG4sF/c7hrbmg+17+E=
=NLMc
-----END PGP SIGNATURE-----

--g5i3aqss667oh6ng--
