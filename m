Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757571AbeD0Hza (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:55:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57113 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757171AbeD0Hz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:55:29 -0400
Subject: Re: [PATCH 3/3] can: xilinx: fix xcan_start_xmit()'s return type
To: Michal Simek <michal.simek@xilinx.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support"
        <linux-arm-kernel@lists.infradead.org>
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
 <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
 <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; keydata=
 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
 /6jKeO1yNpD5UgI9bzazBn1mwg==
Message-ID: <02e9be66-1345-2af7-c343-9f94d71e1d10@pengutronix.de>
Date: Fri, 27 Apr 2018 09:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="a0N71STmDqwIaEjEwpwlvAE1gODqyBfn0"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a0N71STmDqwIaEjEwpwlvAE1gODqyBfn0
Content-Type: multipart/mixed; boundary="yMCF53i8VnKTXXbP8dYxRYUP4gwEfGa9R";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Michal Simek <michal.simek@xilinx.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
Message-ID: <02e9be66-1345-2af7-c343-9f94d71e1d10@pengutronix.de>
Subject: Re: [PATCH 3/3] can: xilinx: fix xcan_start_xmit()'s return type
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
 <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
 <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>
In-Reply-To: <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>

--yMCF53i8VnKTXXbP8dYxRYUP4gwEfGa9R
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 09:49 AM, Michal Simek wrote:
> On 26.4.2018 23:13, Luc Van Oostenryck wrote:
>> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
>> which is a typedef for an enum type, but the implementation in this
>> driver returns an 'int'.
>>
>> Fix this by returning 'netdev_tx_t' in this driver too.
>>
>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> ---
>>  drivers/net/can/xilinx_can.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can=
=2Ec
>> index 89aec07c2..a19648606 100644
>> --- a/drivers/net/can/xilinx_can.c
>> +++ b/drivers/net/can/xilinx_can.c
>> @@ -386,7 +386,7 @@ static int xcan_do_set_mode(struct net_device *nde=
v, enum can_mode mode)
>>   *
>>   * Return: 0 on success and failure value on error
>>   */
>> -static int xcan_start_xmit(struct sk_buff *skb, struct net_device *nd=
ev)
>> +static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_de=
vice *ndev)
>>  {
>>  	struct xcan_priv *priv =3D netdev_priv(ndev);
>>  	struct net_device_stats *stats =3D &ndev->stats;
>>
>=20
> It was applied already but there should be also kernel-doc update too t=
o
> use enum values instead of 0.

Like this:

> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.=
c
> index f07ce4945356..d0ad1473f689 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -398,7 +398,7 @@ static int xcan_do_set_mode(struct net_device *ndev=
, enum can_mode mode)
>   * function uses the next available free txbuff and populates their fi=
elds to
>   * start the transmission.
>   *
> - * Return: 0 on success and failure value on error
> + * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY when the tx queu=
e is full
>   */
>  static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_dev=
ice *ndev)
>  {

I can squash in that change.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--yMCF53i8VnKTXXbP8dYxRYUP4gwEfGa9R--

--a0N71STmDqwIaEjEwpwlvAE1gODqyBfn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlri12QACgkQk9IU1zQo
ZfHqwAf/cqCG3AErm/iOoSOY2W215bY+HgZ3uH7ZSO04WMQ6tU02XV6T7S8nWi/V
DWQKPhdaxg19A6FooOWmb7s6TJq9eVOerKhce2M8R7z+835gfXryOxi6M4elxWHh
mIrgvsJzCOKjtuOZE8LOpBkxtPBLcS0TVDEOva5RrinFOCcNU/nKmBDvK3LHE6f5
oVSCzjn4dXf6pk59qkmoVA3T+nUZYPzNT+wOiVnR4JB1Zpm96Lry4wCY8XS+WNJ0
6Vz8xdCP86x8OAHW1Vn5+dgWi/BR3jAA2LMNRbKZ8mHti3g1hSHKv2WmdmdQnwdU
qRmXV0NQ+uYavpdOf/76l/ljk38/MQ==
=jjQ4
-----END PGP SIGNATURE-----

--a0N71STmDqwIaEjEwpwlvAE1gODqyBfn0--
