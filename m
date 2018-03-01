Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161702AbeCAUmM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:42:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33532 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161629AbeCAUmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:42:09 -0500
Date: Thu, 1 Mar 2018 20:42:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Rohit Kumar <rohitkr@codeaurora.org>
Cc: srinivas.kandagatla@linaro.org, andy.gross@linaro.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, david.brown@linaro.org, robh+dt@kernel.org,
        spatakok@qti.qualcomm.com, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH v3 05/25] ASoC: qcom: qdsp6: Add support to
 Q6AFE
Message-ID: <20180301204200.GQ12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
 <2465335e-4d45-02d7-2e64-0a1c28a44ff1@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4T94Hejb80K+e1gX"
Content-Disposition: inline
In-Reply-To: <2465335e-4d45-02d7-2e64-0a1c28a44ff1@codeaurora.org>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4T94Hejb80K+e1gX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 04:00:32PM +0530, Rohit Kumar wrote:
>=20
> On 2/13/2018 10:28 PM, srinivas.kandagatla@linaro.org wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >=20
> > This patch adds support to Q6AFE (Audio Front End) module on Q6DSP.
> >=20
> > AFE module sits right at the other end of cpu where the codec/audio
> > devices are connected.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--4T94Hejb80K+e1gX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYZZgACgkQJNaLcl1U
h9DtOAf+JOjxq69qku/Nea4t7d4rn53+qUcNeXlMiCV53Qv3E0blYecahZ6X6UIL
MeYtK2Z2mXMReoW7pvtjXawZv/FvKmGgtJZGP2Od1IkKXKls4fn/W7fOtFJZjbu9
9UsBBw+f95LMi/2BxnFVizw05UJllYTCpXbE1F7/eBQhSRiwD/huUNHKD83RRn0n
xtiLXxIESBpbsBh4zmpMb4HoDr4x+r1z3/jpT6ErMOOaIl3igVvIPff14jBUXjw4
5MpsmlQncXgFQtYuixB25bFQCCCdlMA3u5GZWgHg1gvZsRQO4mYErw6mmPEI+Gog
W6fNi7Cq2UpUd1EZoyaPD1GhqqVTig==
=k78j
-----END PGP SIGNATURE-----

--4T94Hejb80K+e1gX--
