Return-Path: <Mario.Limonciello@dell.com>
X-Cyrus-Session-Id: sloti22d1t05-526264-1526487237-2-306965295679396956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_LOW -0.7, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='68.232.153.96', Host='esa7.dell-outbound.iphmx.com', Country='US',
  FromHeader='com', MailFrom='com', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: Mario.Limonciello@dell.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526487235; b=S/sQii6X6tUfIWE1N3cMiSflKVfW1wlyZ1xJwH33cd4MuaLj60
    8cVJJu5mmIiK1MnSnSXi+b1YeTfQ0HyhE39jhMYrHcvRwcV4qT49TwAqRvOaVjPM
    T16hRqjns4cdkEghbmp9rPEa4fCvIb5SBySqBvhm+pa7GgUpH9C/FHDYDGloAA5u
    kp9grQae3vMngsWHlClpAzPc6NttGayyIbFsXybbi+qjLjUlxGYTh8HvDxpK6KBz
    ZSBuAojwn7o7LjulYDjvcfswsoWTwy33/5cvDisb5JXXE4zxdj1AW6Xn7PcOLycN
    mEfYiDgQgG4nqKOE2TilIjP66pulzmO8Ld/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version; s=fm2; t=1526487235; bh=FSSoj38uie2ojoP7pDKO4YZy6
    WCAwCD9hOUhqvKK/Xk=; b=dL8LDfnkCGb2RUk9d2eu3cwBeP6fuP7NM77DEd/u2
    FcMHkfzU5ESbLw+5qzQuqWaNbGT6hSmgTLpewbeAs5hnw+6ptP1Hahtlpm9e/T6l
    ackXgY2O3iOoNFnWrxrmb9Win9PKZn0D3tw765c3zh0ghDSaCQ3wd1KtBWuaCWlN
    nD9Qnk0/NPvC6tjPF483hhYPRrRf74G0oYpEU1jedIEn/TNMhwCIzNUFx0iYrRnt
    YJBKuscPKMCv89wk/3Ndmno9vOS58/8zOiV9mFvP5dAY6InQ4foN7i2dyGHVEYLc
    Z4QrUXBTdd5qL+gnodgkdo9dG8E6X8SI7/mcJ3ZHOqVlQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com
    header.b=P/AY8tVp x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=smtpout;
    dmarc=pass (p=none,d=none) header.from=dell.com;
    iprev=pass policy.iprev=68.232.153.96 (esa7.dell-outbound.iphmx.com);
    spf=pass smtp.mailfrom=Mario.Limonciello@dell.com
    smtp.helo=esa7.dell-outbound.iphmx.com;
    x-aligned-from=pass (Address match);
    x-cm=promotion score=0;
    x-ptr=pass x-ptr-helo=esa7.dell-outbound.iphmx.com
    x-ptr-lookup=esa7.dell-outbound.iphmx.com;
    x-return-mx=pass smtp.domain=dell.com smtp.result=pass
    smtp_is_org_domain=yes header.domain=dell.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com
      header.b=P/AY8tVp x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=smtpout;
    dmarc=pass (p=none,d=none) header.from=dell.com;
    iprev=pass policy.iprev=68.232.153.96 (esa7.dell-outbound.iphmx.com);
    spf=pass smtp.mailfrom=Mario.Limonciello@dell.com
      smtp.helo=esa7.dell-outbound.iphmx.com;
    x-aligned-from=pass (Address match);
    x-cm=promotion score=0;
    x-ptr=pass x-ptr-helo=esa7.dell-outbound.iphmx.com
      x-ptr-lookup=esa7.dell-outbound.iphmx.com;
    x-return-mx=pass smtp.domain=dell.com smtp.result=pass
      smtp_is_org_domain=yes header.domain=dell.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFlrwUVgLsbAs5zUHZ2woW9XVib3w+TjQsvry9f8I/LIcu4wHCmktjBiLkXCaJ0/7ezsKF2JVscfMt4dP+jYtzJZTeuVmuJHoZj3MR1pUf6Zt9yQh4bR
    y5jQyGMjER/bCdsMeMoOnAxZHgbPpf0FG3NY422TCrmnnHadWEpJW7trxlWmyqDdi0mVLTzDQwwGht59creZJO/+6ruAapQ/MSI=
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 b=1 a=KnMD5mEbq5MDPFkSCEFksA==:117
    a=KnMD5mEbq5MDPFkSCEFksA==:17 a=wCHvqnb4SGkA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=b1ZSLT_HmeJ55NPXqUsA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 cc=prm
X-ME-CMScore: 0
X-ME-CMCategory: promotion
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GOAADjV/xah8qZ6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYUhKAqLbox0gXmBD5MyFIFkC4RsAoMgITQYAQIBAQEBAQECAQE?=
 =?us-ascii?q?CEAEBAQoLCQgoL4I1IoJTAQEBAwE6PwwEAgEIEQQBAQEeCQdGAwEFCAIEAQ0FC?=
 =?us-ascii?q?BaDBYF5CK0EiESCJ4gnghOBD4MMgUGCehwIhWgChxoZLIVdiwUHAoZWh3WBP4N?=
 =?us-ascii?q?qh1YrhUuKeIElHIILcIMTgiAOCY4XbwGMR4EtgRgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GOAADjV/xah8qZ6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYU?=
 =?us-ascii?q?hKAqLbox0gXmBD5MyFIFkC4RsAoMgITQYAQIBAQEBAQECAQECEAEBAQoLCQgoL?=
 =?us-ascii?q?4I1IoJTAQEBAwE6PwwEAgEIEQQBAQEeCQdGAwEFCAIEAQ0FCBaDBYF5CK0EiES?=
 =?us-ascii?q?CJ4gnghOBD4MMgUGCehwIhWgChxoZLIVdiwUHAoZWh3WBP4Nqh1YrhUuKeIElH?=
 =?us-ascii?q?IILcIMTgiAOCY4XbwGMR4EtgRgBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.198
