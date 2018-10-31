Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DF4ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180902080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180902080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeKACPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:15:17 -0400
Received: from anholt.net ([50.246.234.109]:50634 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbeKACPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:15:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A1CA910A1311;
        Wed, 31 Oct 2018 10:16:22 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 4BudUhdBenj3; Wed, 31 Oct 2018 10:16:21 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8DE2210A01D5;
        Wed, 31 Oct 2018 10:16:21 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 2CD392FE1B8F; Wed, 31 Oct 2018 10:16:21 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] firmware: raspberrypi: Define timeout for transactions
In-Reply-To: <1540922921-3653-1-git-send-email-stefan.wahren@i2se.com>
References: <1540922921-3653-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 31 Oct 2018 10:16:20 -0700
Message-ID: <87k1lyghp7.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> We should never assume to get a reply from the firmware otherwise
> the call could block forever and the user don't get informed. So
> define a timeout of 1 sec and print a stacktrace once in the unlikely
> case the timeout expired.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvZ42QACgkQtdYpNtH8
nuiipxAAkT5oj/Elq3MYDjpnl0EfyStwl67HVQ2iZpazN5mZ25K7VA/fvcvm268T
b+ZoOoUWMa1iAcOG/zAt5SftWRlzrYvi2ieSZtYVzPsjpIxDfvLhgvX0s8SMM03s
iVKbKAac0K0LZg71o0x1vOwcV0kh+jB4fHbPaQr1Mk0pZioop2v++BRmKPmNA7Av
o4u8ylWiUjW7svbIStc2pUHn1sv0+lYktRdGd7FrrXNcdZ93sQN4nM4q8nVtRXGU
g80MYaBVy9+nGp2G4xzYbRCidKGukFhHMA2aG782wlypPibX2ZoA3ldQrB6CiNls
HrHVGC1h6rsUkPVgGG+uI5mAK4P2qb8IoH4To7FkhPXaiQ5fRiCu1T5PE7J9mN8h
Vj/Ksd+n0sRwoIGc01y1ASeG7XgEiFI0vLSt28w3AbMQ/svGSdQwQZaOGPpBkdtL
+j8/9DTZzIpw3Jp6DOSXVa00yT4Bt/RJWTRsgJE+T2eikIIRbKManT8huIcjbOIh
mWR3wEwAsWYACvcf9C8QjN+W621Wj/fAMbDlCucBJIPTn6vUz5+wT2MdEPebkFTr
Xs5LlmVP0D7dDam3+GI++TbdPSzV7PHvZI0SS7LGdFWTlVdpY9eqib7qspGlCCxT
oFrm+17IZP+fQucBzcnTWcZJQ8JmS9zkf/hxfedzX4YtkwMFFHQ=
=X1L9
-----END PGP SIGNATURE-----
--=-=-=--
