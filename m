Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4091FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11991222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfBLUEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:04:12 -0500
Received: from anholt.net ([50.246.234.109]:59482 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfBLUEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:04:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 2A05110A2C5A;
        Tue, 12 Feb 2019 12:04:11 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id xPJX9CKR5oG1; Tue, 12 Feb 2019 12:04:10 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 2E73B10A2C55;
        Tue, 12 Feb 2019 12:04:10 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 9EFE92FE464C; Tue, 12 Feb 2019 12:04:09 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Thomas Spurden <thomas.spurden@broadcom.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dave Emett <david.emett@broadcom.com>
Subject: Re: [PATCH 1/4] drm/v3d: Update top-level kerneldoc for the addition of TFU.
In-Reply-To: <CANFymN1Hp1a0U8A0MhYe0bL0y+0Bc-FXk8Ra6JFAf5QM7za4rg@mail.gmail.com>
References: <20190207201001.5730-1-eric@anholt.net> <CANFymN1Hp1a0U8A0MhYe0bL0y+0Bc-FXk8Ra6JFAf5QM7za4rg@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Tue, 12 Feb 2019 12:04:09 -0800
Message-ID: <87k1i4srie.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Thomas Spurden <thomas.spurden@broadcom.com> writes:

> On Thu, 7 Feb 2019 at 20:10, Eric Anholt <eric@anholt.net> wrote:
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>
> Reviewed-by: Thomas Spurden <thomas.spurden@broadcom.com>

Merged this one, will send out respins of the others.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxjJrkACgkQtdYpNtH8
nujvGBAAkJzDId+VfNCvf9It7j1lqFcLqkbVwfsb2MzEY/j2gzsA0MM0gHtMCjxY
IH3ZAdTbiO9xmaXncWUVTff9fsHhKueDxpVXhbGX3483rVznZWEM5W70QnB3ZXvE
UNaGlqsbwX4MHa+vUVEzYhc1VSH7A7ANPKJhG9bvfugjtBth5oRwROeAyC+A6bN3
IGyMPb/tGA8EI47wOIy4WNooIUA7bZ5E1Mq+gMvmnmMgYumqw+tDYOXkOI5dVHPd
T3ABfNLkZvbNoSpoMn3Q0tqHcVL+Crpa42+VxTtgm2y3wQ/YkAIkyRE5Dd9QZU1g
Y8o2pX96GspFg9OT2356ywp/YVI1raaOrrZ0qAqhMjY+qTKKuoorWe58TEHb/tB1
f6kuGFgeK0OchK5dvGSJW392pcHWM89a69NGFHHjXKUZzfRGpdglMFyJgVrLpFdp
1v9oRBM9mWv+XzelHF3In9fCQAz/7UkLILaaL126Hu2VrbL6t2Y1nxxUo9h47odD
LRng13mM5SQTqgsfEntavbgkmTb9z3Fd/oFSceAzzOdlR2Tka8i89Nke9QGA/EQR
hKGFHE3D2tf6BFPmz75RM4YX88fmG6Y9qJwk1jFc5DTg7tK/4GXjR2udZN8/oNJK
Yav7G+SbRC2HihguG2c5V+VDxU+Y9KhYS3JGsVXbTf2URhB7uWg=
=ZS/B
-----END PGP SIGNATURE-----
--=-=-=--
