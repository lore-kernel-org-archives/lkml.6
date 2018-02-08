Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeBHPnD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:43:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37404 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeBHPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:43:02 -0500
Date: Thu, 8 Feb 2018 15:42:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: use seq_file to dump the contents of
 dai_list,platform_list and codec_list
Message-ID: <20180208154252.GB27520@sirena.org.uk>
References: <20180118053126.22082-1-dolinux.peng@gmail.com>
 <CAHp75VcefO1L-E8ymHX7MibLiOXkRZ3+3FbkF_L+ywMV-i3Mvw@mail.gmail.com>
 <20180123173732.GI7600@sirena.org.uk>
 <CAErzpmt5Z_bVkO-86yCNNWMNSYXWMzvABGtTEuYV1Y1qk=2LJQ@mail.gmail.com>
 <CAHp75Ve-Nq+hbzf9XRDjQrMz_W7BCSW_58o_vA0H1RGqEFpYrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <CAHp75Ve-Nq+hbzf9XRDjQrMz_W7BCSW_58o_vA0H1RGqEFpYrA@mail.gmail.com>
X-Cookie: I'm wet!  I'm wild!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 08, 2018 at 04:25:10PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 26, 2018 at 9:16 AM, Donglin Peng <dolinux.peng@gmail.com> wrote:

> > I can send another patch after the following patch is merged:
> > https://patchwork.kernel.org/patch/10178813/

> It's merged. I think whenever Mark switched his repositories for new
> cycle you may be able to submit a patch.

Send it any time, I'll just not apply it until after -rc1 comes out.

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp8b/sACgkQJNaLcl1U
h9B+RQf/YFk9qt6DHq6reakGRMOM2xxvCCq8vLPQD1kAMjyfQheixI7FeBXQ5PAN
IEFTEcYouC+qIEoiIBQA40VROVDm2RUTkuzFgAxSA36m6pEVnqbRYQG/GFI/HUIm
tOpVN8frG5FDKwX9C6iG3p6M6hesT6BUR0JRarTns7jo+vg+PplorW/1zn+UL4K0
1aJc7YGdJ4N/J2ceImTyMqyOUxWM6Eb6gEjk3pLu5tLiWSUiFkPprWoSIhyBEP/B
n+TbeJvDZXUNUDKl5FAibyywsIaxQIZNQo+KZfhH/k68DEXX8Yq7qnRTOWZHirrl
7UJa4pxxdbgqEGinZJX6MN1pevhmEA==
=8eH5
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
