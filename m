Return-Path: <Mario.Limonciello@dell.com>
X-Cyrus-Session-Id: sloti22d1t05-2114727-1526562089-2-213361447160312227
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='68.232.149.229', Host='esa6.dell-outbound.iphmx.com', Country='US',
  FromHeader='com', MailFrom='com', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: Mario.Limonciello@dell.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526562088; b=JXk1As28LrZd318v4KpK0YRsaRwoInA5g48FiKH/l4bqJ5Ng/G
    QwCT2tGbf7TVQ6+kGzPsq6cCik7VBL2fTtMzujUJ83EzjuwOXJJsEIkC/MOKr6/0
    q161qzcf9IuP/NKEcupZI7w32dJmmz6S6ylq0hBw2N/pcZ3IZdFKrudL5T45yD9l
    eHIKd72keB/Qj+Phasu/MVeT5E/z5LIRrpvIowpFZ1qXIPnNdCn8uvT/TTQRHTBS
    pnwHbsbgEnaecVV2eVNT9/DZwQvW11wlLVbuGZvQaBcMxo+oajlF66YB3lilrntM
    VQ4XBWtiDqrvDTnLnZX4awKK4deuvAXOHFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version; s=fm2; t=1526562088; bh=G+k9xkQljlgFkbxF6BRwo0NsW
    m/c845gUnjg1+MC76A=; b=XYVp9+RIPd963+UwOzFfjw9715Yb7tHuud1CMHwxS
    GE4OCrnE80TM+NKSgfD0qsWEqRHCLH0Ykhq8hGhUl+Phum1X/pHwbBOhEMvSnuYe
    pEtsjBDL6U4UVFrtHF4thoFWgJQ6GchWwnDC9tW4z3z9QFrH8+G7Q7ILCsGpCSkf
    sYhmAHT8sytUravjWRctwYyMN3QEv0WEfjfr/OW4iMak3PRjWDtRbljr7MLzLlTT
    RImLIm5DhX4vfLvKX+5Yb+XrFKo0V/2OoZRcy7nKAhj13PJ+Higi+RNwKBX+SbF9
    XFJ7m4KpfjiY/XWJw5ypflIRxxpGBLBOArLyBKcWLAOqw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com
    header.b=eM2kmFg7 x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=smtpout;
    dmarc=pass (p=none,d=none) header.from=dell.com;
    iprev=pass policy.iprev=68.232.149.229 (esa6.dell-outbound.iphmx.com);
    spf=pass smtp.mailfrom=Mario.Limonciello@dell.com
    smtp.helo=esa6.dell-outbound.iphmx.com;
    x-aligned-from=pass (Address match);
    x-cm=promotion score=0;
    x-ptr=pass x-ptr-helo=esa6.dell-outbound.iphmx.com
    x-ptr-lookup=esa6.dell-outbound.iphmx.com;
    x-return-mx=pass smtp.domain=dell.com smtp.result=pass
    smtp_is_org_domain=yes header.domain=dell.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com
      header.b=eM2kmFg7 x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=smtpout;
    dmarc=pass (p=none,d=none) header.from=dell.com;
    iprev=pass policy.iprev=68.232.149.229 (esa6.dell-outbound.iphmx.com);
    spf=pass smtp.mailfrom=Mario.Limonciello@dell.com
      smtp.helo=esa6.dell-outbound.iphmx.com;
    x-aligned-from=pass (Address match);
    x-cm=promotion score=0;
    x-ptr=pass x-ptr-helo=esa6.dell-outbound.iphmx.com
      x-ptr-lookup=esa6.dell-outbound.iphmx.com;
    x-return-mx=pass smtp.domain=dell.com smtp.result=pass
      smtp_is_org_domain=yes header.domain=dell.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHP39ndoK12BDxipG4ACpwtK2tEDMggCBQhcjDfbFl3yKWsiPs73f4Co0GRecyVeP6YSPk8QJUPwtQg65CYCXAalQDWJwLxXfd+jiCohU9JMAHGtl2oC
    RD5EF4kgqgLgzO2W0ktvT0P6AZ/aeSjYUDM/BMH1nVGosV/2Xw5pUpGmluxeM+zdrjTY+9icpuJRbtV9252jVUlCtsXB0ZIRlmc=
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 b=1 a=hamxQnaMTO3vX7DCtcUc+Q==:117
    a=hamxQnaMTO3vX7DCtcUc+Q==:17 a=wCHvqnb4SGkA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8 a=2C6YHBdLAAAA:8 a=VwQbUJbxAAAA:8
    a=iLNU1ar6AAAA:8 a=0gO2ZVf2-3xYLG-PGnEA:9 a=CjuIK1q_8ugA:10
    a=yxGMNg53M24zlVSZdvMH:22 a=AjGcO6oz07-iQ99wixmX:22 cc=prm
