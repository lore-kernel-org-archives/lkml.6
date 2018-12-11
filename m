Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8EDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D1320672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D1320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeLKQUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:20:39 -0500
Received: from home.keithp.com ([63.227.221.253]:38558 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbeLKQUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:20:38 -0500
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2018 11:20:38 EST
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 205B63F25909;
        Tue, 11 Dec 2018 08:14:47 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ChaN0_6y6AGW; Tue, 11 Dec 2018 08:14:46 -0800 (PST)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
        by elaine.keithp.com (Postfix) with ESMTPSA id B4E6F3F25908;
        Tue, 11 Dec 2018 08:14:46 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
        id 9EF7F1582116; Tue, 11 Dec 2018 08:14:46 -0800 (PST)
From:   "Keith Packard" <keithp@keithp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 4.19 098/118] drm/lease: Send a distinct uevent
In-Reply-To: <20181211151648.232890582@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org> <20181211151648.232890582@linuxfoundation.org>
Date:   Tue, 11 Dec 2018 08:14:46 -0800
Message-ID: <87a7lcm45l.fsf@keithp.com>
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

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> 4.19-stable review patch.  If anyone has any objections, please let me
> know.

Acked-by: Keith Packard <keithp@keithp.com>

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAlwP4nYACgkQ2yIaaQAA
ABFb2BAAqXXcRD4tALJug3f/mHBuwyICTMR8YRidWHqI6h2aXCFGLtFnAaMR1NmM
z1QvN83a6CT7PkKFcLCBxqWdS103sUISTNpuYTVsTUSHBLbU8+2xKESZ28o6ZIm2
+DSOVA7VDBuQ9uGpf6Z5xHH44YtfGocsnStGvgFBVFXw4w5l7JmJlqS7gSDUclBI
v8N6e9+pMLF7re0Mi6xnDq/8ASweGJXMmzUThOBKxRbQ2WLUZPyqdGkaIKFg8EZl
6rqEJOeVUUNLEvNaZX3CariVZ12/ysy3ld1Ul/t+0sjbnPxiORijNwH4uZL9yUiC
CChCGsFSdDU7bWU8tzBT4Q4owbN1Dm3BkIu2bOqPc0u/rk5R3d41Jq76WxsoHjWZ
uH65Dlbum7w/Zan7uhYmLdH79z1pwP4xe/kJPeAjJgq2hT+SaRjXMW2z2L96kEdO
ODYG/q7Wu5va86kFVjUbUH/F1i2I32C7yY5B6X88QF8PR8drf2/LJLtAA48HXEWx
vbJ8OK7jqWy7qd21WUDWTlv9APxpHW+TG3wwx9X6fjxrKktEoT2srfDh2iY+cmXC
fW0ILSZdHxaEMMh/rmzoyGDwK+z6JjJrxUDzeKmxkXsA3BD5GZHm7Mah1jNH4r8q
8tCYmj2FdL+ADirlwJ+4Sh46nHYFZhllGSY4bHjXPf0GG2tw8O0=
=LICm
-----END PGP SIGNATURE-----
--=-=-=--
