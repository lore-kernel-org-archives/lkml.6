Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967328AbeCAKYk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:24:40 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37717 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966289AbeCAKYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:24:35 -0500
X-Google-Smtp-Source: AG47ELsRBSzKsilNrsMZTVg1OaJ6uF5MiTdtHnLgYbE/we8yWWqZmZMcaZGm617Z3Xuljdo889puZA==
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <D5C55585-6CB6-4F47-9AD0-6CE961BA1392@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_ED1D8CEC-8351-4A7E-9F4F-CE0937B9F135";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH V2] lightnvm: pblk: remove unused variable
Date: Thu, 1 Mar 2018 11:24:30 +0100
In-Reply-To: <2cf2565b-0a2c-ecba-ea55-9a63591d8f93@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1519833444-28160-1-git-send-email-javier@cnexlabs.com>
 <2cf2565b-0a2c-ecba-ea55-9a63591d8f93@lightnvm.io>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_ED1D8CEC-8351-4A7E-9F4F-CE0937B9F135
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 1 Mar 2018, at 11.07, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/28/2018 04:57 PM, Javier Gonz=C3=A1lez wrote:
>> # Changes since V1:
>>  - Rebase on top of latest 2.0 changes
>> Javier Gonz=C3=A1lez (1):
>>   lightnvm: pblk: remove unused variable
>>  drivers/lightnvm/pblk-core.c | 3 ---
>>  1 file changed, 3 deletions(-)
>=20
> Okay if I merge this with Hans' patch? It has not gone upstream yet.

Of course!

Javier

--Apple-Mail=_ED1D8CEC-8351-4A7E-9F4F-CE0937B9F135
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlqX1N4ACgkQYx8FO3WZ
GMrNmQ/+KVesNj1NbBlHdrbgW1CVgwau5syMCyq30tsBCqmLTPXZ5KbX+SRxp5oA
d8cRej2ZdTYy8kXtGo4/ugEO/XOcqjzVaS7YpHox6cWx5U6BDPTQj/UOVT5K9MsU
rIc6fIcWFkqGdibcUn+xW/E92j8qpyzSxd75VJF+kSlAaL01g/ksmapBJDpZ77EF
subHy+znPR9t90ahB+s2wtTbWkGjaVux/jEHFdmwYsaUtWavrzEqCM3InX/xGqpj
BVFaD/OQQFaeeaeTXbOJV5qDVh/IXExKPxbOWrBuEzjWB1OLvBOZcKtlAHPHYm37
KN177qReqiDT8yShpP9FsvKfXaMEYc4TsZGUpNbcR/CWAJojIxkSQPo7rjFYv3E5
Ajzrvdwd6KbYZgsA0iAESvy8iC8fb4OF3sq6M5anDA+yyz8TuqA4ZbyKURgEhvV/
CQePUNCOIz66Sj2KRJhpdZfg7ho+U+vkGLK8wHidFKLXHMDyhx6o1ULa7Sckhnd0
swSIa/yFRqZ4hZjqrQii3Qr2Fo/KSNUe3fZuGIs/1VfKixGzoFBsBwTtmiJgsQu5
swiP1x1x2npmibUkgKt46Bs8M/vijcWmvNBs2D3dMRvIdQvaHNR6zK8R/jKS68cb
/F1oyOexVTOMSK83Di8yQNggDXP2r6QcQ2FLm2S3YgVJkAs0X4Q=
=b00f
-----END PGP SIGNATURE-----

--Apple-Mail=_ED1D8CEC-8351-4A7E-9F4F-CE0937B9F135--
