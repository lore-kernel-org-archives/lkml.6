Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9BCC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30DB2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30DB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbeGVW7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:59:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52536 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbeGVW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:59:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D4C4726BA64
Date:   Mon, 23 Jul 2018 00:01:05 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Mack <daniel@zonque.org>, zbr@ioremap.net,
        Mark Rutland <mark.rutland@arm.com>, szabolcs.gyurko@tlt.hu,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v4 1/5] dt-bindings: w1: document generic onewire bindings
Message-ID: <20180722220105.hl6lwfyueyojfxmt@earth.universe>
References: <20180706053552.11438-1-daniel@zonque.org>
 <20180706053552.11438-2-daniel@zonque.org>
 <20180711150157.GA18150@rob-hp-laptop>
 <5070717c-4c9f-c580-8f50-2369dcd74aef@zonque.org>
 <CAL_JsqL10WT5AK37_8o3M_=UiLx_thcm1W3UNz2qBaB5dRo8XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="44vn7kto76qqzxm3"
Content-Disposition: inline
In-Reply-To: <CAL_JsqL10WT5AK37_8o3M_=UiLx_thcm1W3UNz2qBaB5dRo8XA@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--44vn7kto76qqzxm3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 20, 2018 at 09:10:36AM -0600, Rob Herring wrote:
> On Wed, Jul 18, 2018 at 6:40 AM Daniel Mack <daniel@zonque.org> wrote:
> >
> > On Wednesday, July 11, 2018 05:01 PM, Rob Herring wrote:
> > > On Fri, Jul 06, 2018 at 07:35:48AM +0200, Daniel Mack wrote:
> > >> This patch adds a generic w1 bindings document that describes how w1
> > >> slave deviceses are grouped under master nodes. It also augments the
> > >> existing w1-gpio.txt document a bit.
> > >>
> > >> Signed-off-by: Daniel Mack <daniel@zonque.org>
> > >> ---
> > >>   .../devicetree/bindings/w1/w1-gpio.txt        | 11 +++++---
> > >>   Documentation/devicetree/bindings/w1/w1.txt   | 25 +++++++++++++++=
++++
> > >>   2 files changed, 33 insertions(+), 3 deletions(-)
> > >>   create mode 100644 Documentation/devicetree/bindings/w1/w1.txt
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > >
> > > Note that this will conflict with a unit-address fix that I have queu=
ed
> > > up for 4.18 (will send this week).
> >
> > How would we best handle this? Sebastian, are you going to apply this
> > series, and add a note to the PR for 4.19 on how to resolve the conflic=
t?
>=20
> Either 4.18-rc6 or my devicetree-fixes-for-4.18 tag (based on rc1) can
> be pulled in. Or just note the conflict. It is trivial enough.

This looks simple enough to just add a note to my pull request. I
prepared a immutable branch based on 4.18-rc1, which contains this
series and merged it into the power supply subsystem. You can get
it here:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/=
tag/?h=3Dds2760-for-v4.19-signed

-- Sebastian

--44vn7kto76qqzxm3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltU/p8ACgkQ2O7X88g7
+pokHw//doIU3Uznm8L8X4Z1wKHojcwlgpmTrzd9xNyZDG38xhfERI2HNwyQ6XJv
xnro4DcD7hhln3nYyXFuEAQln9E8qcbzEd9NvqFgX2WFZ9QPTmdaFdCN8wDjh8eW
HKwkZU5iVv6mpGxAcgK5NSvhtq1iBMSfFjFOF9PQ6XpjkQ9KLtTIvEW/jgKdJafh
GDQJKBXLUKruBTLoXHVWi7YPqgixEUAVYOHMjQBT7V9mIbyww+BRBHN3EMSAfgQe
SAdalRQ9ShKWscO6LtHeuIV2AdfKdjASZl85xE+YaIZrD6mq3kIzO/YibTXQU/7l
1NUTrzVnxw6cxgt//27ps2D+Cnx9zIhwZsuw2zoxWhRFCO+W8cggwIB5+7PtIM5H
LXhy+f3cH8xYueyCEgwT6a49gzPt+tYOv7pSF58qCevaBqTA96+ncYGH326Am4Eh
xT1kTyeqkOOYZJB7as7P+NNFsG680Tgf9YXPuqBkyWFvSrPZz0u38wYaUM7dF218
uBSAhO0arV/6KLZCd15/S+Dy3rKMtkr84fleBunryW8odkx8903ZJ30BtdAyodJO
yOp7yvccsfSINijrdqBpIU4tjlA82ABHRCN413Whrv4s8pMdSgeXZE3qiq8LltKD
7ZruogJ3cF4z0MGZihKYUm4J/Fumg5Bi6+qOYltIbprUgL/2y4k=
=Fyiq
-----END PGP SIGNATURE-----

--44vn7kto76qqzxm3--
