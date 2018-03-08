Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933854AbeCHQio (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:38:44 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34978 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCHQil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:38:41 -0500
X-Google-Smtp-Source: AG47ELsGE3yIwqIOwtvq4LIVMNK/sLc+beVgtWW/VbA7dC1eNob3adPc+lFU6D5wbcpjM3H4wjvjIQ==
Date: Thu, 8 Mar 2018 17:38:37 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: mjg59@srcf.ucam.org, dvhart@infradead.org, andy@infradead.org,
        mario.limonciello@dell.com, tiwai@suse.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 2/3] platform/x86: dell-*: Add interface for
 switchable graphics status query
Message-ID: <20180308163837.myfmnowz5ogto52w@pali>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-2-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qk6dsxcavtjhuczj"
Content-Disposition: inline
In-Reply-To: <20180308091023.9061-2-kai.heng.feng@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qk6dsxcavtjhuczj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 08 March 2018 17:10:22 Kai-Heng Feng wrote:
> +int dell_switchable_gfx_enabled(bool *enabled);

What about following API?

bool dell_switchable_gfx_is_enabled(void);

Are you really interested in errors? Then what about?

int dell_switchable_gfx_is_enabled(void);

with e.g.
  < 0 - error
  =3D 0 - disabled
  > 0 - enabled

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--qk6dsxcavtjhuczj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWqFnBgAKCRCL8Mk9A+RD
Uv37AKDH/cgvznJjDKcmEdMbu1ruHksJogCfV+C3N7NwJFZfaToBx9dNPNj7ze4=
=lj6p
-----END PGP SIGNATURE-----

--qk6dsxcavtjhuczj--
