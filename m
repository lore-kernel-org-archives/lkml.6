Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964983AbeBPL2U (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:28:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964876AbeBPL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:28:18 -0500
Date: Fri, 16 Feb 2018 11:28:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Dylan Reid <dgreid@chromium.org>, huang lin <hl@rock-chips.com>
Subject: Re: [PATCH v2] ASoC: dmic: Add optional wakeup delay
Message-ID: <20180216112801.GA5886@sirena.org.uk>
References: <20180216022416.208265-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20180216022416.208265-1-mka@chromium.org>
X-Cookie: To order, call toll-free.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2018 at 06:24:16PM -0800, Matthias Kaehlcke wrote:
> On some systems a delay is needed after switching on the clocks, to allow
> the output to stabilize and avoid a popping noise at the beginning of
> the recording. Add the optional device tree property 'wakeup-delay-ms'

This doesn't apply against current code, please check and resend.

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqGwEEACgkQJNaLcl1U
h9AhxAf+OMp8YPVcDHKlQ9hvGMp+Wo5/kt05Z40IG95300cIdm2LWq4nbvpkTbsH
FyI/cqShtZ/6dX+xoJtp2VPu+SHoGEQkrS07bCPHCMFaAWSlf4MEMi9Xt0KwWRSv
UtVaheEedTwRL+VlLFWXGy7/6GhPM33TFxk09cmOXNBD0a46AxEwynkbpJlwqtac
R4dWBo5rV4r5T8J8EWvPBy52e+ClsDJRgQDnvr6wvmkTPiH0xlQO8LMWF9wPUg8y
LJD9JXlWEC6mfSQ6c7TndyX0g0/inQ36/nus5Dawhbcq9d/hBALeSPzIg7PBt4PX
rnVsyymY7JDWcnl4pz97uyVbOTfFUw==
=DPeM
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
