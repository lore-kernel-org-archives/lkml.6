Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeC0KTn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:19:43 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:41197 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751030AbeC0KTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:19:41 -0400
Subject: Re: [PATCH v3 0/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180322135338.60923-1-jakob.unterwurzacher@theobroma-systems.com>
 <d336fdf1-5247-5f97-4b83-ad2530ece41e@grandegger.com>
 <7e818d10-3410-b144-9cfb-c58a9945a8b1@theobroma-systems.com>
 <e6d4bfc8-d43f-20ef-7b00-43ecf0a87f96@grandegger.com>
 <01b11c3d-76df-0e4c-1479-1321a6ecd96c@theobroma-systems.com>
From: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Message-ID: <cb761460-791f-023f-eabb-9b5610bfb6a6@theobroma-systems.com>
Date: Tue, 27 Mar 2018 12:19:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <01b11c3d-76df-0e4c-1479-1321a6ecd96c@theobroma-systems.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2b5E10bsTxKl8tkte2vpl4LO7iL3SbXDZ"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2b5E10bsTxKl8tkte2vpl4LO7iL3SbXDZ
Content-Type: multipart/mixed; boundary="lS8EL4tzVLFbWGSvhEWzu5fawE9QxGigM";
 protected-headers="v1"
From: Martin Elshuber <martin.elshuber@theobroma-systems.com>
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <cb761460-791f-023f-eabb-9b5610bfb6a6@theobroma-systems.com>
Subject: Re: [PATCH v3 0/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
References: <20180322135338.60923-1-jakob.unterwurzacher@theobroma-systems.com>
 <d336fdf1-5247-5f97-4b83-ad2530ece41e@grandegger.com>
 <7e818d10-3410-b144-9cfb-c58a9945a8b1@theobroma-systems.com>
 <e6d4bfc8-d43f-20ef-7b00-43ecf0a87f96@grandegger.com>
 <01b11c3d-76df-0e4c-1479-1321a6ecd96c@theobroma-systems.com>
In-Reply-To: <01b11c3d-76df-0e4c-1479-1321a6ecd96c@theobroma-systems.com>

--lS8EL4tzVLFbWGSvhEWzu5fawE9QxGigM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: de-AT

Where possible we changed dev_XXX to netdev_XXX. and removed all __func__=
=2E
netdev_XXX prints the necessary information on the device, bus and netif
The remaining dev_XXX (within probe) are extended such that they print
the string "ucan" (__func__ are also removed)

Am 23.03.18 um 11:12 schrieb Jakob Unterwurzacher:
> On 23.03.18 11:04, Wolfgang Grandegger wrote:
>>
>>> But I'm open to other suggestions (use a fixed "ucan: " prefix?) or t=
o
>>> drop it entirely if you think it is not worth it.
>>
>> But there is already a device prefix, e.g.:
>>
>> =C2=A0=C2=A0 peak_usb 1-6:1.0: PEAK-System PCAN-USB adapter hwrev 28 s=
erial
>> FFFFFFFF (1 channel)
>> =C2=A0=C2=A0 peak_usb 1-6:1.0 can0: attached to PCAN-USB channel 0 (de=
vice 255)
>> =C2=A0=C2=A0 ^^^^^^^^
>
> Interesting. Looks like the UCAN driver is missing something to make
> this work:
>
> [=C2=A0=C2=A0 67.792947] usb 5-1.4: ucan_probe: registered UCAN device =
at can0
>
> I'll take a closer look.
>
> Thanks,
> Jakob

--=20
Martin Elshuber
Theobroma Systems Design und Consulting GmbH
Seestadtstra=C3=9Fe 27 (Aspern IQ), 1220 Wien, Austria
Phone: +43 1 236 98 93-405, Fax: +43 1 236 98 93-9
http://www.theobroma-systems.com



--lS8EL4tzVLFbWGSvhEWzu5fawE9QxGigM--

--2b5E10bsTxKl8tkte2vpl4LO7iL3SbXDZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJauhq6AAoJENNzc6lDjKRXtlsP/iFqm4Zjakhjv02ahbVq0UxF
p3Hu8tjNcVAUJGaYBpF0EDCaWimhUoPoK6Rcjzczd3qOi1RddMBIceVRs2ZN/Ixn
abyVzs35mAPfYZSPlEoUztV5xZqqN8JMfLKruSB7zZCVfhH/YPqLH5/ZX5VrmTcp
X+nHB+sjTHlGxDSYYjy51D0cjLx7vr37MEjgVTOqjcqcN6SbwMqRxMjW/Pwn467p
DA2owrzBa3gXAHTDoEr2Ne6V6Ni79ydz/UOYEH6MIpaIH0qxYxeL3SgFGaWrB17R
i9i6/9I+Ox4VnQGR+0UJNMsMXNmHd7El2mJuXINYDSq0vac0KPGKEbYxW7lTbYdw
vl46GRKfLxPldIQeb3yh5I95w8xV1dXDqX2coU1puhMbaoyNG0q/l7+McukAO5WB
r/YBk/07tdB1Qc+pBIWrHvZ9Y0euJDyJONlpneIEhGoWtfE5SfEvdYLR123d6jnJ
6RE78ScZMrTCTfDnBPPdHP+Vj2p8BvAzXmNBGsvkVZMONvcCHCrqUGHxXUfaVKFV
NhJ5n+h1cpl/41xpo5t3151Nijda01exfUy1qd7fwV7lZygAhXOdqdb5CvxzN9LA
CUWNKzNnNp7ObI5jnWoR9F1YYXrou3HDRn81OeyU/QlnJQ1x5hdekmNSCAc33mml
695fWdkcVWsV6pTmdpeG
=ag47
-----END PGP SIGNATURE-----

--2b5E10bsTxKl8tkte2vpl4LO7iL3SbXDZ--
