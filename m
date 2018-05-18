Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrJ03+TgPd68OqXkjJsBuxHAagMegVTzY7p6srlI5N3Cnm0KYv7FQ1Aumi71YJr/jdG5ijK
ARC-Seal: i=1; a=rsa-sha256; t=1526640005; cv=none;
        d=google.com; s=arc-20160816;
        b=l7+f4JaavX8jdwajJ2wBoQucvsdYvdhT1HJV99NCk7jK0RFNjaJeX+KB/n8LGuT9Wh
         Ycaoso6Wqa9RuxytHQ1Xtx0BYGYMGaPRNvxJqcH3WqdHHJNYykq0VRv2Tb1ODJKdXsbh
         mZ4CowXmjr0CQE3NDOUgN/7CLbuopE4QN/DVJb0q50eMia+zbju9cMNqnT7Y4GdLoGEh
         fdYqIVZJLOpmrKzOBTpOAVUnJozR12IGDRa3BJqFAmAU4oKt3grrlk3jJ31/mcSLNCs0
         V4gxWWMjCZ1fvlobcs9WlAqmyPe8EUfwvGQ22PNVALVunXzJnsps6/NCY7uKIpkSBHP4
         XTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=/0mROoTyrGTkih1cwSJ/UEYDrsgcET1xu0jtp8h9FLc=;
        b=fUWMBT/ws7AyeeJ07KLCOq8jmpnebj3WJKEKJ5lkUkP9rA7l6Ct4jXYBqMCfhE6EO3
         dY1cXucz8GiBYfu7BSXEfJj+JVqEtJ9JtClN+k5xEdKjjeD0THDVIzgsuhbYPiRSyA/o
         Ex0FUaN8FcUpFq5bplmBleam7UXZdENClpFmn16WAxLDT8+VodafPRuZA0TEUFhqgfIb
         csNpC/1Lc8h5ENTbwAZyTzvNI4QpRIgwiZ8kySVzJn6jeSWN8veSexqTOQOqbxa/IJv2
         LuXwi61o71FBQ9yQIwNsb0NdTNRfHIaptxVSBdcQL+UOtGvEewD3n9Hbz0Qn6YQHDtni
         xd/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,414,1520924400";
   d="scan'208";a="56405840"
Date: Fri, 18 May 2018 13:40:00 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>
Cc: Mario Limonciello <mario.limonciello@dell.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9360/9370
Message-ID: <20180518104000.GA13595@kuha.fi.intel.com>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com>
 <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com>
 <20180516115814.GB11469@kuha.fi.intel.com>
 <df6610738db046e9bd1db77d4346cfc3@ausx13mpc120.AMER.DELL.COM>
 <20180517085930.GD11469@kuha.fi.intel.com>
 <40707f34-e0a6-3114-36a3-6603bdcd8d82@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40707f34-e0a6-3114-36a3-6603bdcd8d82@molgen.mpg.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600718468344899455?=
X-GMAIL-MSGID: =?utf-8?q?1600798069753077322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Paul,

On Thu, May 17, 2018 at 03:34:49PM +0200, Paul Menzel wrote:
> Dear Heikki,
> 
> Note, this problem also exists on the Dell XPS 13 9360 (Kaby Lake) device.

OK. Good to know. Though, we don't have one of those either.

> On 05/17/18 10:59, Heikki Krogerus wrote:
> > On Wed, May 16, 2018 at 04:13:31PM +0000, Mario.Limonciello@dell.com wrote:
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: Heikki Krogerus [mailto:heikki.krogerus@linux.intel.com]
> > > > Sent: Wednesday, May 16, 2018 6:58 AM
> > > > To: Greg KH; Paul Menzel
> > > > Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Limonciello, Mario
> > > > Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell XPS 13
> > > > 9370
> > > > 
> > > > Hi,
> > > > 
> > > > On Wed, May 16, 2018 at 10:02:26AM +0200, Greg KH wrote:
> > > > > On Tue, May 15, 2018 at 06:47:37PM +0200, Paul Menzel wrote:
> > > > > > Dear Greg,
> > > > > > 
> > > > > > 
> > > > > > As always, thank you for the prompt response.
> > > > > > 
> > > > > > 
> > > > > > On 05/15/18 18:00, Greg KH wrote:
> > > > > > > On Tue, May 15, 2018 at 04:34:03PM +0200, Paul Menzel wrote:
> > > > > > 
> > > > > > > > Linux 4.17-rc5 shows the error below on the Dell XPS 13 9370 with Debian
> > > > > > > > Sid/unstable.
> > > > > > > > 
> > > > > > > > ```
> > > > > > > > [???]
> > > > > > > > [    0.440240] usb: port power management may be unreliable
> > > > > > > > [    0.441358] usbcore: registered new interface driver usb-storage
> > > > > > > > [    0.441367] usbcore: registered new interface driver usbserial_generic
> > > > > > > > [    0.441369] usbserial: USB Serial support registered for generic
> > > > > > > > [    0.441383] ioremap error for 0x3f799000-0x3f79a000, requested 0x2, got
> > > > > > > > 0x0
> > > > > > > > [    0.441518] ucsi_acpi: probe of USBC000:00 failed with error -12
> > > > > > > > [???]
> > > > > > > > ```
> > > > > > > > 
> > > > > > > > 1.  Are the ioremap and ucsi_acpi error related or is a separate report
> > > > > > > > needed?
> > > > > > > 
> > > > > > > The ioremap error is what causes ucsi_acpi to fail the probe call (-12
> > > > > > > is "out of memory".)
> > > > > > > 
> > > > > > > > 2.  Do you know the reason for the ucsi_acpi error?
> > > > > > > 
> > > > > > > the call to ioremap failed.
> > > > > > > 
> > > > > > > Does this device really have a working typec connector?
> > > > > > 
> > > > > > Just to avoid misunderstandings, no device was connected to the laptop
> > > > > > during my test.
> > > > > > 
> > > > > > But, from other boots, the Dell docking station TB16 kind of works with it,
> > > > > > so I???d say the USB Type-C connector is working.
> > > > > 
> > > > > Ok, good, this might just be the acpi tables not set up properly for
> > > > > this type of connection.  Odd that the tables show it should work,
> > > > > Heikki should know more about this.
> > > > 
> > > > The firmware probable has not implemented UCSI on this board. I think
> > > > Dell always supplies the ACPI device node for UCSI in their acpi
> > > > tables. The _STA method in that device node is then used to inform the
> > > > OS if the interface exists or not. The return value for _STA comes
> > > > probable from BIOS, so this is most likely a BIOS problem.
> > > 
> > > Heikki,
> > > 
> > > I confirmed with internal team that UCSI is implemented on XPS 9370
> > > and was confirmed to be working properly with Windows 10 RS2+.
> > 
> > Just to double check: "UCSI was confirmed working properly", so not
> > "the Type-C ports were confirmed working properly"?
> > 
> > > The reason that _STA is responding on this device node now but wasn't
> > > previously is it wasn't exposed in Linux until 4.16 when the Win 10 RS2
> > > OSI string started to respond.
> > 
> > OK.
> > 
> > > Intel should internally have some XPS 9370 you can remotely access if
> > > you would like to poke around ACPI tables some.
> > 
> > I will try get access to XPS 9370, but with the acpi tables, if
> > somebody could just send me acpidump, that would be enough:
> > 
> >          % acpidump -o xps9370_acpi.dump
> 
> I uploaded them to another bug report [1]. Please find it attached.

Thanks!


Br,

-- 
heikki
