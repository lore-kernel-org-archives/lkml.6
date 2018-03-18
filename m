Return-Path: <vz@mleia.com>
X-Google-Smtp-Source: AG47ELtf/UqbuaggmuGmZb17M+XWxk/u4//v4abiUY/IWhoshZHDxyyzMcORvpTq/s9DqTF4GaJU
ARC-Seal: i=1; a=rsa-sha256; t=1521410264; cv=none;
        d=google.com; s=arc-20160816;
        b=HlSTfhntELoL5LSEfkpkUanpe1nd+3D91yALdbSHy0mYolVeVC61/WJGvvHEXnx322
         AYt+jsXjUXKCiU3h9ug74io/L6M04I2d0DErsBr+JfMQFPAjhmeUlJo+6NwwXqQeGcpC
         L49fYErGIKCab1nOPv7EJUIf+06LEz1ayXqHfOM/pNZBrvEN1C22UjDM7jpDWzkpXSDn
         6DS8UkS9zyIC4nBx1i4874N1a392y7+QULLpHlK119VmaGzNSi1H5FKV4udt4p6RzYuX
         1baRe0IBRqoXyqeEyewuORmeY2/Oju3axK+DaVNdOvT6UJoIYjxt3abXfAi2dPHaTiRg
         5tEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=7i0sddotZR457jqhrO7f47yb1Q/HH2MlEwTP9XOkwVk=;
        b=xUEvQ0rJ3S6zdvYqVBHuPc608TgX6FRFmY65d7fUvrua59DmPdcRGh8DTIGZ8IgFig
         lhOV1rDX5L93ho2zhvslbAPPK8pW90i8Eql3Vh2hrm/P0fKe21rUhc2ic/tZoiv6Y/xc
         /vzT2hbcrri2heRMKFTuYQBbU5Q8r1jXgWNir7RFg2y6US+Xh3pZZgs1z5bl6OxWjeeU
         UhwqQGVM03IKpbnfuo0v1v2yw4AX404qgg2f/yJFoeFv4LEPlcYDz/WuJAfSbEdQFZec
         AY37fiyEEfK2WOEnSFTlnrp9EjLcHe9XjY1ij/yutI9s6WTL1wtp1HTqpuIQKrxSA9Jy
         wLcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of vz@mleia.com designates 178.79.152.223 as permitted sender) smtp.mailfrom=vz@mleia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of vz@mleia.com designates 178.79.152.223 as permitted sender) smtp.mailfrom=vz@mleia.com
Subject: Re: [PATCH v5 3/4] clk: lpc32xx: Set name of regmap_config
To: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
 broonie@kernel.org, alexandre.belloni@bootlin.com
Cc: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
 Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, lee.jones@linaro.org,
 Emil Renner Berthing <kernel@esmil.dk>, Heiko Stuebner <heiko@sntech.de>,
 Brian Norris <briannorris@chromium.org>, Thomas Gleixner
 <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>,
 linux-rockchip@lists.infradead.org,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, Matthias Kaehlcke <mka@chromium.org>,
 devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Gabriel Fernandez <gabriel.fernandez@st.com>,
 linux-clk@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Jerome Brunet <jbrunet@baylibre.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
 <20180312095142.30854-4-jeffy.chen@rock-chips.com>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <23a9cbf8-9b1d-f7ec-b980-a16c9b2c4d84@mleia.com>
Date: Sun, 18 Mar 2018 23:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312095142.30854-4-jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180318_215743_314057_F80A4267 
X-CRM114-Status: GOOD (  17.32  )
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594725097578676295?=
X-GMAIL-MSGID: =?utf-8?q?1595314289165989947?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jeffy,

On 03/12/2018 11:51 AM, Jeffy Chen wrote:
> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> 
>  drivers/clk/nxp/clk-lpc32xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
> index f5d815f577e0..a2a0a7f3bc57 100644
> --- a/drivers/clk/nxp/clk-lpc32xx.c
> +++ b/drivers/clk/nxp/clk-lpc32xx.c
> @@ -67,6 +67,7 @@
>  #define LPC32XX_USB_CLK_STS		0xF8
>  
>  static struct regmap_config lpc32xx_scb_regmap_config = {
> +	.name = "lpc32xx-scb",

please rename it to "scb", LPC32xx SoC name is already known from the context.

When it's done, feel free to add to the next version my

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

>  	.reg_bits = 32,
>  	.val_bits = 32,
>  	.reg_stride = 4,
> 

Thank you for the change.

--
With best wishes,
Vladimir
