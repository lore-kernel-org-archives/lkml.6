Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07335C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83AB2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfBZL3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:29:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:33665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfBZL3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:29:25 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCtNr-1gq25J0ipP-009gWN; Tue, 26
 Feb 2019 12:29:22 +0100
Date:   Tue, 26 Feb 2019 12:29:21 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: spi: Fix card detection during probe
Message-ID: <20190226112921.GB7654@latitude>
References: <20190210173109.12602-1-j.neuschaefer@gmx.net>
 <CAPDyKFpinj0-DbfzJ3ioUkjdUAg7cJQuZD-xjbfQXB+VV2fTpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpinj0-DbfzJ3ioUkjdUAg7cJQuZD-xjbfQXB+VV2fTpw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:GEYzzZWLPPxtB+9dRMtTsx6iaHOvjg46I6/yZblLAP69CKYN8Jd
 nBQzSFupNmZmcEPIJhzA2moyqX7OwCcJXEHdgu5jGoG+glCNhTRYqXmgwJTMCwUS/T/43x8
 /SsDvaZtGSMZBYELL582/G9UFqBTLqKF8M0ZATl8dg0cpfyuEdwIWGkZ7cT52Moy7OYRvxg
 ElG2SAmKhjhxPe4JrPcxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zQUFUEMnEvU=:7FLpU11SFRLlwKCOL42LE5
 Kl7jG62nPzaxnNaq2FzQsISRNdqMjgjT7IGvmdNhP0jRR4P5n0TKYMMWkxlAiu8UuQRK/tfAQ
 q56tPtoow4XBx9wvyYUeanHZe3i3SjvQVAwStSuv+SH103JQusvN8BXs8664Ik2d39nTk6E/m
 rx558m8SaYGakFjSU82BfFFi8M/+EODeDf5mxrM21AkAkUYC4GkIVwUUDId01OqP4O53UL/kQ
 55u1qdbFPavJH6AyuO798EjLKFvzufoZlCHAnt5gMF/lTOAPTxEbvO+QbXx+CKB/Xp/v1QMnl
 SOb2geN/FdGeQgihen5ms3WkmHIlucrDprLqOPD2QulVTmfKIE1FQBZ1hPfEYpGbtk/kou/UV
 Im0JrpudnxeUo4+ch2ESuoA+Kbq0eC4XMJm4xCmpFZKbQto8XWekGMzkwgDnhBWcjj5gK0++f
 B3sk2aypkKkl3e22PN8AsbpKGwWJBzQOAphTWHfNbhDu9hdQg2kbc08aQJY704lmA2FyehNRW
 qXGrNrOv6/bMBgonaBNby26zgCn9l/WdYZ26ENvVO4saqGFKE6GL2uOtdmjeKca4tudhWZZlc
 X4MKVkYazbrplSGEliEsDu76P3odmoUFQrzLra4FByjFsbgOEpChM1pvnW1mhd2sAtJrWf5Vv
 68cbWTsMlzh6+bhJaE8kQ2VFCuNd7GkdRYjgfxoEMJDHaLd8SgT/YmMIWP1U0ib/H7bd2RIuM
 4ZMVXSIPx97CSC9ZU6IL00s+gO4uI0e/7sIm4kSqpoPRWke3kKtltnR+NsO2bZwGk6yYXtMVI
 rZizEZR7Po6J6I8mMmmcyCXj3a/E2hCKJ/GU6MW8+gMGgy4ubUe8Lnt6u86o+LuBa/pzSmuqN
 ZwiwV3GVNSUDf2rrwRNbR9qdAsDZFPWhwM3Z2jGFSmdtOFDMV9fKOOu10QdqIk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 09:18:06AM +0100, Ulf Hansson wrote:
> On Sun, 10 Feb 2019 at 18:31, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx=
=2Enet> wrote:
> >
> > When using the mmc_spi driver with a card-detect pin, I noticed that the
> > card was not detected immediately after probe, but only after it was
> > unplugged and plugged back in (and the CD IRQ fired).
> >
> > The call tree looks something like this:
> >
> > mmc_spi_probe
> >   mmc_add_host
> >     mmc_start_host
> >       _mmc_detect_change
> >         mmc_schedule_delayed_work(&host->detect, 0)
> >           mmc_rescan
> >             host->bus_ops->detect(host)
> >               mmc_detect
> >                 _mmc_detect_card_removed
> >                   host->ops->get_cd(host)
> >                     mmc_gpio_get_cd -> -ENOSYS (ctx->cd_gpio not set)
> >   mmc_gpiod_request_cd
> >     ctx->cd_gpio =3D desc
> >
> > To fix this issue, call mmc_detect_change after the card-detect GPIO/IRQ
> > is registered.
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>=20
> This works well as fix and for stable! However, we should probably
> clean up the code in ->probe() to avoid this thing altogether.

I figured that calling mmc_gpiod_request_cd before mmc_add_host *should*
avoid the 'return -ENOSYS' in mmc_gpio_get_cd. However it turned out to
be not as simple as swapping around a few lines in mmc_spi_probe, when I
wrote/tested this patch.

> Anyway, I send a patch for that - on top.

Thanks!

> Applied for fixes and added a stable tag, thanks!

Great.


Thanks,
Jonathan Neusch=C3=A4fer

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlx1IwkACgkQCDBEmo7z
X9vOuQ//ap3y5yOcvpnTDTH1GQJjshzHygc7MRPTiHDrbWohSitzELdb6df3oTsA
33g9FVE35Az3CNVDGdncfM41zKKTK/g5BS/Uatjs4U4usO1E0tqlKHR0kp8CuR5l
iZUsB/kFmtcrAdni7RyE045hYZT+wlwk+l/63MthdpQSvhEa7ps3/xDnDvC+qO1x
X6TOr7pW5gwnaun+ZQ08hvDg62MCUFtDIntIDLpE1iC/RpibBR79IRXFGVgsstk6
YQbyauG11wbfMetXhJ6v63j3g5f6NILr0Nwx7z9kMvn1HYht0fxtQDBjULH0WJRR
MX+D+PptV2x6q6eE4dzIDhaNBSVXy+dSMaS/WYhNr4AjTV8UAF9in+0u0bz6PPe6
hNWhzaiEgKT7qRnH2ivJ4CImf8EcwRsyZjU6inx31y7RezxyKYgPtVis0g0Kmhex
yLK8hYO3jXsYGEWe7fBBSuaOoBlnthltkkLNWGIYS4pTT3Wk5Syl3Feo1UhPo3Ye
1VWt8RYuLiY6rLOpsSsn3KY4sM8+R/EMu4eNZx4r422u+OsXUh9RS1e5uAMgQOF2
hOAXBv+swD3l+Kgg3uMiqhhlDYqOexmI1jzeLvFObOSFE7PPfoBQwQJdwq51dhfb
FwyLY7uv4x4uiz6FTmyRp6wIc4AyVS3lZmz62AaaCaqefpsiJDw=
=Bzd2
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
