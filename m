Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7764AC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C0C20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="HTlTPhiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfBBGSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:18:42 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:47534 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfBBGSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K4d/74SfSGpowEs1tW9V6SK3qE76OJNqK+WcVbDexCk=; b=HTlTPhiVN+QQ0V8mMhQQ8YQVl
        QC/LZICoq51omWnOXBdkl+7V7pEDeWpEBgzHJVXMocKwwNeXesgyrutofQmMBAFN+YDHpC7JhvIiT
        DPm2rp7VV/UGy4Pgq43yobF2kbprkspDAQYxHFAA9E8Qo16liREz7LCksx2lWz63XTlTI=;
Received: from x2f7f150.dyn.telefonica.de ([2.247.241.80] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpodJ-0004UG-Lw; Sat, 02 Feb 2019 07:18:29 +0100
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpodG-0003Un-Sh; Sat, 02 Feb 2019 07:18:26 +0100
Date:   Sat, 2 Feb 2019 07:18:13 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tony@atomide.com, linux@armlinux.org.uk, khilman@kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Message-ID: <20190202071813.6234d8a6@kemnade.info>
In-Reply-To: <20190202055827.12956-1-andreas@kemnade.info>
References: <20190202055827.12956-1-andreas@kemnade.info>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/brBhm643RtDYZ=JIaq78N0f"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/brBhm643RtDYZ=JIaq78N0f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat,  2 Feb 2019 06:58:27 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> Enabling off mode was only reachable deeply hidden
> in the debugfs. As powersaving is an important feature,
> move the option out of its shady place.
> The debugfs file can still be used to override the default.

oops, this should be an rfc. So take it a bit with care.

Regards,
Andreas

--Sig_/brBhm643RtDYZ=JIaq78N0f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxVNiUACgkQl4jFM1s/
ye8pEw/+L6fsxsK4dvYlZo/y0VgLNEYvdJs2w2yZEVoWmygXS2stsavD/y6Ap3my
hSUIbVNJ438d5CFjQjgeSYhdhYHofuRDbZNuPv1JxKeIPvLlRanfL0OCmolOZJhA
VO2ptqAM571hmbrfuT5ejB/uAO/jFEMX3DJWskHJbW3aaUm1OfLplw7GKa+zK5+A
kc+vss0BHhFDJoSOI00qr9v1h57QHV6xsSqnBkWozbnPM5Cyqvzq2Kqx3Vjw/RkG
CAB+dbIrS3YUISMAbglnSSgoJQCHA3u+Kx3zoXxP/0MV6pYHqtn8knjW+lxRAqlr
u1SuN4zvWs60hb6vh6E9kmUrYzGm0ewLlbbNq3ICZC8EBxvPXPVZNoM+phgLIF9U
ixTLjN/5oDmJmCEblLXKsMhtzAwCj5iip1yxaMMmER9PNERSR9YLoAWOfDt/aycu
VqJK8FA4pmruclyHD6tgGaVVQ/WiGV5snp/IkvlD9iRQ5EPXxaF5pz+LVOIywyp/
Hxvs8d76qUhBgqqPxVQJy1gMO2uOUA2jOzeAWVWQe/FRJSt+wcdQbEHegiBO8E6a
A1SMOsFGiI06myc4US2YtfkN5UiKDUnNoZKNwgjNjzXaqI64O0H+MZDyI7IEBDSU
h6c9cgLJKuY9TNWo4X0tfGBiOhx2pqSS+94/IdXgPffEDORBB9c=
=USJC
-----END PGP SIGNATURE-----

--Sig_/brBhm643RtDYZ=JIaq78N0f--
