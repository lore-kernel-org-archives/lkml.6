Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AIpwx4/CDO1gTq1oAiGl97Ph+FLzwdS5IyVmFGkTDfP6EkMoElQgU4e4czgs2+8JZK3hbYxSYu5b
ARC-Seal: i=1; a=rsa-sha256; t=1523542651; cv=none;
        d=google.com; s=arc-20160816;
        b=Whf/LsYpgufLGJY/mlsEWwxqN/j/dTW14W6yFQ+neimTs9b44ZH9yU97YDNgNFGdvD
         dHcoaGyOn9CD8pTFsYpbLBJTh/GM7ry+713M3ig45FzN6Dts2E2CkGa9SURhcpRaHU4e
         y3+rTvPeaReAcrDxQfcEJEcqbh/nQHiTyRHDIJegcYE8uX0Xx0QrEMlbbCNQx4e/gk+H
         95vV2gB4wgPqf4B9nrNZtMPjnegGuaabd8tkKRaPM5ELcGBjViRrV9K6Lq0Foc4Ry3DP
         iJWTSdSUlKUC4hn+hSaMIaEHMAN8sexiY2JTNmASls+KwclLDyl3F4vAKq3hhPiUj+OX
         e2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Zp5biTv5wRK8Oo1me/58tmo1fA9SF/awNX5OwupD5mQ=;
        b=u88TstwOJW/cRhenRB+2lSy/+fn2tnqWO2AKHEECXM+JyzavzT0dMNCqYDVReVYf39
         1j68LX1pf9DtZJVXnDikApu/WMEql8uGtH9i95d9bHzxhHqbWZhnVOuz+QAXV3Eh5Fn8
         zmSitsoYIRp/XeK/2AtbPB3oZJhnoV5tX7JW1wwgqxbkLtxGgK71YhqlLS5kpv6dm/L5
         isVy8IbDtrWIToE2UB67vi0sw2lYif1CUc+0PJnWhItYdfnKmd1hX3kyhLiPzcAMBie7
         LeFs7uAfeokV8uyjABKA5e2IizXrNB85tpHysY6S+oVvDgmpfcspgIiWuqCohyAil92s
         MM9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=N1YaeeOy;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=N1YaeeOy;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Thu, 12 Apr 2018 16:17:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Phil Elwell <phil@raspberrypi.org>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: Document the DT bindings for lan78xx
Message-ID: <20180412141725.GN28963@lunn.ch>
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
 <1523541336-145953-5-git-send-email-phil@raspberrypi.org>
 <20180412140409.GK28963@lunn.ch>
 <0bcc10cd-2a25-311f-d006-ddefe47567dc@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bcc10cd-2a25-311f-d006-ddefe47567dc@raspberrypi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597548898658681732?=
X-GMAIL-MSGID: =?utf-8?q?1597550259038709435?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 03:10:57PM +0100, Phil Elwell wrote:
> Hi Andrew,
> 
> On 12/04/2018 15:04, Andrew Lunn wrote:
> > On Thu, Apr 12, 2018 at 02:55:36PM +0100, Phil Elwell wrote:
> >> The Microchip LAN78XX family of devices are Ethernet controllers with
> >> a USB interface. Despite being discoverable devices it can be useful to
> >> be able to configure them from Device Tree, particularly in low-cost
> >> applications without an EEPROM or programmed OTP.
> >>
> >> Document the supported properties in a bindings file, adding it to
> >> MAINTAINERS at the same time.
> > 
> > Hi Phil
> > 
> > How you link an OF node to a USB device is not obvious. Could you
> > please include either a pointer to some binding documentation, or make
> > your example show it.
> 
> Thanks for the feedback. Would you consider this (lifted from the Pi 3B+ Device Tree)
> a sufficient example?

Yes, this is good.

Thanks
     Andrew
