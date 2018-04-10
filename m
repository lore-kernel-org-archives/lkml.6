Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeDJTj0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:39:26 -0400
Received: from anholt.net ([50.246.234.109]:35602 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752107AbeDJTjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:39:25 -0400
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, Jon Mason <jonmason@broadcom.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] drm/vc4: Remove the need for the GPU-subsystem DT node.
In-Reply-To: <8806871.109949.1523384893773@email.1und1.de>
References: <20180409230040.1100-1-eric@anholt.net> <8806871.109949.1523384893773@email.1und1.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Tue, 10 Apr 2018 12:39:22 -0700
Message-ID: <87efjmq2ad.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 10. April 2018 um 01:00 geschrieben:
>>=20
>>=20
>> The GPU subsystem node was a workaround to have a central device to
>> bind V3D and display to.  Following the lead of 246774d17fc0
>> ("drm/etnaviv: remove the need for a gpu-subsystem DT node"), remove
>> the subsystem node usage and just create a platform device for the DRM
>> device to attach to if any of the subsystem devices are present.
>
> i didn't test it. Does the code change keep the backward compatibility wi=
th older DT?

Yes.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlrNEuoACgkQtdYpNtH8
nuhUWg//UGmPNTa+rJb7kiaYTKyB/d4e4Gxawk7qcPsrBflg+i4AShAXO2JNJ6Cn
BfCm1nhmY5J/Ucsa2XDt4uinpGb/0+A04gMNNtv2vqcoxeTBs3JMaB3TQLiEO0Sq
LU9yTfR0z+NQRkPxFKlJ49n5FDymKJr1K1r95z2MAqGLkH0Cm9S08IIfCcG3aToa
TxYuST/EJmCf54VcW7tN9O8MieFhhz2aBE+YEP+Wkxf9FkY1bmXonsMfLRoGR21R
IRdXxm/SvBj672E6R0nWai+/7ePe5EG17NNR4WfNZs0L8iUoyeDlV8EZm/f8nN0b
qIZhyKRWxxG1ebnR+BWSFEPXJS2HEt+s3cNIZ65R6tmBeHx3sWr81pM2Z+r/79au
oA+LRuNtK/ZoTYcw+0OeMzNU53fJ6vPK7/6juJLC9fHQQvy7fpDTLCMjl/iEfeIq
XfBFqRzdvD6i/Zac0Q1kJWfkt3Ys2Yh3z0rGg/tebaiUQD8QU9cUIo0WTatZMcpX
y7VTonCwWNVKC/z6k8QUXF04Vubh03GuqBF9fccgb+O0uGA4rx3SK8L/+MzSlOFX
A4gO6FlLQSOIolfsKVqN2oX8kTX7Rxw5lpZeJWpyTMTsw+BcFQwgZ+rGnnyGKIBM
8xRYBiyPtVmifGK+UGUAaodNRCiiLPE03ovjvFf8LXEql6ACW2Q=
=n38c
-----END PGP SIGNATURE-----
--=-=-=--
