Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EAAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D648120850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D648120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeLCV4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:56:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:53847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbeLCV4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:56:43 -0500
Received: from longitude ([87.79.84.57]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWTfu-1h1XjS0u6c-00XbNn; Mon, 03
 Dec 2018 22:56:05 +0100
Date:   Mon, 3 Dec 2018 22:55:58 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
Message-ID: <20181203215558.GK15324@latitude>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
 <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
In-Reply-To: <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:LOSPz25wnZaZbdRbnDyYPrZwko0HsusJN9bRjOtQ4TquWHlxyE9
 zj2+7XDUDg7H1pW3lj28PVAx7gMsZS5IPjeN0ew0nizKDQSHcVOgPk1gdZVt7nR7tPeYYe8
 agoXoEbpnLVVOriyvU5CrQxvsvzgJnC14dYhslqWoMlPQ/fgmiIg20mWvnhVWuFNvM5Urdr
 1nkyvOnSN9brwMZzHcMiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0P2tvbo0mg8=:IDsYNlPJJNIDas6qG7PHSi
 YkY9G4xNRp5eXyksLho0IYRkTbTLnl7Cc1ai0+XLQJqbcOZl9BdYrse+hMO8szZ0Wog6AwL4q
 VzObVQfN4C1zNSSjxDvxs+ErE+GfwoxnlAPEwQrqcKl2fe8z0G8zSZbqsQBaqXf/oD5qX0qaU
 ffEiiayrYDt1JHuR8PAaqYkCS0mS/BRmyK3G+oPOwkX49yca2u5iXa7gvXKNxOorgxlBFpCTG
 KLvK7QqHjGhfHMeeStDSN6IEd9vna4Bdo/FW6FV7eCMQLV5LIvmfgKK3I0KK5Eu6/OFX1SrqG
 0SFiM6NwgrMiJ9bsgHsWJtRE4V8Af6KautwhuDHvJHi5nJKZNs6UIX132Vvv5EWqSZgdyb/UN
 Fjge8o3BI4/f0v09fu96QJRc0ANCU3xQTsAmiz1B2nKvpIFhyZZZ04SYi8fdt2D0dzuK2o8ID
 wm5kWgWKW5ZdiNbDqRKWy/ECX7y98erueRY9pI2CIsM7XMU5cvIH9R6Q8ivbczWLgHETGLOLq
 ud2GSGMta3HgB/OxlLabmJ/wtFOQ1Ueo1nmZDGomakCHsML5XxCkLiCrk+JUr/OMvAd0W+2a7
 jHkQxUuV0503fDSHk9SZ+vFvDW16FoJJkeLDXc2QATqZ2ytVh8GE5YY+OF5DwEAUA/3recLqj
 DfIrFFKK+eZaYlHeEDLUYkN25Uc0qjd8Ab3V8sDw9h3MxL057EA5LJynsgvy3Aq5TgDgnk/vs
 zM9lQs/mDEGh/LZcxoUS/SPROH1gp/Nl+tE/7DhwA9xlIZeypNBvWe1/hJW8Fw1q9hvgy/ZOV
 g/ElB1d6GWp8mvt98MlmHZ8ruiPNHCyOIVfUKhK0E4YvULyizbGTSk9Qng935hEe8vkAWr4o8
 YQkQninPGZoFVxnjxLyFaWakBB0gcZA7ft4Qz8Qyz8ISPHOC6d7oAQJyn+qoA9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 29, 2018 at 07:00:16PM +0000, Christophe Leroy wrote:
> This patch reworks mmu_mapin_ram() to be more generic and map as much
> blocks as possible. It now supports blocks not starting at address 0.
>=20
> It scans DBATs array to find free ones instead of forcing the use of
> BAT2 and BAT3.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---

I've just tested this series on my Wii, and starting from this patch
(03/13), it hangs at the following lines of output:

[    0.000000] printk: bootconsole [udbg0] enabled
[    0.000000] Total memory =3D 319MB; using 1024kB for hash table (at (ptr=
val))

Before this patch it looks like this and boots to userspace:

[    0.000000] printk: bootconsole [udbg0] enabled
[    0.000000] Total memory =3D 319MB; using 1024kB for hash table (at (ptr=
val))
[    0.000000] Linux version 4.20.0-rc5-wii-00022-gfbb911b84755 (jn@longitu=
de) (gcc version 8.2.0 (Debian 8.2.0-9)) #1337 PREEMPT Mon Dec 3 21:49:02 C=
ET 2018
ug_udbg_init: early -> final
usbgecko_udbg: ready
[    0.000000] Using wii machine description
=2E..

I've tested at patch 1, 2, 3, 4, and 13, so I don't know if it works
somewhere in the middle, but probably not.

(And in case you're wondering about the 22 in the version string: Those
are mostly patches that give me a serial console.)

I'm not sure what is going on, because I haven't looked closely at the
patches or tried to debug the problem. If you have some debugging tips,
I can try them.


Jonathan Neusch=C3=A4fer

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlwFpmUACgkQCDBEmo7z
X9tjQhAAtgGfhvYKAZs5YH93HGyareHmVqRSSg59aSnlMwaTZhLNHTix+xkwCgRQ
i8mr6oA83S5B79HehInblEfrDh0FGluPBrUfhK/bTQOmJ4Cqk8ur4MHIEmBGiy3X
2Py2zXCeuK4K7YOPCqfJmmuPTo+qviQe8ya2i1TPyZ1IqwqnLJ5jstLBs8Yyfm4o
y8azYiRZ43cJyhZ7bI1I6L4Y8oFYG06TLSe8yRaRHWO6iOhbEcv1ANUZ0Lz/Azn2
n0xWB4GhcS+cCJNzzYHjZqXQWWtWElDbuuXYh5kgUQAHZWgFNzCMjm5pd1WysiJk
rxUyaaHTShibBgBz8KRMfXpJBUg6Ux4t86t2JdopbZCJ5fnXY8QFHEMCVpcak7v9
YDlX8ABaxC0s2ykxE9HFF6nrlkYQUk0pmbeqqEZN/vUV1lAQr2tlVap9s2ZwJdIP
HUhhA12LBkOJx5q31wNip2k0cuvM6IjdHSrImjTNb37yHqsGaXCu+TWaWSmzXA/B
f3/7TLY+chXqxUCawpPgeYz53fy4Y9opNjD3hzDzzFD9PcRFzyixl7fM9wlgE37w
D7UNNZ18ky7LKMuL+5RpbH41dGILkku3tPHflc+h0v+RCJacL3h+uDr3+w7Y8br7
D0zb7tVOQZwK8rbIoRzLPgsuU/aE2+3oC6fdLM2utgF7WwG/jlo=
=J3qj
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--
