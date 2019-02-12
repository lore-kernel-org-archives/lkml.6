Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D269C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E38222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbfBLUE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:04:26 -0500
Received: from anholt.net ([50.246.234.109]:59502 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfBLUE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:04:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B910810A2C5A;
        Tue, 12 Feb 2019 12:04:25 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hSX8wK-JOAr5; Tue, 12 Feb 2019 12:04:24 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id BE7A210A2C55;
        Tue, 12 Feb 2019 12:04:24 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 609BE2FE464C; Tue, 12 Feb 2019 12:04:24 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Fix BO stats accounting for dma-buf-imported buffers.
In-Reply-To: <20190207232717.GG23159@phenom.ffwll.local>
References: <20190207232613.24981-1-eric@anholt.net> <20190207232717.GG23159@phenom.ffwll.local>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Tue, 12 Feb 2019 12:04:24 -0800
Message-ID: <87h8d8srhz.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Daniel Vetter <daniel@ffwll.ch> writes:

> On Thu, Feb 07, 2019 at 03:26:13PM -0800, Eric Anholt wrote:
>> We always decrement at GEM free, so make sure we increment at GEM
>> creation for dma-bufs.
>
> Indeed. Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Merged to drm-misc-next.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxjJsgACgkQtdYpNtH8
nuhOBg/+ODtlPac7bMvj2GAry4+1WvK9v2hVy5r3JJGVxoxmD7ch75Uw6W6WcND+
EaT5h3h0/8L5g0rbmqIKacUyb22tQq1dExmQ/dTvnUeFIqg6EaOmJDY9cQ7pjL1b
rmJPhrgY3yVWFvKPDMXZbxUioatT0QUICVLAuQOQGcHJXI4PZA8z4QQa7qkSb047
EIBaBWWbAEWbSZL0Qayau258b7b0BnCf7rsZsUSj0LpsH5jyMDg6ykqEZO1WwNa8
mS0RTLZExYE+0qoo9CaW2pcRcI1AHrzZFkYcXf+BTTASheNWwxSmkwZ39oCc65L7
eoMa7ZHDLW+JmV39Hhvv6l42LtSxjVx4wxBq6WgT911UoTNwRYWVal0+l2K1A3oH
4Uut9mbPJswBDszmnPH83r+X1QiVQuGe+2m2cj/dyPBE2Ga9eBhBtXJ1MhAO3dKb
vv0YcM5E1OetTG+dIJ8EtsAurz/vAW8ET0Amn5aLjStMdHRRCe0P3dgGiF//k2P+
J9F62e02Tc7hMkJDYCgyZ9V/1fZVmzS76XeZtjGAn2j5DoV1hShXTPnJPJkhhakG
QEVd+bWnucIWIuXiUIhhCaa27um96sE2qlitMK8TQ+di9wZy5xaAdEk9eM641lvs
0/7EMspHPDQWKtGrdQnLf1lvq5qY1rh7GVStEUnBG8q4aeCWqB0=
=fahR
-----END PGP SIGNATURE-----
--=-=-=--