X-IronPort-AV: E=Sophos;i="5.49,406,1520917200";
   d="scan'208";a="188900518"
X-DLP: DLP_GlobalPCIDSS
To: <heikki.krogerus@linux.intel.com>, <greg@kroah.com>,
	<pmenzel+linux-usb@molgen.mpg.de>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Thread-Topic: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Thread-Index: AQHT7FnacruSscNvFUKixxVl6UQN9aQxRuSAgAANFYCAAP+ZAIAAQeIA///t/DA=
Date: Wed, 16 May 2018 16:13:31 +0000
Message-ID: <df6610738db046e9bd1db77d4346cfc3@ausx13mpc120.AMER.DELL.COM>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com>
 <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com> <20180516115814.GB11469@kuha.fi.intel.com>
In-Reply-To: <20180516115814.GB11469@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Heikki Krogerus [mailto:heikki.krogerus@linux.intel.com]
> Sent: Wednesday, May 16, 2018 6:58 AM
> To: Greg KH; Paul Menzel
> Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Limonciello,=
 Mario
> Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on De=
ll XPS 13
> 9370
>=20
> Hi,
>=20
> On Wed, May 16, 2018 at 10:02:26AM +0200, Greg KH wrote:
> > On Tue, May 15, 2018 at 06:47:37PM +0200, Paul Menzel wrote:
> > > Dear Greg,
> > >
> > >
> > > As always, thank you for the prompt response.
> > >
> > >
> > > On 05/15/18 18:00, Greg KH wrote:
> > > > On Tue, May 15, 2018 at 04:34:03PM +0200, Paul Menzel wrote:
> > >
> > > > > Linux 4.17-rc5 shows the error below on the Dell XPS 13 9370 with=
 Debian
> > > > > Sid/unstable.
> > > > >
> > > > > ```
> > > > > [???]
> > > > > [    0.440240] usb: port power management may be unreliable
> > > > > [    0.441358] usbcore: registered new interface driver usb-stora=
ge
> > > > > [    0.441367] usbcore: registered new interface driver usbserial=
_generic
> > > > > [    0.441369] usbserial: USB Serial support registered for gener=
ic
> > > > > [    0.441383] ioremap error for 0x3f799000-0x3f79a000, requested=
 0x2, got
> > > > > 0x0
> > > > > [    0.441518] ucsi_acpi: probe of USBC000:00 failed with error -=
12
> > > > > [???]
> > > > > ```
> > > > >
> > > > > 1.  Are the ioremap and ucsi_acpi error related or is a separate =
report
> > > > > needed?
> > > >
> > > > The ioremap error is what causes ucsi_acpi to fail the probe call (=
-12
> > > > is "out of memory".)
> > > >
> > > > > 2.  Do you know the reason for the ucsi_acpi error?
> > > >
> > > > the call to ioremap failed.
> > > >
> > > > Does this device really have a working typec connector?
> > >
> > > Just to avoid misunderstandings, no device was connected to the lapto=
p
> > > during my test.
> > >
> > > But, from other boots, the Dell docking station TB16 kind of works wi=
th it,
> > > so I???d say the USB Type-C connector is working.
> >
> > Ok, good, this might just be the acpi tables not set up properly for
> > this type of connection.  Odd that the tables show it should work,
> > Heikki should know more about this.
>=20
> The firmware probable has not implemented UCSI on this board. I think
> Dell always supplies the ACPI device node for UCSI in their acpi
> tables. The _STA method in that device node is then used to inform the
> OS if the interface exists or not. The return value for _STA comes
> probable from BIOS, so this is most likely a BIOS problem.

Heikki,

I confirmed with internal team that UCSI is implemented on XPS 9370
and was confirmed to be working properly with Windows 10 RS2+.

The reason that _STA is responding on this device node now but wasn't
previously is it wasn't exposed in Linux until 4.16 when the Win 10 RS2
OSI string started to respond.

Intel should internally have some XPS 9370 you can remotely access if
you would like to poke around ACPI tables some.

>=20
> Please note that UCSI will only supply status information to the
> operating system, so the USB Type-C ports will function normally even
> without it. The ports are handled in firmware on these platforms.
>=20
> Paul, do you have the latest BIOS?
>=20
>=20
> > > > Does normal USB devices work with it?
> > >
> > > Sorry for being ignorant, but could you please tell me what normal US=
B
> > > devices are?
> >
> > If you plug a USB typeC device into this port, does it work?  A docking
> > station is a little bit "different" in that it usually uses the PCIe
> > connection, not the USB connectors.  Or at least that's how my Dell
> > docking station works last time I tried it[1]

I think the best description here is "Non-Thunderbolt" USB type C device.
Some examples:
There are Dell docking stations with Thunderbolt (TB16) or without (WD15).

You can also pick up little dongles for ethernet or combo dongles for
ethernet/VGA/HDMI/etc.

Anything non-Thunderbolt would satisfy what Greg was looking for.

> >
> > thanks,
> >
> > greg k-h
> >
> > [1] When the power supply for the docking station is bigger than the
> >     laptop's power supply, you begin to wonder what is in that thing an=
d
> >     stop using it after a while...

Mostly to satisfy letting the docking station work with beefier machines an=
d
still deliver power up to what USB PD will negotiate.
I think they can actually run with smaller power supplies but you will need
something "a little" bigger than regular system power supply to power the
dock and system both.
