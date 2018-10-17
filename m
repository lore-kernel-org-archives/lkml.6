Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60280C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA4521479
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA4521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeJQON1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:13:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:47117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbeJQON1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:13:27 -0400
Received: from [192.168.20.60] ([92.116.170.8]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdZAI-1flc971CAE-00iiBU; Wed, 17
 Oct 2018 08:19:19 +0200
Received: from [192.168.20.60] ([92.116.170.8]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdZAI-1flc971CAE-00iiBU; Wed, 17
 Oct 2018 08:19:19 +0200
Subject: Re: linux-next: Signed-off-by missing for commits in the parisc-hd
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Parisc List <linux-parisc@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181017171507.6cfe08d2@canb.auug.org.au>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; prefer-encrypt=mutual; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <76939293-4ff5-f6e8-aec7-d014e0a0419b@gmx.de>
Date:   Wed, 17 Oct 2018 08:19:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181017171507.6cfe08d2@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fYShguV3TNoFJq0C0cJPj7wkEqW4bqgBs"
X-Provags-ID: V03:K1:OPPF32Wzu4tlbaC7pAuwbM+E3bDMeEnzw0PaKsy4QVWcGbv/h8j
 MnRERgTS95n5pVtMN/r3WSV0GyrYT3+Sh4nOIjtqVVmKZg3LDazX7pI+sjqpGbxZuIiapOf
 R1SxsZxXBE3b3YosGEZvj4j2nHWCs//RM4r2K20xNN1aUusBlSjO9jHC4HF2MLLw6K+YP+V
 BDcqgB3WSpzv5GK6/x1Mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ubw8eWJCPQk=:KlqElX/0UVzJ6FViqwyLyl
 era90pugKpSZA+fQ5QjhhXD3jaY7Bc5k1MjigjoLvxeE21DZHvIyqrQCRqerBcX8mTXEF1tt8
 N4HQYGoMCdDEWRw7ndCu+eE54bXgyDEYsaeChAGspfgaQf8f69UPHytH481C2IuyX0qZeMpj3
 YluT1WbLZOvB7DL8c1AZiUDh7wmp8FXnigJsxvMAC+UrgP1onaPAKuroLydxTs4/4XI9rSU47
 5n+wqXFw9Bl7gYy/OKyRVDHoIMCeKKCvsK5zsqAzss+rt4Bokjun355BUV3TYJykAvg/MrOHR
 1Jeywnus9nillWEu2D6dSY4JahPivWxQ7yK8IiQYEnyR6jENAOKt6Ti86xs3udS8sfaRFta4z
 +lTpwzy2sFFsfWTjW0j6YUQR/yNz5Fxy1bZo8nl+cCoYtBhdqoGKWHt/IeLPMg0DGCNVXNQj8
 z13n4eXOJ8MI1cXrwdgXhCqG1AWWpF83TNmTKTLU0B20tjeQbunb4yM92pJ8wEaU+hIvUltW3
 1pw0I5Vc9scSLLUV5wvba6j6WKQJAmTYah8hLN0HhpwFAgeLVqAvU772PTA9sG9DtkcicwMCT
 MVdY/Ufv5YLP460hvh87ZGdCc80pPUb2O8XxNLCKC3qqXHTjcP+a4jg+nhtgZUiPQEpC3p7FW
 LJA/aoZMcK8mAuYOAIMntryLIVycdr6J/cvUhGuic2c0sehY415C6NBYoHpb23dMSfBy0uweg
 yICf/Q20UHWz91Yk5ZJqzTfxM3Az3fXBRWhEd9CEYIjZbVnkxD3R7RUOo4F0lZu/UfRbgA7bJ
 P2OBB+KQCP0kikXJDa65w41VvsL5w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fYShguV3TNoFJq0C0cJPj7wkEqW4bqgBs
Content-Type: multipart/mixed; boundary="stofG0xModqiYNHPqf8oiqOBD8jFsz0ap";
 protected-headers="v1"
From: Helge Deller <deller@gmx.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Parisc List <linux-parisc@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <76939293-4ff5-f6e8-aec7-d014e0a0419b@gmx.de>
Subject: Re: linux-next: Signed-off-by missing for commits in the parisc-hd
 tree
References: <20181017171507.6cfe08d2@canb.auug.org.au>
In-Reply-To: <20181017171507.6cfe08d2@canb.auug.org.au>

--stofG0xModqiYNHPqf8oiqOBD8jFsz0ap
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.10.2018 08:15, Stephen Rothwell wrote:
> Commits
>   17714e83ebff ("parisc: Release spinlocks using ordered store")
>   c389eafd8ac2 ("parisc: Reorder TLB flush timing calculation")
> are missing a Signed-off-by from their committer.

Fixed.
Thanks,
Helge


--stofG0xModqiYNHPqf8oiqOBD8jFsz0ap--

--fYShguV3TNoFJq0C0cJPj7wkEqW4bqgBs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTPnDOmy1/TQodsisYgKkl43U+sXQUCW8bUZgAKCRAgKkl43U+s
XdiqAP9I2ud6d+Wj5QVVIyeQR6quTfEXgiFKfWw5pUdJPL0gLgD/daZx+fINignC
QYCj16mZD2jcGh7bUmEjbm1D0KKb2Aw=
=pFl4
-----END PGP SIGNATURE-----

--fYShguV3TNoFJq0C0cJPj7wkEqW4bqgBs--
