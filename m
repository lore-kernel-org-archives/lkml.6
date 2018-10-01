Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E9CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B48206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B48206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeJAMda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:33:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:41603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeJAMda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:33:30 -0400
Received: from [192.168.20.60] ([92.116.143.109]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGS9o-1ftbfv21Lc-00DHkH; Mon, 01
 Oct 2018 07:57:23 +0200
Received: from [192.168.20.60] ([92.116.143.109]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGS9o-1ftbfv21Lc-00DHkH; Mon, 01
 Oct 2018 07:57:23 +0200
Subject: Re: linux-next: Signed-off-by missing for commit in the parisc-hd
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Parisc List <linux-parisc@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181001110401.046aa075@canb.auug.org.au>
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
Message-ID: <7d3bdf93-73e6-1f4a-8242-84532ebfd01a@gmx.de>
Date:   Mon, 1 Oct 2018 07:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181001110401.046aa075@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NyQzhZz4bLBdFLijrimIMnMY2Qdp4MyEu"
X-Provags-ID: V03:K1:qgNAyyVlOUcSSlMji0RWtAHboYGmU8WfzwXDFVE0E6zOnN3+7t+
 Kzcc0B2v5mzwrnygwQNJy6hrFu5340VtUZSFE8asZFq9dAOPkx2NUkHji5krU7SyZVP/8Dx
 Xfl4m7d3XMQu709DDuBZLKRfvwFjtt1NjfJHtB6PLZR5fhk8IC4thPoGnzAOAcpcuelT3p6
 ViWU+UR25ZMz0+5E8VRxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CvyPgAKA9BU=:TJ9JYyLqlziE/8h2qpKWXs
 dEp4J5j19GyCEDrEWvnCLehiMogEz0qGm/8Ls0Xgs3wu/UZPP3YsQjDiIsUZR8J/FnQ5MdUDx
 7uw6hxRI3FD8+qHkM1xnY38cHmMlM6BO39xD/3rC+czJ9atTz2lkpciWKigXH0eU8L22Eyo0Y
 9+v6OOLQSqIV2HUhb4R64/ML7L/plGm05Nl4TfEp25VgVhGM5AL7PGAX+5XS7Wuxk/MAyXEuM
 1oZNwOAbYcaz6+PFDtoxmAhpMlSqemx+I/eCJxlluFtHtMHddJq+PMwBrjJoTs9XGES2ca1YL
 nJqZ3bRVw5CnLuI1eHICSVwpDYWK462mezE5Traz8Sbid0Bs2K0EflT8wvx+bltL4sWHIAxEG
 OYGm1MUGUc48RVvCOvv66Jo9CmOXAMk+cWWruEFtG7F1+pSYp28m7IIQXczli38/OgttcmLxE
 wZZ9NmqmBAXmJrqlbXGEcfFFqclYWry9Uwvkwt3z0Jlz4NE43Cg4DYQmp7/n4V6OMrTLSvgoc
 h60gMqPWMOI6TS8Z3srC2htnDHuR9kxsRoR1MsNEDhGoyFHDSTroxyFH2EPcJNohy+bES0Bbn
 E6qJ8nC0At3x28ZrCyTmZTE7uYLm6jTzkVuJUC5/VgFmo1/tfc4lptigULYz6h1/nZK/LJobD
 b0xEJKaaE6bLM+wclaIgLHTLWYZhsz5TYPylW4cBqa7XD4mDUkRVzO9a5QXATy8lM4aqVANR7
 LGvnrJb1fpsZmsLOlAwy894Rv1DSaWQHPgVRhwCj3OeNQ5gZdRrQM5XUT6bHdIXWF7khv4oL1
 ZbQdsNuZB+qoI4vLsY/wZD9Q0tcmg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NyQzhZz4bLBdFLijrimIMnMY2Qdp4MyEu
Content-Type: multipart/mixed; boundary="R1H1Iwl10G1yGJIfoUvsLtcrjgfq1Fgft";
 protected-headers="v1"
From: Helge Deller <deller@gmx.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Parisc List <linux-parisc@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <7d3bdf93-73e6-1f4a-8242-84532ebfd01a@gmx.de>
Subject: Re: linux-next: Signed-off-by missing for commit in the parisc-hd
 tree
References: <20181001110401.046aa075@canb.auug.org.au>
In-Reply-To: <20181001110401.046aa075@canb.auug.org.au>

--R1H1Iwl10G1yGJIfoUvsLtcrjgfq1Fgft
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.10.2018 03:04, Stephen Rothwell wrote:
> Commit
>   f17bbdb5eea2 ("parisc: Remove PTE load and fault check from L2_ptep m=
acro")
> is missing a Signed-off-by from its committer.

Fixed now.

Thanks!
Helge


--R1H1Iwl10G1yGJIfoUvsLtcrjgfq1Fgft--

--NyQzhZz4bLBdFLijrimIMnMY2Qdp4MyEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTPnDOmy1/TQodsisYgKkl43U+sXQUCW7G3QAAKCRAgKkl43U+s
XdYjAQCLOr7DYV4TkmDFUyJGnMM7k/cB0FQjTfXpiHGzRW4AgwEA39xQtbkEEVzk
u6090ybPL9CgPY+owhGj7lxGmILqoAI=
=iZKw
-----END PGP SIGNATURE-----

--NyQzhZz4bLBdFLijrimIMnMY2Qdp4MyEu--
