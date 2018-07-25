Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26E7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5EE20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5EE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbeGYNbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:31:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33307 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbeGYNbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:31:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 103FD207A8; Wed, 25 Jul 2018 14:19:47 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id CF26F206A6;
        Wed, 25 Jul 2018 14:19:46 +0200 (CEST)
Date:   Wed, 25 Jul 2018 14:19:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: h6: add
 Wi-Fi support for Pine H64 model A/B
Message-ID: <20180725121947.ox4zykod6jjadvfw@flea>
References: <20180724011551.49603-1-icenowy@aosc.io>
 <20180724011551.49603-4-icenowy@aosc.io>
 <CAGb2v67zR-Q9n7L6CaFKDUJFHFEC_h8-RYxkdyeyJb_GbNmkJw@mail.gmail.com>
 <CEA43CB7-1DA6-4983-BF18-82C4A48FB92B@aosc.io>
 <CAGb2v64Qae4O430kP30DQNhp0Dt774OHt0nMe35ckp8X=CTFLg@mail.gmail.com>
 <AC678B03-19B7-4110-B333-72188CE71296@aosc.io>
 <CAGb2v656oPmAX=_y88b05xqrona3HFtU-VmNQhHxK_n-4gD+aw@mail.gmail.com>
 <20180724144151.myyg7slocsfjjsfi@flea>
 <198DB486-4789-4777-9596-2BD6FAFFB741@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bve3mvkgddeqoul3"
Content-Disposition: inline
In-Reply-To: <198DB486-4789-4777-9596-2BD6FAFFB741@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bve3mvkgddeqoul3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 10:42:32PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B47=E6=9C=8824=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
10:41:51, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >On Tue, Jul 24, 2018 at 10:37:51AM +0800, Chen-Yu Tsai wrote:
> >> On Tue, Jul 24, 2018 at 10:28 AM, Icenowy Zheng <icenowy@aosc.io>
> >wrote:
> >> >
> >> >
> >> > =E4=BA=8E 2018=E5=B9=B47=E6=9C=8824=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=
=8D=8810:26:02, Chen-Yu Tsai <wens@csie.org> =E5=86=99=E5=88=B0:
> >> >>On Tue, Jul 24, 2018 at 10:23 AM, Icenowy Zheng <icenowy@aosc.io>
> >> >>wrote:
> >> >>>
> >> >>>
> >> >>> =E4=BA=8E 2018=E5=B9=B47=E6=9C=8824=E6=97=A5 GMT+08:00 =E4=B8=8A=
=E5=8D=8810:21:59, Chen-Yu Tsai <wens@csie.org>
> >=E5=86=99=E5=88=B0:
> >> >>>>On Tue, Jul 24, 2018 at 9:15 AM, Icenowy Zheng <icenowy@aosc.io>
> >> >>wrote:
> >> >>>>> The Pine H64 model A has a Wi-Fi module connector and the model
> >B
> >> >>has
> >> >>>>an
> >> >>>>> on-board RTL8723BS Wi-Fi module.
> >> >>>>>
> >> >>>>> Add support for them. For model A, as it's not defaultly
> >present,
> >> >>>>keep
> >> >>>>> it disabled now.
> >> >>>>
> >> >>>>Nope. Pine64 actually has two WiFi/BT modules. And they require
> >> >>>>different
> >> >>>>device tree snippets for both the WiFi and BT side. This is
> >better
> >> >>>>resolved
> >> >>>>with device tree overlays.
> >> >>>>
> >> >>>>I have both, though I've yet found time to work on them.
> >> >>>
> >> >>> I have also both.
> >> >>>
> >> >>> The skeleton here can get the Wi-Fi of both to work.
> >> >>
> >> >>Cool. Then I can put away my RTL module for now. :)
> >> >
> >> > P.S. SDIO is auto detectable, and for BCM chips, the OOB interrupt
> >> > is only a bonus function and it can fall back to standard in-band
> >> > interrupt (which doesn't need special binding, and is currently
> >> > used by mainline r8723bs driver.)
> >>=20
> >> Correct. With BT you'll have serdev device nodes with different
> >> compatibles. Then you'll have to resort to overlays, and you'd
> >probably
> >> end up adding WiFi OOB interrupt bits as well.
> >>=20
> >> So the question remaining is: should we enable the MMC part, along
> >> with power sequencing and regulator supplies, by default? Thinking
> >> more about it, I'm actually OK with it. The board connectors are
> >> clearly marked as being for a WiFi+BT module. The whole space on
> >> the board is surrounded by a box in silkscreen. Sorry for the
> >> initial nack.
> >>=20
> >> Maxime, any thoughts?
> >
> >If there's a need for an overlay anyway, there's no real reason to
> >enable it by default, especially if not everything is there.
>=20
> Everything is there, for model B support.

Except BT?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--bve3mvkgddeqoul3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltYat0ACgkQ0rTAlCFN
r3RXXQ/+O/j53xdIBK7aZHZSYYNGM4LbCT4+183lU8sEY+0FAx7O3mVqkRySnt0E
Yxcyw47z+7C5YISHe/VSmSpZkFyhcVtLsxIILSKwchbJftAXQzoExsOt644LLcAK
KzDb/DxJJPAMVH2G81IOmdZB1JHZvsKEKcYGF/1xbCGkq2gN0ro4vo0hx608Wdet
4HgEqtDFTLLQeiiPE+BgHO3OKW50tQoR+ayDUY2QwdmYR53hdzEiIXprRTnLG8Ck
yVULQrl41UYY6VXOT5mLupuw2YICKRCHK9aNFG4P+4BRFfiOzPLORvLyOrUg3tur
NlI1PzCT3DuBIspTu3kOCL+R6lQyqqXvYNQTdm/s5yV6ATa9/azafgpX9y+xRq7q
V5SKXHCR2TMfm5XSCw3nGAgoowmXbTS9QVcqtrDUsBcSCblXcKyUnAn5UA0BGDZx
uluG7vqkKzNt6LVCZctI2R/1euFIM0bxmer8JJ5YmkqhD+C/jqBDBpImQzzSflXl
oJbS9bNYXtjtNyyhj8V9nA1fC9qid3aSSWvpJuBmdz7fZCDi0nGGnehYCuy35L7g
iaN7pyjOx8CZZnq/PhCjZVrkPsKDRxNW/0hbhx01EvOUsvjpVAQ86qTdYEYrlYG6
HRMtvUp0RWk2NZQw99AJ237LtXreAO0+DlOkYgknG9LREsD4AAY=
=LDtb
-----END PGP SIGNATURE-----

--bve3mvkgddeqoul3--
