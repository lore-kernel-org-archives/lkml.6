Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbeBWOyh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:54:37 -0500
Received: from anholt.net ([50.246.234.109]:43304 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeBWOyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:54:35 -0500
From: Eric Anholt <eric@anholt.net>
To: Matheus Castello <matheus@castello.eng.br>, stefan.wahren@i2se.com
Cc: linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH] pinctrl: bc2835: Add brcm,level property
In-Reply-To: <1519321475-973-1-git-send-email-matheus@castello.eng.br>
References: <1519321475-973-1-git-send-email-matheus@castello.eng.br>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Fri, 23 Feb 2018 06:54:33 -0800
Message-ID: <87woz3lpsm.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Matheus Castello <matheus@castello.eng.br> writes:

> Property to set initial value of pin output buffer.

In the commit message, could you expand on the motivation for adding
this support?  Also, couldn't we reuse some existing
pinctrl-bindings.txt generic property?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqQKykACgkQtdYpNtH8
nui/ZBAAhZeVOdHZTta4X4nPMPin2RhXeHKGTXLw5n8WFPVmc6oPmm2qbrDCnm1n
PO6zVZPkg8iKJxKpQ9V4yjDMnqDwcYZI/jPbKKEOwhpkC07YFm3TsxDeKj/1U5Nn
h+wDJo/02PxIWBGx2VVrRAd3FJMrmiS93xdp581Oz9Cus8ndOCjd2kLK2dC6a/np
DYIjWesfXYEBFB4APRxwsz1SCeVamI556jHdV6iPozaO/Df4WkEFoZgknAQDa8JV
z4RsOyuostveJT3Zlfp8PnDkevHnersyZ1bnhrgTxmKDd0JTCsfhnq9xWWJ/gNGJ
cz4XI5KXQX0g1Q1CnXZEDoXlNX2eEXKZbNcUUIDHjBO88hUzaeKdjQTPGzlLrsFR
aVGTlj5JKWRxVoHWyJLrhdJ8H5fJqR11014lU6uMjflslizfIJ9C0iR4Jmnw5/5K
TSmucak9Fg3s2tCYusL/pQDcmI/RxpL4XMXT0GfOBIC1Xj0mM09YXO2Xfx306FpP
Bxs2VnBL5cI39/afedW6W4JiWmOA6+9JHkFNZuz2BU2r/Y9mNS7PjqMAO//hFtR6
CRbe4qVgfgDr6s/0pzRAOJKBQxR4tDg/vUH4q/p6r/VZz1aO70ihDhQBxFum2T43
kRISGfe04xfHHZ+0zdXqfCkhAlOnxENIwMq8Xnixsc9hHG6gvys=
=MDXY
-----END PGP SIGNATURE-----
--=-=-=--
