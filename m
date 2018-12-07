Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20EFC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74068208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74068208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeLGNLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:11:12 -0500
Received: from sauhun.de ([88.99.104.3]:36284 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeLGNLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:11:12 -0500
Received: from localhost (p54B335DA.dip0.t-ipconnect.de [84.179.53.218])
        by pokefinder.org (Postfix) with ESMTPSA id 7CB893E409C;
        Fri,  7 Dec 2018 14:11:09 +0100 (CET)
Date:   Fri, 7 Dec 2018 14:11:08 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Message-ID: <20181207131108.GA2462@kunai>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <20181123125138.22489-1-thierry.reding@gmail.com>
 <20181127125050.GO1107@kunai>
 <CAL_JsqJZJVMvd0aQJ8eDXBqiZ=quLrNGr3hhqePm8fCushHxxQ@mail.gmail.com>
 <20181203210035.GA4611@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20181203210035.GA4611@kunai>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 10:00:35PM +0100, Wolfram Sang wrote:
>=20
> > Didn't we agree that I take trivial devices changes? Normally, it
> > doesn't really matter, but I'll have to delay landing the json-schema
> > conversion because this will conflict.
>=20
> Oh, sorry, I missed that! I haven't send my pull request to Linus, so I
> can easily drop this patch again and apply a version not touching
> trivial-devices instead.

For the record, I really dropped this patch from my for-current queue
and will apply it to my for-next queue without the 'trivial-devices'
change once we agreed how to handle Bartosz' incremental patch on top of
it. I hope this fits your needs.


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwKcWwACgkQFA3kzBSg
KbbcTg//cRhHyl6Oi7w349QnGL0ZEFb47wqcFPYWmaCPzkAJMKlWbf9IQw7c4a4O
DV2HUjGT2Nu6YU3aGr5wM2LXjO3AiGnoeGyX1glKIcjvaN/r26A77tSX0zzzEU90
4S9C9PV/GmoO7H4BDerJ/d5BBGeu2X6DqIEoC3Qp/gn3kSrxvWAXvALmX+30sKdj
vWuETZKm1G7vYPL1bQG1wrOauZAEwpPgpHwLIWdj2uCmxlEJ00UsQumJEz82sxc5
lYfRjzelW5tg43eqDWV+hn+7pUxz/KL990hHKfAg9NxUszOUdOPOfKX1wb21IXa3
7Yu0qPfAIGVAswbateYTWXqhmgUJPzaoVesmqpLao5SscxXYFSUOff4fdcBFq/Oo
nhe0dgzwajL/O1L4RgV9qh1/mSOCLSO5M79c9QxPTKNEZ0/Hw5mbMZs8aM/T+L/h
l/iduLMSkI4hl4YnBGU+rGQym+oFhPHZXt+TqCB3rjCibXfHMIUIlufIJK3yM+bj
Nkl+enGbyJfZvJ9D5955ziyF/cAliy3v7vx7c0OMyvZOfimMvlycA9RtWRkE8Ioq
c1DTsJHqkJs+6aOZBJu7ImRxmU8rUZU8hqLUigAiat/p/AgqSicpQ7aleb4E0I7m
WBz2fciAP6b09TmiKBzVpk6USInEGvtcRm9OCdKjwQjAt68B2Ws=
=xul7
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
