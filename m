Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933882AbeCMQWr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:22:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33899 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932695AbeCMQWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:22:45 -0400
Subject: Re: [PATCH][next] ASoC: samsung: remove redundant pointer cpu_dai
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180313133626.31286-1-colin.king@canonical.com>
 <20180313162138.GQ2186@sirena.org.uk>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <1db711ff-63ba-7a0e-dc9d-33638bd4a0d9@canonical.com>
Date: Tue, 13 Mar 2018 16:22:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313162138.GQ2186@sirena.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NmhQ8UuReUGrKkEw16050u7Y6wETHqa6I"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NmhQ8UuReUGrKkEw16050u7Y6wETHqa6I
Content-Type: multipart/mixed; boundary="7ATi9oyvZgQiuPffh01VtWsIZvRkXEuM6";
 protected-headers="v1"
From: Colin Ian King <colin.king@canonical.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim
 <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1db711ff-63ba-7a0e-dc9d-33638bd4a0d9@canonical.com>
Subject: Re: [PATCH][next] ASoC: samsung: remove redundant pointer cpu_dai
References: <20180313133626.31286-1-colin.king@canonical.com>
 <20180313162138.GQ2186@sirena.org.uk>
In-Reply-To: <20180313162138.GQ2186@sirena.org.uk>

--7ATi9oyvZgQiuPffh01VtWsIZvRkXEuM6
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13/03/18 16:21, Mark Brown wrote:
> On Tue, Mar 13, 2018 at 01:36:26PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The pointer cpu_dai is assigned a value but the pointer is never
>> read, hence it is redundant and can be removed.
>=20
> There's some subsequent patches to that driver which I think provide an=

> alternative fix for this.
>=20
OK, glad it's been resolved.


--7ATi9oyvZgQiuPffh01VtWsIZvRkXEuM6--

--NmhQ8UuReUGrKkEw16050u7Y6wETHqa6I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEEcGLapPABucZhZwDPaMKH38aoAiYFAlqn+tEZHGNvbGluLmtp
bmdAY2Fub25pY2FsLmNvbQAKCRBowoffxqgCJk0FD/9EwjzOc/DkqLjwN58bPtUM
3KwUDNe29LLLRSFT9bBIZqpTFFAU0e/V6ThOMXl+ft0RaC+48xlf/i2+nqIgYx2z
5YsX8rYzbJAEN+wqT7LxHBYRUgzKCqVA+mjaxT1bbIgwK5V44gjlJGEAjNEIm8GA
BP+pdd3pHhcuuWMxivW8fFO5eaLlotM0N2S8fX0UruftkdpHYPn9lw1o3UmFVphE
+T62O2I7JI7+3guiYfM5vYMgJQf76+RVaKr1gw+7KQLNo2h0/G2Pes02d2Zpw6Le
0vuZ1/x03PFyvVwvdS74xEpKZiSM9fN3oPF3DZEx0j0xBbidOlM8BjfKmRKJbQIq
UpREasYvwUxOv2cmA4hhJQTYl+4q+YLsrsFBVts2sY3E3GEBLNJ1WcSwWbcVoC/m
ngPIz2suOu4RM+ookZg+bBr7UvomRvOVFj6myrrJ9IMCtgFGqaxVHEYPmDG5IuCt
Sx7xI+EKs/cmvKHqKan6iyXdEf+EMoCmGfzG0utVLh1gf18PFO+5NQ5V+DLRN3jI
H2uhuTYJuuIpKt5ftPE45XkD80jiJliPk+8JDeT/uV/q8qVBiYGZabCINlM0/gtO
8dOm0BIpaGCO3Wt3mPkFt6xuIFAZj0AIeypEcSOBcIFA12BS+w5pxz9FsDPAZe1V
kAxQyvwmgIjCdD1VTARwog==
=wjy8
-----END PGP SIGNATURE-----

--NmhQ8UuReUGrKkEw16050u7Y6wETHqa6I--
