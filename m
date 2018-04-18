Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeDRVX5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 17:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752159AbeDRVX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 17:23:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44F521726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 18 Apr 2018 22:23:51 +0100
From: James Hogan <jhogan@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] MIPS: BCM47XX: Add support for Netgear WNR1000 V3
Message-ID: <20180418212350.GA16439@saruman>
References: <20180408205733.9026-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20180408205733.9026-1-zajec5@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2018 at 10:57:32PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This adds support for detecting this model board and registers some LEDs
> and buttons.
>=20
> There are two uncommon things regarding this device:
> 1) It can use two different "board_id" ID values.
>    Unit I have uses "U12H139T00_NETGEAR" value. This magic is also used
>    in firmware file header. There are two reports (one from an OpenWrt
>    user) of a different "U12H139T50_NETGEAR" magic though.
> 2) Power LEDs share GPIOs with buttons.
>    Amber one seems to share GPIO 2 with WPS button and green one seems
>    to share GPIO 3 with reset button. It remains unknown how to support
>    them and handle buttons at the same time. For that reason they aren't
>    added to the list of supported LEDs.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Thanks, both applied for 4.18.

Cheers
James

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrXt2YACgkQbAtpk944
dnoRLA/+If8qu/oXex/g8kfCD0SCH/8ucvXy/rSn4mpg7G9cfFxPLZrrQT6knlbJ
5nWUbj2mlKQbBUj1dJ0WVDK7dNBgs5qB6TFbjXlcRP1jD2UO8/jZ61ci84u678tT
30hek2tUMjo7YcxGd2AmE/vsgqF58ZuVxBzlwKiWe2S9/zv3YK0ajJD3SK6mBsBL
phtieM5hTeqzUXcqHcnCOamXLJBDHJYekoYxuFWq3Wnb7Bs9xubhQb1Lp0t5/Syf
o+W2pnTXs0N0T/BYYYHnpGTtDK7R3ATbzT16iBbIqN/LVZ+/hdNSzpbOwrYfNq76
QeeAD+qRfM3njl2flZLhTrTcZMIzs+TuAaeGZ9VPUUEMoicxAlbPuiE28OgZ4/v0
os8xB6NY8jWROgU0AHOgNCsDHN3yMqNK7A6ai49SUB11E8NxQPHkrw/QZeo/M69P
ZHoxk4LQnf1nRu4oxcbUe7TBhy8TXgISBqTgu6M9AF2I3rn9Mzz6OFnNRzSm1jxk
eEDtIxiaxrBoHtlnjwAIAMK4e2yqGVMwpDlN/aO2CAtMQWwo/GCQTr4aqmXn3aC/
5hvHJ4jQXdU8CDARijmXh9ZNIkPWv84n9a1Ys52xYHkvAusOy27c7BW63NpTeqHB
N/SlHRXrKWp+rePfVurb6qNo/rEJsA8L2xgAxL0xjTnlP7DStf4=
=uJyg
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
