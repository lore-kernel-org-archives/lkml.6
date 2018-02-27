Return-Path: <p.zabel@pengutronix.de>
X-Google-Smtp-Source: AG47ELv7L2F1W0YJUq5E7LgCz9ZNyotp94QgC5aIZ/yNheuUXcYKsbEdpiqac3YqFb5JItsmMwY/
ARC-Seal: i=1; a=rsa-sha256; t=1519719663; cv=none;
        d=google.com; s=arc-20160816;
        b=DCpMQijSCF6l+OQ6auE2EXji2SSP9LKSuW0ssIR/kqls0QCe9zr1nBmAMMEVvfUMp8
         Iv59fJuc23BdB5rDpTRAfxNGssDC7hySOvgMknukUhOBvw+9hP/aMQuhzx2GmWS7E7PH
         ZwEQI6IoWUrvWDRWF8OFSn2Cj3QL+wr16obfo/WI/PH3RGzrwDGyrCshl6FmEC5cQ5kx
         vI7ZgjjaAzczhVWtPYvO1p+v5ik5cJ+9sqQWMhXvhhnPb6W6CPqfmBlrBVaCmz2ka3pu
         Fp+vT0jE8C1Ttp5VBoHNssvoaFUCObQ6Xyd5Hjqa/Fu7C0d3N1ryBZC1uIBwyACbWtaw
         AnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=FffKU4qtxjvq31PAHMEzlrNegfwalAVMbvtgn9gJHkk=;
        b=WnUb9b6bjm2vMFXZC9SdjsXiGeJFdR1o7xiBkNCLEGaamHK8n/aIDDAveNEHwhKU0r
         lz89mWC1Xw+3itGk6UjIXxKYQq2TWsjaHNPg6MrwcYsxt15H4jXt7uvyROoO8HVyCVd6
         3taP0ggYE31cCnxz6WLn77BBDd6eBrMS1glkhx9gbD7l9GjW7UOtwXhyHUhJx7DEn35Y
         sfDG6NqIWkwww5sIr+p6Pp2erjAe//8UU80zBDc8+ip/dbBGweCheTSgtcGdP0TWrA1c
         xHXWY2S2U+ojoFU4ENAMKuDmcf47xtCkwL2/HK6ikAFntdeNuG40VWFoJk/fvTpHWmzj
         YWsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of p.zabel@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=p.zabel@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of p.zabel@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <1519719639.3402.2.camel@pengutronix.de>
Subject: Re: [PATCH v8 1/2] dt-bindings: media: Add Allwinner V3s Camera
 Sensor Interface (CSI)
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Yong Deng <yong.deng@magewell.com>, Maxime Ripard
	 <maxime.ripard@free-electrons.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>,  Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai
 <wens@csie.org>, "David S. Miller" <davem@davemloft.net>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij
 <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, Hans
 Verkuil <hans.verkuil@cisco.com>, Stanimir Varbanov
 <stanimir.varbanov@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Ramesh
 Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,  Yannick Fertre
 <yannick.fertre@st.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Todor
 Tomov <todor.tomov@linaro.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Date: Tue, 27 Feb 2018 09:20:39 +0100
In-Reply-To: <1519697256-32472-1-git-send-email-yong.deng@magewell.com>
References: <1519697256-32472-1-git-send-email-yong.deng@magewell.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593518132578299122?=
X-GMAIL-MSGID: =?utf-8?q?1593541566346414425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-02-27 at 10:07 +0800, Yong Deng wrote:
> Add binding documentation for Allwinner V3s CSI.
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Yong Deng <yong.deng@magewell.com>
> ---
>  .../devicetree/bindings/media/sun6i-csi.txt        | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> new file mode 100644
> index 000000000000..2ff47a9507a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> @@ -0,0 +1,59 @@
> +Allwinner V3s Camera Sensor Interface
> +-------------------------------------
> +
> +Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> +interface and CSI1 is used for parallel interface.
> +
> +Required properties:
> +  - compatible: value must be "allwinner,sun8i-v3s-csi"
> +  - reg: base address and size of the memory-mapped region.
> +  - interrupts: interrupt associated to this IP
> +  - clocks: phandles to the clocks feeding the CSI
> +    * bus: the CSI interface clock
> +    * mod: the CSI module clock
> +    * ram: the CSI DRAM clock
> +  - clock-names: the clock names mentioned above
> +  - resets: phandles to the reset line driving the CSI
> +
> +Each CSI node should contain one 'port' child node with one child 'endpoint'
> +node, according to the bindings defined in
> +Documentation/devicetree/bindings/media/video-interfaces.txt. As mentioned
> +above, the endpoint's bus type should be MIPI CSI-2 for CSI0 and parallel or
> +Bt656 for CSI1.
> +
> +Endpoint node properties for CSI1
> +---------------------------------
> +
> +- remote-endpoint	: (required) a phandle to the bus receiver's endpoint
> +			   node
> +- bus-width:		: (required) must be 8, 10, 12 or 16
> +- pclk-sample		: (optional) (default: sample on falling edge)

It would be helpful to state that 1 is rising edge and 0 is falling
edge, see for example ov5640.txt

regards
Philipp
