Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED23C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FD32082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FD32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeK0Kri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:47:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:11040 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbeK0Krh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:47:37 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 15:51:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,284,1539673200"; 
   d="asc'?scan'208";a="111824729"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by orsmga001.jf.intel.com with ESMTP; 26 Nov 2018 15:51:46 -0800
Message-ID: <937675447ad1ec2665d0b6f70390d498a01255d0.camel@intel.com>
Subject: Re: [PATCH net] ixgbe: recognize 1000BaseLX SFP modules as 1Gbps
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Josh Elsasser <jelsasser@appneta.com>,
        =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc:     intel-wired-lan@lists.osuosl.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Nov 2018 15:52:02 -0800
In-Reply-To: <40FD0CE5-973C-4A7F-91BD-66C1A1699223@appneta.com>
References: <20181124205801.67828-1-jelsasser@appneta.com>
         <87efb92z5w.fsf@miraculix.mork.no>
         <40FD0CE5-973C-4A7F-91BD-66C1A1699223@appneta.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Sq327HYvCc+FhCih/Wu9"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Sq327HYvCc+FhCih/Wu9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-11-26 at 09:54 -0800, Josh Elsasser wrote:
> Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
>=20
> > Not that it matters much I guess, but I think LX SFPs were
> > unsupported
> > at that time. The LX support appears to have been added under the
> > radar
> > while refactoring ixgbe_setup_sfp_modules_X550em in commit
> > e23f33367882
> > ("ixgbe: Fix 1G and 10G link stability for X550EM_x SFP+")
>=20
> Looks like you=E2=80=99re right. Want me to respin with an additional =E2=
=80=9CFixes=E2=80=9D
> tag?

No need to re-spin the patch, just reply with the additional "Fixes"
tag and if patchwork does not pick it up, I will add it to the patch I
have in my tree for validation and review.

--=-Sq327HYvCc+FhCih/Wu9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlv8hyIACgkQ5W/vlVpL
7c63wg/9ENThXjxgzUHWxx/p8buc/XetXduYBbn28m2dwx7TON1XvEAvh7YyJtIc
aZBs2bDNr8Wx3YnUAvvq7MMi6FVfsEwfEJ1sBSTY+snPKj/v6vhlm+FxeXdbgrlL
9RriiRNlqssMhGBXZsLleHWAKrS4RArnD8woJ/Vk4L/iWtiGIrHA92kqSJfXfu0T
iQlUs1wybSs/ZlCnotSZJgzGD9BmmOX5J+Qx9mMHl4nr4l8Lcvcb5sMFnnaTHmwr
euOMLpEgjKLMXssChJG8YGmUjJZSTArHyJULvpT8tuF6v9992g6zNNNyB4QJ9uVA
mvysdbc3VfajG/EkPVLBaiLxT95UzNvX3xTx1sAUY7T0gHk2pvbk+Avgo7j8/g75
q10/kBUaux6rQg3dwaPkR0SQ6+WmFRkYkNxlvaEvBDORCBlULS1hWEbyOS4c59s4
v1tJ422MUVwTu8SPmtX71HErvqko9QxV09XP7KBwYh7KI9+uxXPnA+apSN/fgkMq
wehAWIRuI1h6lOXVPYOevxjmadPE8+9DlZDCU1C86/c9ZAwlFxMjgWJEufJgPU3q
HrK5y8Cl3/QQQ9NjeA5DR/Dkrx/1wktOyKYGNqWW93Hs/Kb+Rvq5OTnWiJOE+sGN
NwY7j3yps/DHXoPk5bYc0b2xkeCYw5YocvFh8symI4WWZC2QFGQ=
=JJ/S
-----END PGP SIGNATURE-----

--=-Sq327HYvCc+FhCih/Wu9--

