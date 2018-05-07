Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525710881; cv=none;
        d=google.com; s=arc-20160816;
        b=sszhVWiEmB6jUc+Ajhz0kjzCdxPQMlrdeDf2KaZbuo+Pa5XrEnTQpl0LI3vH+jEzwk
         kz3myK/hqOjcHWTxaN5BaLya/siTV07Th4NdW02OkhUvYgyN3au2VSUAIIQCBw2DHQUO
         hhzqoctbvYwGldv2gKQXFg/HdJqZ63w2EWQ/QogCkXS+pFXalytysuP20ICDEFkPz6dr
         95KbZlbADhwPmV2vtctIKyJYPC6g7Gv9+N+aVtLc4SkxL3sodJp/CLiPennLSV7toguf
         BK9jvRyLh1/i628RzOwdJ3IlrfTSaQz8BkQC2IK37JFP5xiyXhDn8e+KJ6+a6N/9K7WI
         hopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=qEKueACvwjZr6nTROyIxt34gKgL4Oa/gNPjKkUPYbkM=;
        b=YzlA5zXHZZIa9A4kGuK/0y+VTDSwtPfTVThfLtA5l++p/zoAJpU8k3nhVTq8/xBwso
         jJfRDpup7oIcNUhUInhzEgsmGtLHOmQ37hofEscZMZAjGjw/R2+zGsnSd5+d/aFC4VfL
         uUZYTkq0BK25jPKKteQ2fyXwdOz2mhjrDJR41zMy73wq6p28fEV7/s8VA7kY2hQi743N
         nQoXtyBWLU6Ea/HNvjZ9KxbM5y8Mgg2NACM0YQemtgN43JtZAL1TUnzqO4NCDC1ZWkUD
         nP2PH43wFrYFFdCEkxBSdA4TrNaRmwl57Hgr9JXIXy82omQAFokERDngAvjYq+HzNMoP
         5V6w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MDq9Nwei;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MDq9Nwei;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZqqWYS9duf1DwmvrS5GvA8f5tM9iwEuiH/iVq/2VLPTw7MXbFnmeuOx0r1NGilmxiVda1uknA==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 7 May 2018 18:34:39 +0200
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
Message-ID: <20180507163439.GV2285@localhost>
References: <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
 <20180426091018.GU4615@localhost>
 <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
 <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507154515.GP98604@atomide.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599823813194764143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 08:45:15AM -0700, Tony Lindgren wrote:
> Hi,
> 
> * Johan Hovold <johan@kernel.org> [180507 03:03]:
> > On Fri, May 04, 2018 at 01:42:13PM +0200, Sebastian Reichel wrote:
> > 
> > > Having said all of this, serdev does not yet support runtime PM (at
> > > all). Tony is currently looking into it. Fortunately serdev allows
> > > us to enable runtime PM by default (once implemented), since we know
> > > the remote side and can (hopefully) avoid losing characters (i.e.
> > > with sideband wakeup gpios).
> > 
> > I'm not sure we want generic runtime-pm support for the controllers in
> > the sense that the slave device state is always reflected by the serial
> > controller. Similar as for i2c and spi, we really only want to keep the
> > controller active when we are doing I/O, but we may want to keep a
> > client active for longer.
> 
> Yeah i2c seems to do the right thing where the bus takes care
> of runtime PM.

Yeah, but since serial is async in contrast to i2c/spi, we may not be
able to push this entirely into core. The serdev drivers may need to
indicate when they expect or need to do I/O by opening and closing the
port. And this is how I implemented these first couple of gnss drivers.

Also note that most serial driver do not do runtime pm while the port is
open (as OMAP does), and doing so also has the drawbacks of lost
characters etc. as Sebastian mentioned.

> > Take the u-blox driver in this series for example. As I'm using runtime
> > PM to manage device power, user-space can chose to prevent the receiver
> > from runtime suspending in order to avoid lengthy (re-)acquisition times
> > in setups without a backup battery (by means of the power/control
> > attribute).
> 
> Sorry I don't seem to have that one, care to paste the subject
> line of that patch?

	"[PATCH 5/7] gnss: add driver for u-blox receivers"

	https://lkml.kernel.org/r/20180424163458.11947-6-johan@kernel.org

> > Note that serdev not enabling runtime pm for controllers is roughly
> > equivalent to setting the .ignore_children flag, which is what we do for
> > i2c and spi controller, and possibly what we want here too.
> 
> We currently don't idle serdev at all even if not in use. What
> I noticed is if I have these in my .config:
> 
> CONFIG_SERIAL_DEV_BUS=y
> CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
> 
> And no hci_serdev.ko driver loaded, then the 8250 port still stays
> active and there are no sysfs entries to idle it.

Sounds like the 8250_omap driver is doing something funky. Why would
there not be any sysfs attributes to control runtime pm?

> Are you seeing this with your series?

I'm using omap-serial (on BBB) and like 8250_omap, the driver disables
runtime pm at probe by setting a negative autosuspend timeout.

Changing this through sysfs causes the serial controller to runtime
suspend, but something is not right in my setup as it doesn't wake up on
incoming data.

I'd say the omap drivers are broken; the controller should definitely
idle when the port is closed (whether using serdev or not) without
having to fiddle with sysfs.

Thanks,
Johan
