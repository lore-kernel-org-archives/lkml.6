Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AG47ELthlWvilPW34UUh1WrIy3k/CSG7Dk52hoB9g3IGhMq+U0oIA3qycwm3HMbKX3bmmIj0nOSg
ARC-Seal: i=1; a=rsa-sha256; t=1522063322; cv=none;
        d=google.com; s=arc-20160816;
        b=p4zFFKg9DPFi4B2+bdBg6ib+ruk7CgVNWQYdhTsldrNPOlNsvBQcYRoWgccE3gSrl5
         QPs4Oecah6Almo/2hORBI55ASfffVPBoh+L4nEkRbQ1eS2dX1ermjcDl8q2lhzl10yGa
         L2HesB6U0Wpf/jpMwwR+f1YrcSkAMhbBMaeRDcJgzMsOHI3+KaGPrHBNd/fr514icgQG
         d+SlgOxf9XObn0sXNm0ozCYo+j+72D/Nk6WQ3Su13YJmIUs2fHbR+WXNsD1jOn7HxFov
         B2gd/vIbrWEPzYJ7qohaoqdE1lv81RrA9i7dFL5PyEZCeywEGHnC5XHnlrpUF4o78C1e
         6W+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2jQw4yxVrKaZD0HjLyX5qwXh1nB5i96hKzKhK9Gzp24=;
        b=FsguOOKrKr3kjWNxYeiH99kXLmpSCd/WK7eaEa0G/OttJQrcCuqoDMfHmfEC8DpeCL
         bNruAZQIPTvkD3LcTOuO42UBNZY6t/7QBIK1vIWTEot2VpmBGl3JPsEE06sJ1cbZ3N6R
         pmb7fSH8XLIVnO9fxHU97uLa4l0M/f41CvScNtgI1HrHH/RwA9/3KPIBUDdTJT+XG5IV
         pHIGQVR7LbdX6AOb2UNJuZwRatuxki+UjrSfxWk1tJIIbrBhOQBkRujTkaV2/mX6ZLhN
         lJoO+vz5AhsSKCh2G8FRc7QqLQaPSDc/owq02rg378z2zdv1/R4sYhoGAm3AD52pYUts
         p3Ow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Mon, 26 Mar 2018 13:21:50 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec
 <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta
 <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja
 Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka
 <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal
 Ciepiela <rafalc@cadence.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob
 Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Vitor Soares <Vitor.Soares@synopsys.com>,
 Linus Walleij <linus.walleij@linaro.org>, Xiang Lin
 <Xiang.Lin@synaptics.com>, "open list:GPIO SUBSYSTEM"
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 11/11] dt-bindings: gpio: Add bindings for Cadence
 I3C gpio expander
Message-ID: <20180326132150.31dda65f@bbrezillon>
In-Reply-To: <CAMuHMdUH3iB6ngF-0Zkij-oNN-Oms=EwXgoceLp06xbdcq1S=w@mail.gmail.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
	<20180323110020.19080-12-boris.brezillon@bootlin.com>
	<CAMuHMdUH3iB6ngF-0Zkij-oNN-Oms=EwXgoceLp06xbdcq1S=w@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725936015625601?=
X-GMAIL-MSGID: =?utf-8?q?1595999070779462239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Geert,

On Mon, 26 Mar 2018 12:17:26 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Boris,
> 
> On Fri, Mar 23, 2018 at 12:00 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > Document the Cadence I3C gpio expander bindings.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>  
> 
> Thanks for your patch!
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
> > @@ -0,0 +1,38 @@
> > +* Cadence I3C GPIO expander
> > +
> > +The Cadence I3C GPIO expander provides 8 GPIOs controllable over I3C.
> > +This GPIOs can be configured in output or input mode and if they are in input
> > +mode they can generate IBIs (In Band Interrupts).
> > +
> > +Required properties for GPIO node:
> > +- reg : 3 cells encoding the I3C static address (none in our case) and the I3C
> > +       Provisional ID. See Documentation/devicetree/bindings/i3c/i3c.txt for
> > +       more details.
> > +       Should be <0x0 0x392 0x0>.  
> 
> No compatible value?

See my other reply.

> 
> > +- gpio-controller : Marks the device node as a gpio controller.
> > +- #gpio-cells : Should be two. The first cell is the pin number and
> > +  the second cell is used to specify the gpio polarity:
> > +      0 = active high
> > +      1 = active low
> > +- interrupt-controller: Marks the device node as an interrupt controller.
> > +- #interrupt-cells : Should be 2.  The first cell is the GPIO number.
> > +  The second cell bits[3:0] is used to specify trigger type and level flags:
> > +      1 = low-to-high edge triggered.
> > +      2 = high-to-low edge triggered.
> > +      3 = triggered on both edges.
> > +      4 = active high level-sensitive.
> > +      8 = active low level-sensitive.
> > +
> > +Example:
> > +
> > +       i3c-master@xxx {
> > +               ...
> > +               i3c_gpio_expander: gpio@0,1c9,0 {  
> 
> gpio@0,392,0?

Actually, if I follow the DT bindings, it should be gpio@0,39200000000

Thanks,

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