X-ME-CMScore: 0
X-ME-CMCategory: promotion
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2F+AABrWvZah2Oa6ERbGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQWgQkoCotsjHCBeYEPX5JWFIFkC4RsAoMKITQYAQIBAQEBAQE?=
 =?us-ascii?q?CAQECEAEBAQoLCQgoL4I1IoJTAQEBAwE6PwwEAgEIEQQBAQEeCQdGAwEFCAIED?=
 =?us-ascii?q?gUIFoMFgXkIrWeIV4IniCWCE4EPgwuBQYJ6HAiFaAKHFxkshVmDUIctBwKGVYd?=
 =?us-ascii?q?0gT6DZIdRK4IAg0iKaoElHIILcIMTgiAOCY4XbwGONoEtgRgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2F+AABrWvZah2Oa6ERbGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?WgQkoCotsjHCBeYEPX5JWFIFkC4RsAoMKITQYAQIBAQEBAQECAQECEAEBAQoLC?=
 =?us-ascii?q?QgoL4I1IoJTAQEBAwE6PwwEAgEIEQQBAQEeCQdGAwEFCAIEDgUIFoMFgXkIrWe?=
 =?us-ascii?q?IV4IniCWCE4EPgwuBQYJ6HAiFaAKHFxkshVmDUIctBwKGVYd0gT6DZIdRK4IAg?=
 =?us-ascii?q?0iKaoElHIILcIMTgiAOCY4XbwGONoEtgRgBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.190
X-IronPort-AV: E=Sophos;i="5.49,390,1520917200";
   d="scan'208";a="1252252013"
X-DLP: DLP_GlobalPCIDSS
To: <heikki.krogerus@linux.intel.com>
CC: <greg@kroah.com>, <pmenzel+linux-usb@molgen.mpg.de>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Thread-Topic: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Thread-Index: AQHT7FnacruSscNvFUKixxVl6UQN9aQxRuSAgAANFYCAAP+ZAIAAQeIA///t/DCAAXJpAP//7vrw
Date: Thu, 17 May 2018 13:01:20 +0000
Message-ID: <91a3c211cc8547ccb8eab844abd3b095@ausx13mpc120.AMER.DELL.COM>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com>
 <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com> <20180516115814.GB11469@kuha.fi.intel.com>
 <df6610738db046e9bd1db77d4346cfc3@ausx13mpc120.AMER.DELL.COM>
 <20180517085930.GD11469@kuha.fi.intel.com>
