Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1811EECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAA7208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAA7208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeIQB0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:26:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47106 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbeIQB0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:26:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A5D9E27DB36
Received: by earth.universe (Postfix, from userid 1000)
        id 1A8B63C0C46; Sun, 16 Sep 2018 13:12:54 +0200 (CEST)
Date:   Sun, 16 Sep 2018 13:12:54 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, gpain@baylibre.com
Subject: Re: [PATCH v2 0/3] power: supply: cros: add support for dedicated
 port and expose connected ports
Message-ID: <20180916111254.iapirc4utba4kkzj@earth.universe>
References: <20180810131349.3883-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fioddoivingr7mgd"
Content-Disposition: inline
In-Reply-To: <20180810131349.3883-1-fparent@baylibre.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fioddoivingr7mgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 10, 2018 at 03:13:46PM +0200, Fabien Parent wrote:
> Dear all,
>=20
> This patch series adds support for an optional dedicated port
> to the ChromeOS power supply driver and adds a new property that expose
> when a power supply is connected. The series was tested on ChromeOS "Fizz"
> hardware.
>=20
> This patch series depends on the following patch serie which adds
> the ChromeOS power supply driver:
>  * https://lkml.org/lkml/2018/5/2/585 [PATCH v4 0/3] mfd/power: cros_ec: =
add
>    support for USBPD charger driver
>=20
> The ChromeOS power supply driver also depends on the following patches to=
 be
> applied:
>  * https://lkml.org/lkml/2018/4/23/602 ([PATCH v8 0/6] typec: tcpm: Add
>    sink side support for PPS)
>  * https://lkml.org/lkml/2018/4/18/229 ([RESEND PATCH v5 4/7] mfd:
>    cros_ec_dev: Register cros-ec-rtc driver as a subdevice.)
>=20
> Best Regards,
> Fabien
>=20
> V2:
>   * Rebased to fixed apply issue with patch #2
>=20
> Fabien Parent (3):
>   mfd: cros: add charger port count command definition
>   power: supply: cros: add support for dedicated port
>   power: supply: cros: add property to detect connected ports

I prepared an immutable branch for patch 1+2 and merged it into
power-supply-next. I will push out the branch and send a pull
request for the immutable branch to Lee later (once I have Internet
connection).

-- Sebastian

>  drivers/power/supply/cros_usbpd-charger.c | 126 +++++++++++++++++++---
>  include/linux/mfd/cros_ec_commands.h      |  10 ++
>  2 files changed, 122 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.18.0
>=20

--fioddoivingr7mgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueOrUACgkQ2O7X88g7
+pqP0Q/+K/+lqnuTAU6NxzMJkFPBFSQ5k+dcnixaqnYrAjuwwcejGO8soyGo4tpl
LF1OIeeQKXxdTJhSIBFGQhrPgDIzKRX8u3z1/rmYgrjxFtZwGusWvtvdF4xbTrgL
ZpQP1Y5MREKv7hKig20Nsw+g9IkJGaHk0qZpyHLPpIi0YcKYRQNnumk+Vns3g7Wn
ilc6wNW+fODI/jJQD4Md8UIKyqOP3Rk9Q92KUmfGNb86ip8cvGUj62LIG+ZoveLP
/vwesoWKCtq+M2O0ykxt/dCNZGwYcVmLevoRE6SWWN8h8XUZiSUn42lXuY+QrVyq
gAizheqniYwo1YErTmKGa2coeB2hxbBrA3EbzYKEGqFW5CvWBgTU0kAfqFn0FKWy
qzCDB/f9JFUJViYTWDbgT3KhDHaMZVMxeZhjujoLZ31fVFYsWbQ2QvREnMcGZSbZ
/HzbeUDXmRKmrBHrGq1wsNFsnjYzwEXDEBEfgufARM6hklvjw4BliKirPwk+CWUw
o99AxruxoIo+2rhwC9YWiXEQl2391L+sMEI2rVfkYewrVrwmwC2wuvDJvzyuaxC6
KLuSn8XHa1Lm3GK28Ws/JT3kVerXTwKZb4iW+3KOgX0ZcEM+Y6AFPkAm8ujpslJC
x2whjMvSi084CvxZfi+wN09nf+JSvxMiwhgZSkQ1tjsrUkvhxnI=
=E2Uj
-----END PGP SIGNATURE-----

--fioddoivingr7mgd--
