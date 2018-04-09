Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeDIJ1n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:27:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41285 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbeDIJ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:27:42 -0400
Date: Mon, 9 Apr 2018 11:27:30 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
Message-ID: <20180409092730.2moyhl5aaktjwbyn@flea>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-4-ssuloev@orpaltech.com>
 <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
 <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
 <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
 <20180406073441.xesojvzc3deljhoy@flea>
 <204e97cb-2f39-00f0-fd4e-3aa9a51f7cac@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3txxy5hs7e432z62"
Content-Disposition: inline
In-Reply-To: <204e97cb-2f39-00f0-fd4e-3aa9a51f7cac@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3txxy5hs7e432z62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2018 at 06:48:23PM +0300, Sergey Suloev wrote:
> On 04/06/2018 10:34 AM, Maxime Ripard wrote:
> > On Thu, Apr 05, 2018 at 04:44:16PM +0300, Sergey Suloev wrote:
> > > On 04/05/2018 04:17 PM, Mark Brown wrote:
> > > > On Thu, Apr 05, 2018 at 12:59:35PM +0300, Sergey Suloev wrote:
> > > > > On 04/05/2018 12:19 PM, Maxime Ripard wrote:
> > > > > > The point of that patch was precisely to allow to send more dat=
a than
> > > > > > the FIFO. You're breaking that behaviour without any justificat=
ion,
> > > > > > and this is not ok.
> > > > > I am sorry, but you can't. That's a hardware limitation.
> > > > Are you positive about that?  Normally you can add things to hardwa=
re
> > > > FIFOs while they're being drained so so long as you can keep data
> > > > flowing in at least as fast as it's being consumed.
> > > Well, normally yes, but this is not the case with the hardware that I=
 own.
> > > My a20 (BPiM1+) and a31 (BPiM2) boards behaves differently. With a tr=
ansfer
> > > larger than FIFO then TC interrupt never happens.
> > Because you're not supposed to have a transfer larger than the FIFO,
> > but to have to setup at first a transfer the size of the FIFO, and
> > then when it's (or starts to be) depleted, fill it up again.
>=20
> According to what you said the driver must implement
> "transfer_one_message" instead of "transfer_one"

I'm not sure what makes you think that I said that.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3txxy5hs7e432z62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrLMgEACgkQ0rTAlCFN
r3TtWQ/+MS3bXXuREbEWxlzRndXqFInds1H64yh0YGCQYch+oDERUjei967P+k7h
/1Yhj5JgqF/zjGaf7dUg0Ho3trUuKUfbobjyOYIzKVjmDB3YJdFXqrUoJw5mGKYE
RswK5GhVQY7EoJOZJ6hwT5Kop+6A0BuxbQ9A2oSOwfXFaXnap83mdohjYRgW8ZgH
MpdLUNo1JX+Qxo7KnzGpKJko/u4ewKTm7NnxxkC98BUSRvkBgDn0imAMZK3wBHFz
LqY6GB/iDI65H3iN+2ADcY0A5a3DjoMfqT/Ia9tgExjFbzf6QNgWcD8mmcmE+M5w
soN3FAnyM04CnWDCJpkTLQ76EVKq0gCuuUj5gpCPn8tTOzK8JJ/VOssMG/Almcv9
tdXpy0lPUAmWSyPUQebKAAOJv5sDGz4DfFf+W10+oCmpJMTMoxNBKwJ7jvZufOUp
dK1axDC4HxzuAF+OFNWe4Af13jmKO5qm/rqvn7xmob0JLlhRBqQ9ouov96+7oyJA
RdzWRnBEI0w5Y4rmXQo3X3f9dijW93/+s2EiB4WcUS7vZWdVJr1B6YNv/z/tS0TF
sz+zgUWXr7uvSZO/NtL+xIDaWvVBgG4vCArgCHvzHPDDcygTciAa7Fxq2fPcG7Tc
ExJ1DfXsni1JND0DpMP9o26RWhbqmBPiOD9084vdkSEa/lqRLXQ=
=2Fb8
-----END PGP SIGNATURE-----

--3txxy5hs7e432z62--
