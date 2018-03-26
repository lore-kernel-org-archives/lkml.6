Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx4+7nu2P2MJqejFKyuBiTryi4Jvs7g7dFNv4HI/PNP0eXdRqjgKWpH15SvuKcEeEbpf4OASr
ARC-Seal: i=1; a=rsa-sha256; t=1522063538; cv=none;
        d=google.com; s=arc-20160816;
        b=VoUGTr+rOdt3p4nhKgaL0B67vQ4E+O8ZjlOuJcqmTKYGd7Tve5djUvLgixN9WAzcA9
         YhbEYruwLnpCCyraWtG4YHNbo2995zmcSIM/ZX7SYNo3YakaUHTFAC1rmQgM00iktCPj
         JJy3lJym87TABox2OmhvyXmLS57vMuoXQ9LAYOnStKoDz1IjbnO90hYO0bXn0N1lcqB/
         0Q/NZlqW2rm8/+eK/B0kCRFZHWq2K2mZ8uA7JeZq/VYMNTU14uTzLbaQZWm6TQw4kXQi
         1JEn6iBF8odudm0b/8zx55ePKgNS1xuSqdUYYlj0lnULH00GQYaCTiFRar0HBvlCUzbl
         SXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=k1kRx5rnZN1UNHqjeGu4R6K4i0P+Xeu/b3GGz6gqz2I=;
        b=vq9AfZ5e4oA/bqEzrhqcX/qNXZvXeTS6yzHy70WV+9IEFFi50ytMY0+PA4turGxvX1
         ho5ghP3CPqhq7pB7VO2S0i2B8BOSOFHmBurnIX3ETP87zj0eZifmXG3AxSvdkV15oBPv
         8Mt1Q9HxRfK9ZvPowpOUGMIblRtUFNN6HiojQhddC58eI3V/imOHdXRt2BNWxa27dQcQ
         79tOiwv1J/23hbJHtMLH1AAFzLw4bHgKfEksXZr3J/Vxr80dprBn3tmMCapwwECqMFk3
         48m7PxmnnvCEsUnzIaJKH98gRQikp6u+3H5oyDJlkpX1iZoC0dVIhyLAiH4jlYO+lemK
         cvew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Mon, 26 Mar 2018 13:25:26 +0200
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
Message-ID: <20180326132526.1634946e@bbrezillon>
In-Reply-To: <CAMuHMdX3TLmaN14gM4fTgzXwy1dgsMxCFBs_3wCFWM8rX=+8vA@mail.gmail.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
	<20180323110020.19080-12-boris.brezillon@bootlin.com>
	<CAMuHMdX3TLmaN14gM4fTgzXwy1dgsMxCFBs_3wCFWM8rX=+8vA@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725936015625601?=
X-GMAIL-MSGID: =?utf-8?q?1595999297097205289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 26 Mar 2018 12:12:54 +0200
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
> 
> > +- #interrupt-cells : Should be 2.  The first cell is the GPIO number.
> > +  The second cell bits[3:0] is used to specify trigger type and level flags:
> > +      1 = low-to-high edge triggered.
> > +      2 = high-to-low edge triggered.
> > +      3 = triggered on both edges.
> > +      4 = active high level-sensitive.
> > +      8 = active low level-sensitive.  
> 
> These are identical to the values in <dt-bindings/interrupt-controller/irq.h>.
> Perhaps you can refer to those definitions?

Well, I'm not sure this is allowed since DT bindings docs are
supposed to be OS-agnostic and macros defined in
<dt-bindings/interrupt-controller/irq.h> are, AFAIK, only available to
Linux.

Note that I copied these definitions from another binding ;-).

Rob, any opinion?


-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
