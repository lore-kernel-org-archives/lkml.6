Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeC0KUa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:20:30 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:55657 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750944AbeC0KU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:20:28 -0400
Subject: Re: [PATCH v3 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: kbuild test robot <lkp@intel.com>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: kbuild-all@01.org,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180322135338.60923-2-jakob.unterwurzacher@theobroma-systems.com>
 <201803241907.upf6wIeD%fengguang.wu@intel.com>
From: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Message-ID: <f7c6d781-f21a-a6be-8f08-9f20ef894ca3@theobroma-systems.com>
Date: Tue, 27 Mar 2018 12:20:24 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201803241907.upf6wIeD%fengguang.wu@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="01tdxIkAqKbT1KwfpqHebZ2qvoOP2qH7u"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--01tdxIkAqKbT1KwfpqHebZ2qvoOP2qH7u
Content-Type: multipart/mixed; boundary="lLsR4B87ko5jN409ukahbqyzReDlj37IA";
 protected-headers="v1"
From: Martin Elshuber <martin.elshuber@theobroma-systems.com>
To: kbuild test robot <lkp@intel.com>,
 Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: kbuild-all@01.org, Philipp Tomsich
 <philipp.tomsich@theobroma-systems.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <f7c6d781-f21a-a6be-8f08-9f20ef894ca3@theobroma-systems.com>
Subject: Re: [PATCH v3 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
References: <20180322135338.60923-2-jakob.unterwurzacher@theobroma-systems.com>
 <201803241907.upf6wIeD%fengguang.wu@intel.com>
In-Reply-To: <201803241907.upf6wIeD%fengguang.wu@intel.com>

--lLsR4B87ko5jN409ukahbqyzReDlj37IA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: de-AT

fixed and rechecked again with sparse

Am 24.03.18 um 12:43 schrieb kbuild test robot:
> Hi Jakob,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on net-next/master]
> [also build test WARNING on v4.16-rc6]
> [cannot apply to next-20180323]
> [if your patch is applied to the wrong git tree, please drop us a note =
to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Jakob-Unterwurzacher/c=
an-ucan-add-driver-for-Theobroma-Systems-UCAN-devices/20180324-164143
> reproduce:
>         # apt-get install sparse
>         make ARCH=3Dx86_64 allmodconfig
>         make C=3D1 CF=3D-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> drivers/net/can/usb/ucan.c:301:16: sparse: restricted __le32 degrades=
 to integer
>    drivers/net/can/usb/ucan.c:414:32: sparse: incorrect type in argumen=
t 5 (different base types) @@    expected unsigned short [unsigned] [user=
type] value @@    got  short [unsigned] [usertype] value @@
>    drivers/net/can/usb/ucan.c:414:32:    expected unsigned short [unsig=
ned] [usertype] value
>    drivers/net/can/usb/ucan.c:414:32:    got restricted __le16 [usertyp=
e] <noident>
>    drivers/net/can/usb/ucan.c:428:32: sparse: incorrect type in argumen=
t 5 (different base types) @@    expected unsigned short [unsigned] [user=
type] value @@    got  short [unsigned] [usertype] value @@
>    drivers/net/can/usb/ucan.c:428:32:    expected unsigned short [unsig=
ned] [usertype] value
>    drivers/net/can/usb/ucan.c:428:32:    got restricted __le16 [usertyp=
e] <noident>
>    drivers/net/can/usb/ucan.c:683:44: sparse: incorrect type in argumen=
t 2 (different base types) @@    expected unsigned long [unsigned] [usert=
ype] size @@    got d long [unsigned] [usertype] size @@
>    drivers/net/can/usb/ucan.c:683:44:    expected unsigned long [unsign=
ed] [usertype] size
>    drivers/net/can/usb/ucan.c:683:44:    got restricted __le16 [usertyp=
e] wMaxPacketSize
>    drivers/net/can/usb/ucan.c:700:44: sparse: incorrect type in argumen=
t 2 (different base types) @@    expected unsigned long [unsigned] [usert=
ype] size @@    got d long [unsigned] [usertype] size @@
>    drivers/net/can/usb/ucan.c:700:44:    expected unsigned long [unsign=
ed] [usertype] size
>    drivers/net/can/usb/ucan.c:700:44:    got restricted __le16 [usertyp=
e] wMaxPacketSize
>    drivers/net/can/usb/ucan.c:752:25: sparse: cast to restricted __le16=

>    drivers/net/can/usb/ucan.c:779:36: sparse: incorrect type in argumen=
t 5 (different base types) @@    expected int [signed] buffer_length @@  =
  got restricted __le1int [signed] buffer_length @@
>    drivers/net/can/usb/ucan.c:779:36:    expected int [signed] buffer_l=
ength
>    drivers/net/can/usb/ucan.c:779:36:    got restricted __le16 [usertyp=
e] wMaxPacketSize
>    drivers/net/can/usb/ucan.c:793:54: sparse: incorrect type in argumen=
t 2 (different base types) @@    expected unsigned long [unsigned] [usert=
ype] size @@    got d long [unsigned] [usertype] size @@
>    drivers/net/can/usb/ucan.c:793:54:    expected unsigned long [unsign=
ed] [usertype] size
>    drivers/net/can/usb/ucan.c:793:54:    got restricted __le16 [usertyp=
e] wMaxPacketSize
>    drivers/net/can/usb/ucan.c:853:62: sparse: incorrect type in argumen=
t 2 (different base types) @@    expected unsigned long [unsigned] [usert=
ype] size @@    got d long [unsigned] [usertype] size @@
>    drivers/net/can/usb/ucan.c:853:62:    expected unsigned long [unsign=
ed] [usertype] size
>    drivers/net/can/usb/ucan.c:853:62:    got restricted __le16 [usertyp=
e] wMaxPacketSize
>    drivers/net/can/usb/ucan.c:877:61: sparse: incorrect type in argumen=
t 2 (different base types) @@    expected unsigned long [unsigned] [usert=
ype] size @@    got d long [unsigned] [usertype] size @@
>    drivers/net/can/usb/ucan.c:877:61:    expected unsigned long [unsign=
ed] [usertype] size
>    drivers/net/can/usb/ucan.c:877:61:    got restricted __le16 [usertyp=
e] wMaxPacketSize
>    drivers/net/can/usb/ucan.c:891:44: sparse: incorrect type in argumen=
t 5 (different base types) @@    expected int [signed] buffer_length @@  =
  got restricted __le1int [signed] buffer_length @@
>    drivers/net/can/usb/ucan.c:891:44:    expected int [signed] buffer_l=
ength
>    drivers/net/can/usb/ucan.c:891:44:    got restricted __le16 [usertyp=
e] wMaxPacketSize
>>> drivers/net/can/usb/ucan.c:1238:41: sparse: incorrect type in assignm=
ent (different base types) @@    expected restricted __le16 [usertype] sa=
mple_point @@    got restricted __le16 [usertype] sample_point @@
>    drivers/net/can/usb/ucan.c:1238:41:    expected restricted __le16 [u=
sertype] sample_point
>    drivers/net/can/usb/ucan.c:1238:41:    got restricted __le32 [userty=
pe] <noident>
>    drivers/net/can/usb/ucan.c:1368:18: sparse: restricted __le16 degrad=
es to integer
>    drivers/net/can/usb/ucan.c:1373:19: sparse: restricted __le16 degrad=
es to integer
>    drivers/net/can/usb/ucan.c:1407:31: sparse: incorrect type in argume=
nt 5 (different base types) @@    expected unsigned short [unsigned] [use=
rtype] value @@    got  short [unsigned] [usertype] value @@
>    drivers/net/can/usb/ucan.c:1407:31:    expected unsigned short [unsi=
gned] [usertype] value
>    drivers/net/can/usb/ucan.c:1407:31:    got restricted __le16 [userty=
pe] <noident>
>    drivers/net/can/usb/ucan.c:1448:31: sparse: incorrect type in argume=
nt 5 (different base types) @@    expected unsigned short [unsigned] [use=
rtype] value @@    got  short [unsigned] [usertype] value @@
>    drivers/net/can/usb/ucan.c:1448:31:    expected unsigned short [unsi=
gned] [usertype] value
>    drivers/net/can/usb/ucan.c:1448:31:    got restricted __le16 [userty=
pe] <noident>
>
> vim +301 drivers/net/can/usb/ucan.c
>
>    298=09
>    299	static u8 ucan_get_can_dlc(struct ucan_can_msg *msg, u16 len)
>    300	{
>  > 301		if (msg->id & CAN_RTR_FLAG)
>    302			return get_can_dlc(msg->dlc);
>    303		else
>    304			return get_can_dlc(len - (UCAN_IN_HDR_SIZE + sizeof(msg->id)))=
;
>    305	}
>    306=09
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology =
Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpo=
ration

--=20
Martin Elshuber
Theobroma Systems Design und Consulting GmbH
Seestadtstra=C3=9Fe 27 (Aspern IQ), 1220 Wien, Austria
Phone: +43 1 236 98 93-405, Fax: +43 1 236 98 93-9
http://www.theobroma-systems.com



--lLsR4B87ko5jN409ukahbqyzReDlj37IA--

--01tdxIkAqKbT1KwfpqHebZ2qvoOP2qH7u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJauhrpAAoJENNzc6lDjKRXhhsP/RoDa/3Jbz041e/f450OG2ws
Xt0/aIxwNNPnxEDBonPas0RcNzE0TltjUWI0T52anIG0Ctllm3SXhkPSJMPSamq3
3b2XlnHv+M/7LKV84YaXpQSfRDjxtSiJoeoTGwawFL2H16fTn9D5UqQtcpV9dvZz
S4xe9fROFA+ggBwNEMv8ZBFL2mD4JuG1wEgfxvDJkqdRAPB1tJdOOI61qyBOXRdm
vT4ikOW8MJZ/o8ixUiyJsjZu3f7iAS9GJbX8/mmQCr9bxNtPTeyat71NibQyH7Ta
R0P3mPuQw8BCCpdXU3g+SraMpSqYhuBOKYUWm7e+JG60q+jZ4AJvl+TPReb5b0oF
gbrADFxOwfmx48fYF2pHUwJ5BkEcbKw2EE9EEdZYXsPrsNHPEsTH4k3/LyHDkmCu
2ChZW/8EAiItTSd8xjA1K/GBgBVd12Tp5vT+80iHgNPc8GoPhyVMim9ed1nqwxFC
2K4UCoto+9JvzAEwzgajPfWWhS8DMbt+c4j2D4Eh6aBq8l1OftWc4HwKTu3MozzZ
rqMTwyajuUOu1bH7rV40socGbSptS9SOIjTQTXuRt7KGwMTrCkdlg/MDX9yQqJ7b
R9KZzKWhoVSZ1IzR1OMyB5zdGLJ3IRwSaDtqx1AaAny0LpXFRl3/k9cTOVvTPvUW
HxuVwZBqe/xJjt0FYy85
=cdZ+
-----END PGP SIGNATURE-----

--01tdxIkAqKbT1KwfpqHebZ2qvoOP2qH7u--
