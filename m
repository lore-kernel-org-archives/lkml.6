Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADE6ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5255F214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YZEeGv6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5255F214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeIQRbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:31:02 -0400
Received: from ozlabs.org ([203.11.71.1]:41083 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbeIQRbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:31:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42DPt624b1z9sDP;
        Mon, 17 Sep 2018 22:03:58 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537185838;
        bh=9tsZNw/JnMbPOZ3SZIiXB3RlB5i6IsjAu2/lDMRpuFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YZEeGv6s185d0YQTgNSG5rmAC/zRoFUSzDe/Ln2Hv1cla9/xYP221T64COAq528I6
         5gH8FvOQ1xqC+12FEvTEJzB1LR15njSr+ee/9yKb9GtYtRrmj9MsXEATG9170e1MQy
         S44+fjq3Wyjh/6x8o+0lgvZzOBdnb+qBUKrUiPjoyjAh7ufrkZbSGOC4n2/bFPXEr3
         GQkUC6Y3C5+4HweW5Hhk9yh/wTjyie6MCvpkZjw82uzS+V0N08zoTPG66gIPSQjuXS
         x3REldKODgOkG8ZgwHfEZqkSIbZtMioW7Ons5zjSa7SYRHJ5My6wIpyiT08Q2WvSLv
         ms2xdv3S8YBCg==
Date:   Mon, 17 Sep 2018 22:03:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        DTML <devicetree@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Message-ID: <20180917220357.61c9c61f@canb.auug.org.au>
In-Reply-To: <20180917215443.3b5808c5@canb.auug.org.au>
References: <cover.1536757532.git.ren_guo@c-sky.com>
        <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
        <b5bbb3e5-d970-dd82-400f-ae13ca782fd5@c-sky.com>
        <20180917215443.3b5808c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lNsfUWSdBS7dB4CTyDnYwd6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lNsfUWSdBS7dB4CTyDnYwd6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guo,

On Mon, 17 Sep 2018 21:54:43 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Added from today (called "csky").

Actually from tomorrow :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/lNsfUWSdBS7dB4CTyDnYwd6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlufmC0ACgkQAVBC80lX
0GyrDggAgsy7oaOuob5jaOzA+vFuYmMwOaYXTXcniOfHddrMk3dNfc8wi+QeOjqk
k/3HwVPXMb6zhoqqxarjPrcyLPQdwMo4mgFF2jO+evAHboIqT6sRmp6K0juNBAYx
aPx+/wzcIC0APcQ8scxkTm6ZWvq57vGX9bEmynpy3wVDN8MCU/F+Q8E8X4Y05KOJ
Uo3WjbtMrz+/wy1soVPpbey7vLVCIaBmvhyPAuHMLtLbqMlculnwF8JeNFgqvrt7
H6l74x0JR+0H/NyJZ11AWSyHyT464Fj5sIVJcseqW+DV6YffF5Zl5FgY+ZhkQjVj
4bSM3xldCCkGxnWJjW+N67OdhbdxAA==
=d33d
-----END PGP SIGNATURE-----

--Sig_/lNsfUWSdBS7dB4CTyDnYwd6--
