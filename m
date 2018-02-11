Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeBKKJB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:09:01 -0500
Received: from anholt.net ([50.246.234.109]:32798 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752288AbeBKKJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:09:00 -0500
From: Eric Anholt <eric@anholt.net>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Print the pid when debug logging an ioctl error.
In-Reply-To: <20180131080728.GV25930@phenom.ffwll.local>
References: <20180130215643.11016-1-eric@anholt.net> <20180131080728.GV25930@phenom.ffwll.local>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Sun, 11 Feb 2018 10:07:00 +0000
Message-ID: <87d11bsuuz.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Daniel Vetter <daniel@ffwll.ch> writes:

> On Tue, Jan 30, 2018 at 01:56:43PM -0800, Eric Anholt wrote:
>> When we debug print what ioctl we're calling into, we include the pid.
>> If you have multiple processes rendering simulataneously, the error
>> return also needs the pid so you can see which of the ioctl calls was
>> the one to fail.
>>=20
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Pushed.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqAFcQACgkQtdYpNtH8
nuijLhAAmHi1fNv5rbat15UnIcRUgqo0ZwafHlOxoFOd89z8lK1oH3CZieRxjigO
o/kszrnK4hlD9jLfJT/tN084On/+/87oRmYRtX7hjaw3EJhIlkzCHM2PZJOphGNK
U5VcWArEqKK+Lu5d18BAJm3vW8gyIipAqJU2/FPe8wwpuJTvzjqbKpCrO8IPKuGS
Pf4WRRGI1mmYSr+uz4exzIEUN+sDn8Ub0u408b8SZuxr51ooYVNWJhd3XmyaoXtI
NNzejxMES+JopthotsRvos6hIX9ZCpUcLurx0oB0GXDGuex65YkUf4/H2QFVGIk8
f1MTi6S9L4JlKcF1n7xDSKR0sfdHFtGGal/ODGn+BOQDL0ZE8QtCjDGbfmmLf990
hTISud384Y+x0FZTB9jnfiRIv9ROvdlE2hLHv6ygC/raN/wtyHbY3Znbi3NosvfY
tU0oBNdt3gJ5Zx6uxeu8t2HV7MnGfF4G7nWWGbHhZPNQ4dDonVZ7Gu0FcLI05l6b
A1QNV++NFTzQ/Bf0rXjanUdpxQX3v9olezM/aHTnWZK+DHbnBVmnA8hHwuYSA7Mj
+XcXlsCMUHp8+3bGOH7AzTF+rQHQ+RYbC9EHxu3j+a6hHttCn1sckAi/03OZgtAu
VfYpBeokKkpqsdKxuo3jigEGGOp+oZLqiSEYiE9tROP8d34q2YA=
=ceub
-----END PGP SIGNATURE-----
--=-=-=--
