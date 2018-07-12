Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8ECECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728E72083B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728E72083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbeGLWAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:00:15 -0400
Received: from sauhun.de ([88.99.104.3]:60142 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbeGLWAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:00:15 -0400
Received: from localhost (p5486CFAA.dip0.t-ipconnect.de [84.134.207.170])
        by pokefinder.org (Postfix) with ESMTPSA id B7CF4574781;
        Thu, 12 Jul 2018 23:48:45 +0200 (CEST)
Date:   Thu, 12 Jul 2018 23:48:45 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Juergen Fitschen <me@jue.yt>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2,3/3] i2c: at91: added slave mode support
Message-ID: <20180712214845.iimw4sfckgm6uhh4@ninjato>
References: <c9b749fca8e684aa47ead9a5d9e68751326f63cb.1510247114.git.me@jue.yt>
 <20180602213513.qv45gaq2kogagju3@katana>
 <20180709151504.6phtp4rm7of6b2qc@M43218.corp.atmel.com>
 <20180709155135.bjwhrmbk6j26fx4c@ninjato>
 <20180710084257.ewgnvroow5weffvf@M43218.corp.atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mkhkdeglwbk2k536"
Content-Disposition: inline
In-Reply-To: <20180710084257.ewgnvroow5weffvf@M43218.corp.atmel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mkhkdeglwbk2k536
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 10:42:57AM +0200, Ludovic Desroches wrote:
> On Mon, Jul 09, 2018 at 05:51:36PM +0200, Wolfram Sang wrote:
> >=20
> > > Sorry for having not catched it. If I remember well, it was the only
> > > issue I had while testing the slave support.
> > >=20
> > > >=20
> > > > BTW maybe I asked already and forgot: is this IP core capable of be=
ing
> > > > master and slave on the same bus?
> > > >=20
> > >=20
> > > No the master and slave modes are exclusive.
> >=20
> > Pity.
> >=20
> > But thanks for the heads up, any tag you want to give? Ack or Rev?
> >=20
>=20
> Yes sure, you can add my Ack. I would be pleased to see the slave
> support taken.

Not needed now, but next time please give a formal ack. Patchwork
collects them for me automatically, this saves me quite some work.


--mkhkdeglwbk2k536
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltHzL0ACgkQFA3kzBSg
Kbal6A//YTHyE5KzXlxI4eBX/n0u9WTNdkK/I3OV3kg9xHCYu7h3LSkN4N15+uyq
YtgapKqdoChzwSqqXwL0xKRMmSDDTXC3C2xUjc4qIm2xbh0XWuP6jeOr4hWe2+Fs
Es2DXD+0ZIiubeEI3lqQXwufv7jWtKbexx4YElMUFhHJfEHYQe7P2nWg/Z96bfC3
ewiS6+mexevwCw4F3qH2KSvx5fA3NIRFf+dO75S1ogtp2ULKdHCgE138PJ8kgH+o
XajfqDMxz0HVmh44w9fi5yK9jGWF7cuDlROiM36ljhGX7h5w07HpMozRigjoxgfL
XitM9pTgnCZn6bKjwSSBJ4whRL/WjiftFmxEWxhyRwHcBFSU0E7Kj1AGVE3JmiYP
JFboI4at60LgdqUI5F/dYQE5ijPG/G60jk0Rc2lyBA++JmLr+9sda4cjYSvfQJww
jZKHJ8g5kVfJ4qRZ59vD11GiSPqBTQtnWFhXjG3G0NevW6FlyKbOj6qUj7WlJeL8
o5SyhXDvJ/h8trABuXzB1huvcEiNRGjTf2gegsN+3q0+P1VS+53CJ5qRDUlmVpmh
7fcRxQ9kwc8H2ChB6S+P1PeHJAtLDpbZ9U7VWuQ4PYk0GQQb14hL96QISisagukC
EHTK9lT/1Zfl62qpytzC9kl6zXmdX+vYw54IpdJTaxYZOnddvLw=
=0jgE
-----END PGP SIGNATURE-----

--mkhkdeglwbk2k536--
