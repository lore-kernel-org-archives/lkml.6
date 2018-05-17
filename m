Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeEQQsC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:48:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58882 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeEQQo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:44:56 -0400
Date: Thu, 17 May 2018 16:21:14 +0900
From: Mark Brown <broonie@kernel.org>
To: "Mahadevan, Girish" <girishm@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Message-ID: <20180517072114.GS20254@sirena.org.uk>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <20180503233849.GF13402@sirena.org.uk>
 <0c26e96c-85ad-c2a2-9abd-33096d76008b@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0lx/R+CYDdR/AN/7"
Content-Disposition: inline
In-Reply-To: <0c26e96c-85ad-c2a2-9abd-33096d76008b@codeaurora.org>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0lx/R+CYDdR/AN/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 02:29:45PM -0600, Mahadevan, Girish wrote:
> On 5/3/2018 5:38 PM, Mark Brown wrote:

> > This is a DT based driver but there is no binding documentation.
> > Binding documentation is required for any new DT stuff.

> The DT documentation for the SPI driver was done as part of this patch se=
ries
> https://patchwork.kernel.org/patch/10318125/=20

I can't follow the link as I'm working offline but since I've no record
of having seen a copy of any bindings for review and I'm fairly sure I'd
have remembered any bindings without code I'm very disappointed -
bindings should be being reviewed by the relevant maintainers just like
code.

Fortunately as far as I can tell whereever you sent that to it doesn't
seem to have been applied but that makes it even more disappointing that
they're not being sent.

=2E..

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--0lx/R+CYDdR/AN/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9LWkACgkQJNaLcl1U
h9AIxAf+KLiYUADjRtmwz1fuV8DJoSTNw5zZFh33/YHqqVlqKmANHlLuiBz0Oigx
qKR4ikl+O9lkixub4Vml30JurgAfAuzQ8VBOpCY0upuzrV0Ssje12nLus2F9ewoX
3UznB6iggbXghA++mHvF7XZjkwKai4XeqaW5LdGVl4spY/8VPV3O2IuoyXSK5/8Q
H1sGMNGPdcIYZfSpc5AgXap5DPl5be5QPHBQzow8faUxBc2BpMldzUt2aqBAH8GO
sxqYuj+Vy1nuV9d6koOnLAQIcknrt0qp74SgDfpDagn9Ng9GBB6Ba8gYIu8EZ/C6
V0E7k7bM3+YCNa0QWLvSYF9MLMEtqg==
=e3Nf
-----END PGP SIGNATURE-----

--0lx/R+CYDdR/AN/7--
