Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeBVXa5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:30:57 -0500
Received: from anholt.net ([50.246.234.109]:37210 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbeBVXaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:30:55 -0500
From: Eric Anholt <eric@anholt.net>
To: Tuomas Tynkkynen <tuomas@tuxera.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Tuomas Tynkkynen <tuomas@tuxera.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable serial console on RPi 3
In-Reply-To: <87fu6aa02a.fsf@anholt.net>
References: <20180207005309.14365-1-tuomas@tuxera.com> <87fu6aa02a.fsf@anholt.net>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Thu, 22 Feb 2018 15:30:53 -0800
Message-ID: <874lm8r49e.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Eric Anholt <eric@anholt.net> writes:

> [ Unknown signature status ]
> Tuomas Tynkkynen <tuomas@tuxera.com> writes:
>
>> The Raspberry Pi 3 uses the 8250-based auxilary UART of the BCM2837 SoC
>> as the primary serial console of the board, so enable it in the
>> multiplatform defconfig.
>>
>> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
>
> Reviewed-by: Eric Anholt <eric@anholt.net>
>
> I'm planning on putting this in -next once rc1 shows up, unless people
> really want it in -fixes.

Merged to bcm2835-defconfig-next.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqPUq0ACgkQtdYpNtH8
nuhWhxAAm9cZQDyeyG+TzentW2iX+fa7mwX+kKPKGq0w2UVy8Hstum6ORPMvymJ7
ETai9y8LnlF/FUlBsQTE9XLQdpMu+H9/ccjfQeXIXZH/J76OGZQa1FkMIvocjbDM
8PpLoTjEWH97/QxP/XSVKA3rcPGaWNGXZ+eBat8id0MD/pyLGIzKZtSA0fm7icDJ
VahhbHdqPltlbvLUM8iY0PpY9YaiqoWuh4tqhgREYvnbzu6R0IAi6RfERlWEUfFn
PnShid66gEWCSkSNWVnzaEKrgSJDSBi36yAWHY4x7wjdZuFN2nbVWpvKDXNYNAow
xNfTHXSu8ZinQEkr18odCAGcN2P/DPE5GZw3M2Mh9Ujnv6vc/KvU3CkOGnVlJLnv
tK6yPpAhSL5WdW5vgOFIYBCIJLWyvAHjb25SUNi1oTdHuOJM/VEzvldnlaRdrw4Q
S8/bQE+plRJHlGQaPTujpedbJj0zmdXq7yQAWoa1FQJQBXAB2s1CHYL5m2pI3puM
fygEKB6M5Z5X1DItKkVjKgedspFMgVv3UhhqOR0iJ0IEE11G2GX2or+meY2tf8UX
0IHf0mh+dmhfLrP2tdIz4wZRYRZmXEz1lJKd865BGnnUx2/T+B9Lkivqjh8TiU3Q
6LjDGvutKMe/84j1SP0XF9Jeu6iRvE5I71hbNToKUX3S6nHGb68=
=WKOe
-----END PGP SIGNATURE-----
--=-=-=--
