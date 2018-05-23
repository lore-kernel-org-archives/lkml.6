Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeEWJtn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:49:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51774 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932343AbeEWJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:49:36 -0400
Date: Wed, 23 May 2018 10:49:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <groeck@google.com>
Cc: pierre-louis.bossart@linux.intel.com,
        Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        "Patel, Chintan M" <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [alsa-devel] [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Message-ID: <20180523094928.GE4828@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
 <fb9aebba-919a-2e80-aec7-2fd44e5e1861@linux.intel.com>
 <CABXOdTd5+QJHOZ6BcSO-TfJCqcLzdd+Gbnf4HYh9i9cG+UH+1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline
In-Reply-To: <CABXOdTd5+QJHOZ6BcSO-TfJCqcLzdd+Gbnf4HYh9i9cG+UH+1g@mail.gmail.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 02:59:50PM -0700, Guenter Roeck wrote:

> Most people are not aware that they have a backwards compatibility problem
> with the topology file. They will typically notice and report that it is
> impossible to get audio working with an upstream kernel on a recent
> Chromebook, and as users they rarely know about development mailing lists.
> Some technical discussions are at

> https://github.com/GalliumOS/galliumos-distro/issues/379
> https://github.com/GalliumOS/galliumos-distro/issues/274

> though I had seen others earlier. Guess next time I'll have to preserve
> links. Anyway, I am not really much interested in an argument/discussion
> about my use of the term "widely". I'll rephrase that paragraph in the ne=
xt
> version of the patch, should it come to that.

Right, looks like the disconnect I thought it was - this has been
discussed a lot within your distro (and possibly others) but not outside
it so the rest of us are all a bit surprised. =20

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFOScACgkQJNaLcl1U
h9ApxQf/SJ5Eu72VC7VhHmf/bojOTotPNUtRXqeIrMmuJBSuSiJsY85LqExG4eKC
RgTqp0eUyCi0xIv7kWXhzl1xP6XV6wINyoe+PIQE0u6Ehf5/uaxlqnX79ms8cxLH
P855j2hijGgkLaDjqf3lKC8JdrPM4b7BaM8+wjY/es5Q1uTeLw8JvCHHZW6QROYG
2/2SUXhzskJ7fri5t8EH5BmzyupWcOE5vEncGJ0677gMD1A8nA2mBcf648jUF+qK
1TvpTwKiN8DY5LtSHuu7cKV27Wz95tNhyYSMibvTExzOOx04fyfhDic4giMJPi09
NRdMaRPo9QUVkDojwpxSPDuKHQ/67w==
=y/9D
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
