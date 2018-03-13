Return-Path: <alexandre.belloni@bootlin.com>
X-Google-Smtp-Source: AG47ELtG3K+UromyWogcaCHr8cG9TU6igUIr74KSKYNp1WW5wxkSWrNsQBxmjQAuG8iUaXlGGbE5
ARC-Seal: i=1; a=rsa-sha256; t=1520901432; cv=none;
        d=google.com; s=arc-20160816;
        b=jRINi9C9MFNLl7YWYz3u45WX5Rxe7LLOyQca5L4YcJ3O8MfYCiKLcIaSjhX7KsdxmF
         h5pz5HBvSQjqhX0wR2Te3WY/KMWDLoQdV/+BX6lSAPZ6lHeoFbB+5W9TjN73k1Ugpox3
         vyQhtCrnvL3h51AWy+K5P/KQVHedQCHkqc2FEzPktxCvRHWNTgD7D01jZ+wesTBWKva1
         hJHgYJ6F2AlXG9BerLNXBaP/TozGWEk4zNI5Uqz6JDq3WhZRZMcTqlh+U9eZlCJy2I3V
         ruNOfB1mQO/7ed21X2QZjoZlUsYiyycHK2EwFXjeKITdVIKJaPSKnSCgWf6T96IqqybA
         GIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=jDpQaS5R2SAymydEcYuPbraDHo7dxlHWSuS02q9dguM=;
        b=tk1CJ5y+wEol+8oK0zIdS2cLjQZCzDoSXaLPz/QCE90tNiD04XFDA8g79QCbpQeaVa
         uySDUpqW1AR1GC/ZWPwSw0Pkf+7b7UnWWxkR3iZndVTzfaW6WGyHJR0FIq84GKVL2eK+
         cN46/gdrH9EzES5ZsNjxY3Chx0QVFeGPRGaN5aaalSyAtthtR3sxySJX7A+ch4FHT4Xf
         OmiLYsgpWmHBbYCa4ntb3OA1KOeXSlSX+MGFrCB9C64SPKBLxyicZhoV0BHFFTIrGdl/
         BHL/wGjy05Mzp+t9JzULyIrs5sEk2Ng8mEfoPVqnbJ5HewrW8HlTGAvU20QjOpavAILN
         7myw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@bootlin.com
Date: Tue, 13 Mar 2018 01:37:00 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
	Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, lee.jones@linaro.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Heiko Stuebner <heiko@sntech.de>,
	Brian Norris <briannorris@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	linux-rockchip@lists.infradead.org,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org,
	stephen lu <lumotuwe@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v5 2/4] rtc: at91sam9: Set name of regmap_config
Message-ID: <20180313003700.GG3795@piout.net>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
 <20180312095142.30854-3-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312095142.30854-3-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594725090849470563?=
X-GMAIL-MSGID: =?utf-8?q?1594780740372580572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12/03/2018 at 17:51:40 +0800, Jeffy Chen wrote:
> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v5: None
> Changes in v4:
> Not to use rtc dev to init regmap, the gpbr is not directly related to
> the rtc.
> 
> Changes in v3: None
> 
>  drivers/rtc/rtc-at91sam9.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