In-Reply-To: <20180517085930.GD11469@kuha.fi.intel.com>
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
> Sent: Thursday, May 17, 2018 4:00 AM
> To: Limonciello, Mario
> Cc: greg@kroah.com; pmenzel+linux-usb@molgen.mpg.de; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on De=
ll XPS 13
> 9370
>=20
> Hi,
>=20
> On Wed, May 16, 2018 at 04:13:31PM +0000, Mario.Limonciello@dell.com wrot=
e:
> >
> >
> > > -----Original Message-----
> > > From: Heikki Krogerus [mailto:heikki.krogerus@linux.intel.com]
> > > Sent: Wednesday, May 16, 2018 6:58 AM
> > > To: Greg KH; Paul Menzel
> > > Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Limoncie=
llo, Mario
> > > Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` o=
n Dell XPS 13
> > > 9370
> > >
> > > Hi,
> > >
> > > On Wed, May 16, 2018 at 10:02:26AM +0200, Greg KH wrote:
> > > > On Tue, May 15, 2018 at 06:47:37PM +0200, Paul Menzel wrote:
> > > > > Dear Greg,
> > > > >
> > > > >
> > > > > As always, thank you for the prompt response.
> > > > >
> > > > >
> > > > > On 05/15/18 18:00, Greg KH wrote:
> > > > > > On Tue, May 15, 2018 at 04:34:03PM +0200, Paul Menzel wrote:
> > > > >
> > > > > > > Linux 4.17-rc5 shows the error below on the Dell XPS 13 9370 =
with Debian
> > > > > > > Sid/unstable.
> > > > > > >
> > > > > > > ```
> > > > > > > [???]
> > > > > > > [    0.440240] usb: port power management may be unreliable
> > > > > > > [    0.441358] usbcore: registered new interface driver usb-s=
torage
> > > > > > > [    0.441367] usbcore: registered new interface driver usbse=
rial_generic
> > > > > > > [    0.441369] usbserial: USB Serial support registered for g=
eneric
> > > > > > > [    0.441383] ioremap error for 0x3f799000-0x3f79a000, reque=
sted 0x2,
> got
> > > > > > > 0x0
> > > > > > > [    0.441518] ucsi_acpi: probe of USBC000:00 failed with err=
or -12
> > > > > > > [???]
> > > > > > > ```
> > > > > > >
> > > > > > > 1.  Are the ioremap and ucsi_acpi error related or is a separ=
ate report
> > > > > > > needed?
> > > > > >
> > > > > > The ioremap error is what causes ucsi_acpi to fail the probe ca=
ll (-12
> > > > > > is "out of memory".)
> > > > > >
> > > > > > > 2.  Do you know the reason for the ucsi_acpi error?
> > > > > >
> > > > > > the call to ioremap failed.
> > > > > >
> > > > > > Does this device really have a working typec connector?
> > > > >
> > > > > Just to avoid misunderstandings, no device was connected to the l=
aptop
> > > > > during my test.
> > > > >
> > > > > But, from other boots, the Dell docking station TB16 kind of work=
s with it,
> > > > > so I???d say the USB Type-C connector is working.
> > > >
> > > > Ok, good, this might just be the acpi tables not set up properly fo=
r
> > > > this type of connection.  Odd that the tables show it should work,
> > > > Heikki should know more about this.
> > >
> > > The firmware probable has not implemented UCSI on this board. I think
> > > Dell always supplies the ACPI device node for UCSI in their acpi
> > > tables. The _STA method in that device node is then used to inform th=
e
> > > OS if the interface exists or not. The return value for _STA comes
> > > probable from BIOS, so this is most likely a BIOS problem.
> >
> > Heikki,
> >
> > I confirmed with internal team that UCSI is implemented on XPS 9370
> > and was confirmed to be working properly with Windows 10 RS2+.
>=20
> Just to double check: "UCSI was confirmed working properly", so not
> "the Type-C ports were confirmed working properly"?

UCSI was confirmed working properly.  FWIW it's a certification requirement
in Windows.

>=20
> > The reason that _STA is responding on this device node now but wasn't
> > previously is it wasn't exposed in Linux until 4.16 when the Win 10 RS2
> > OSI string started to respond.
>=20
> OK.
>=20
> > Intel should internally have some XPS 9370 you can remotely access if
> > you would like to poke around ACPI tables some.
>=20
> I will try get access to XPS 9370, but with the acpi tables, if
> somebody could just send me acpidump, that would be enough:
>=20
>         % acpidump -o xps9370_acpi.dump
>=20
> > > Please note that UCSI will only supply status information to the
> > > operating system, so the USB Type-C ports will function normally even
> > > without it. The ports are handled in firmware on these platforms.
> > >
> > > Paul, do you have the latest BIOS?
> > >
> > >
> > > > > > Does normal USB devices work with it?
> > > > >
> > > > > Sorry for being ignorant, but could you please tell me what norma=
l USB
> > > > > devices are?
> > > >
> > > > If you plug a USB typeC device into this port, does it work?  A doc=
king
> > > > station is a little bit "different" in that it usually uses the PCI=
e
> > > > connection, not the USB connectors.  Or at least that's how my Dell
> > > > docking station works last time I tried it[1]
> >
> > I think the best description here is "Non-Thunderbolt" USB type C devic=
e.
> > Some examples:
> > There are Dell docking stations with Thunderbolt (TB16) or without (WD1=
5).
> >
> > You can also pick up little dongles for ethernet or combo dongles for
> > ethernet/VGA/HDMI/etc.
> >
> > Anything non-Thunderbolt would satisfy what Greg was looking for.
>=20
> Anything non-Thunderbolt and non-display.
>=20
> With the display adapters you would be in DisplayPort alternate mode,
> and you would again not be testing a normal USB device.
>=20
> It never hurts to check that, but I think it's safe to assume that the
> ports are functioning normally if the Thunderbolt dock was working.
> Unless I'm mistaken, even the xHCI USB host controller behind the
> USB Type-C (thunderbolt) ports is actually part of the thunderbolt
> controller.

In this laptop yes that's true, but isn't a general statement. It's possibl=
e
to have USB split mode (ie XHCI comes from PCH).
