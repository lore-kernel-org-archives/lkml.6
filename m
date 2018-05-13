Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526217279; cv=none;
        d=google.com; s=arc-20160816;
        b=vLceP1wUh/L9ArCo0f5YNc6TZh1scTKOdO/Azzx49/mFSK8Z4lxwrUHexkKBqe6HqQ
         EWhvaUuI2XymEPpUYFHW6O0d+HA8Fmw9Ohvqhq8L0Ti9/bR1y6Pe5cdDiVw96Kgm9/eR
         eW8tURSKIm4XNH9vgfg63MrP7E5gnMmprC3ULfcjE+edL/ArVzNBNb/SlizX5Pbf4Brb
         kC8t0Fw51zLT948WLvD9cq9SWdmcOLR3lEDAfRIFFGMDtKjGi9pTPWCiHoz5dV8HpJsQ
         NpH7E072M9nvri2wZFGEQYCFDt7+j/pVefJOypA5kPKK5OyfUwatR05FyrdEnaoeRdPe
         TbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=HDXCWzdi3SuZV8h2DpuBcShlU3+DllZ9X+k5jJ5beYU=;
        b=nINHrAqLNLTMFswKULoPcdVNRCEZsaffkdbpMEEXemUwguuEEi2eRCr4gTA0Aidy9v
         GLpdas672hFHOoK7BebWraWxj1THIwF3qKS/Cxxqw30cQLSVIPVc6Alm3hjumGsuxFjF
         Ojw47uPbnNV28LWQIxPrpJaqAgzkmxG07Ox8kYSo2qv6SCLJQ1WIdBsq145YLQUw4qBl
         /qUkjSn55MvHhyg0PKCRe+MS/BRSCdYAcx8+nVs1+WFr5qlM2BLNHk25SvdmDfrJV36M
         6MDK2rKfveDkXhyQCo3wmgWgZKhMm1HYg1w9FWzjYTd0xcBGq13CZO+dTaeN1YCUURl9
         sUqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oiDPdnvZ;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oiDPdnvZ;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZozWJsitYfEkNSU1mWuMCRnILHBFpzLyofk0pPePw0nRp0cQVOACuw26sfd23NvE+YODt6Q2ZrBZ/zlH3q5PvA=
MIME-Version: 1.0
In-Reply-To: <20180511103822.31698-4-radu.pirea@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com> <20180511103822.31698-4-radu.pirea@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 16:14:38 +0300
Message-ID: <CAHp75VdXrQ_NKBmP0L9o8_2MSqehNuriQ0gBJ3dDWQdegALSaA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] MAINTAINERS: add at91 usart spi driver
To: Radu Pirea <radu.pirea@microchip.com>
Cc: devicetree <devicetree@vger.kernel.org>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
	linux-spi <linux-spi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	Richard Genoud <richard.genoud@gmail.com>, alexandre.belloni@bootlin.com,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600163727741928868?=
X-GMAIL-MSGID: =?utf-8?q?1600354810580549028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 1:38 PM, Radu Pirea <radu.pirea@microchip.com> wrote:
> Added entry for at91 usart mfd driver.
>

You are adding a record for not existing file?

> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca06c6f58299..9243b9007966 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9199,6 +9199,13 @@ S:       Supported
>  F:     drivers/mfd/at91-usart.c
>  F:     include/dt-bindings/mfd/at91-usart.h
>
> +MICROCHIP AT91 USART SPI DRIVER
> +M:     Radu Pirea <radu.pirea@microchip.com>
> +L:     linux-spi@vger.kernel.org
> +S:     Supported
> +F:     drivers/spi/spi-at91-usart.c
> +F:     Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
> +
>  MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
>  M:     Woojung Huh <Woojung.Huh@microchip.com>
>  M:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
> --
> 2.17.0
>



-- 
With Best Regards,
Andy Shevchenko
