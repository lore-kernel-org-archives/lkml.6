Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525762734; cv=none;
        d=google.com; s=arc-20160816;
        b=ZxL+th11u62tNFAE6Q+O9kUBHbIYDAsUbBwqcq6pDUYbWvDSJ9fvRbz3l9X8yJiZRc
         t/ryl3EM3r7zY/9fsaxg6fiwljZRfNMQJl8DNk2JdwmjBoxx3/IPhDffgI1R+Yl45Ot2
         kTd+EKE0gg+ZSxuHbKerUknIjOpGE3FsnozPaQ4N7hRmTKESwePQ+oD+8GRc1ZDv1+hL
         RJ5/wUvbi/Z/AssLEnasSZ/6oapr0Meb2fyTjY794ZpZP1xhRb8BlgOBjGu9T2WKFH4n
         CgQ4ahI7/MJdS1tQm4aWPQYMjLBBm+gN3066uys4AnH1b1Fvs9txOW+CliWOsz4UPg5L
         5aVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=56kNOudwEHzAloZtoJSY1D/IjmG6x0L67OdLN1N7pB4=;
        b=nlV+VrVCdSdMZpmnH8BbzWlvwVpESCScdk0QexKXphR7+N1iXzvtU1p/+ohqbnQ72b
         KuOj3mRR3GUaI5qd26ITbQc3uXGuZ3etmM3VQHT5smUtcpXGnGoXDyFhAMgiQm2Fkvgp
         A7nlnPWHIYrVnH5Elws7OhrJ5oZkQ8pPH92Zdf9WwVcKLKLF6S8uTRkBr/algeSc/LnP
         Bhfl8nr3hfaVTwAHW0yGvU+rPbto8XsLMOQKo4hou3m3nkBo8z/GUECIuIunw0S/KR1v
         qi8L9w7bj8cWzfaLAPmgmI2yEY1U3NA2G0Ka0vRqKubM8ZzRj6lS4wH87jn6UNHDGyou
         QuIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FkkPJ/X/;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FkkPJ/X/;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZpzeUsp4qftFeXB5hJYxbdqEso0S7wQsqjrG9s9uVtGsFfXjhePrNjrCEEFoLUojCEaSm8uZg==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Tue, 8 May 2018 08:58:52 +0200
From: Johan Hovold <johan@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180508065852.GW2285@localhost>
References: <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
 <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180507175032.GR98604@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507175032.GR98604@atomide.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599878184680315375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 10:50:32AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [180507 16:36]:
> > On Mon, May 07, 2018 at 08:45:15AM -0700, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * Johan Hovold <johan@kernel.org> [180507 03:03]:
> > > > On Fri, May 04, 2018 at 01:42:13PM +0200, Sebastian Reichel wrote:

> > > > Note that serdev not enabling runtime pm for controllers is roughly
> > > > equivalent to setting the .ignore_children flag, which is what we do for
> > > > i2c and spi controller, and possibly what we want here too.
> > > 
> > > We currently don't idle serdev at all even if not in use. What
> > > I noticed is if I have these in my .config:
> > > 
> > > CONFIG_SERIAL_DEV_BUS=y
> > > CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
> > > 
> > > And no hci_serdev.ko driver loaded, then the 8250 port still stays
> > > active and there are no sysfs entries to idle it.
> > 
> > Sounds like the 8250_omap driver is doing something funky. Why would
> > there not be any sysfs attributes to control runtime pm?
> 
> I don't know, they are there for the ports that don't have any
> serdev device. But if there is a serdev child node, the sysfs
> disappear for the 8250 port like it's /dev/ttyS* entry. That is
> even with no hci_serdev.ko loaded :)

It sounds to me like you have a udev rule that's matching on TTY devices
and setting an autosuspend timeout that allows the controller to runtime
suspend. Is that so?

With serdev such a rule would no longer be sufficient as it would no
longer configure all controllers. You can always set the autosuspend
directly through the platform device node, for example:

	/sys/bus/platform/devices/481aa000.serial

But the point is, we really don't want the runtime PM behaviour to be
dependent on the presence of such rules. The serial controllers should
always be idle when not in use (unless overridden by user space).

> > > Are you seeing this with your series?
> > 
> > I'm using omap-serial (on BBB) and like 8250_omap, the driver disables
> > runtime pm at probe by setting a negative autosuspend timeout.
> 
> Hmm I though we now have both 8250_omap and serial-omap behave the
> same way for PM.

It looks like they've been implemented the same way (e.g. the negative
autosuspend timeout).

> > Changing this through sysfs causes the serial controller to runtime
> > suspend, but something is not right in my setup as it doesn't wake up on
> > incoming data.
> 
> Do you have also a /dev/ttyO* entry created for the serdev port?

No, serdev claims the port and no tty device is created.

> > I'd say the omap drivers are broken; the controller should definitely
> > idle when the port is closed (whether using serdev or not) without
> > having to fiddle with sysfs.
> 
> This is happening for the non-serdev ports for sure. FYI, there is
> one patch needed for omap4 to idle unused ports that I posted
> few days ago:
> 
> [PATCHv3] serial: 8250: omap: Fix idling of clocks for unused uarts
> 
> But the serdev port is never idled, even if unused.

With the negative autosuspend set in both omap drivers probe functions,
this is the expected behaviour. Which I think we must fix.

> Can you check your serdev port clkctrl reg with rwmem or similar
> tool when it's idle?
> 
> You can do it with:
> 
> rwmem -s32 0x44e004b4           # uart 1 on l4_wkup
> rwmem -s32 0x44e0006c+0x10      # uart 2 - 5 on l4_per
> rwmem -s32 0x44e00038           # uart 6 on l4_per
> 
> And here's what I have on my bbb with 8250_omap:
> 
> 0x44e004b4 = 0x00000002
> 0x44e0006c = 0x00030000
> 0x44e00070 = 0x00030000
> 0x44e00074 = 0x00030000
> 0x44e00078 = 0x00030000
> 0x44e00038 = 0x00030000
> 
> So all disabled except for the console UART.

On BBB with omap-serial I have:

0x44e004b4 = 0x2	(uart 1, console, open)
0x44e0006c = 0x2	(uart 2, serdev, closed)
0x44e00070 = 0x30000	(uart 3, disabled in DT)
0x44e00074 = 0x30000	(uart 4, disabled in DT)
0x44e00078 = 0x2	(uart 5, serdev, closed)
0x44e00038 = 0x2	(uart 6, ttyO5, closed)

So no enabled and closed port is idle, whether using serdev or not.

Thanks,
Johan
