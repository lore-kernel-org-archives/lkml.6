Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523902236; cv=none;
        d=google.com; s=arc-20160816;
        b=mxNwrhmXJO/FJ+aVDRPg7sdvV9EsDlbMujRvpe6j7pXDb5j1x2z0TWrXnkYJM4nKGk
         Yo58bzdGoPSRu6o/Tc0HNmNYn+qRqwdhAE7MyMWQl0EskkKZQXXNzhyVzd/jCWidTMok
         AbCz8u/5mCCPcQHZKtErLSVL2M0qHd6RJfT3IcHUta6jDMCt1rL4VyyotKZl96IyjEAF
         uJIShOegJ8M59xpSBhqBC9YxvTa259kLZDcea0qb9E8jHEzoHtfRS7vYsKJnCnCUVG9X
         AzunUDxHh52b5u7XpRoSauEgvbW0OjrOES9HbIoBXSwsiNB/EVlJWLJeHjYHmKBRkDiw
         APTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=GSC54G1Evvb1gkv/uacAKledYzpWwpthqr7YuI8KJx8=;
        b=w93bA+30uWqGS+awWG1HRVgbHyOzqiccoutYxLW8ukAyOqvFhRdwFTLRAFPUK7LEM9
         xGXfo+/8GnypNNHGA6+pvDCLjvhTgQST+xHgM9avDeumMVUQAb5/VBcjPru2OekvuHbG
         SaLw7Zb9zYepgFPvpjfX4nPyXhltV8m3v9f/GQwSKkgU/pjhQfd8MhJxSqyw1BmUhSuG
         MrfB1n83jpDogYLsrmSzCzdsAJixx1qFlz5X1bhwn5Vwg1bQ3CskUI41VlSRPKIMCDSf
         SbS/Khed3nAMMyKMBQiB4KNS0t9fpqQsEKAPHGMptJX39nY30NaAjYWwIJGRQYwlxr/O
         Q/cQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx48LTJ7hgMli85SR7mQQRR2FbQJgv2UpxVCQralKb6UTIcfbIyypc379LTrwb3ZYawjMP3Jamg==
Date: Mon, 16 Apr 2018 13:10:35 -0500
From: Rob Herring <robh@kernel.org>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
	Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Haiyue Wang <haiyue.wang@linux.intel.com>,
	James Feist <james.feist@linux.intel.com>,
	Jason M Biils <jason.m.bills@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
	Julia Cartwright <juliac@eso.teric.us>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stef van Os <stef.van.os@prodrive-technologies.com>,
	Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
	Vernon Mauery <vernon.mauery@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v3 04/10] Documentations: dt-bindings: Add a document of
 PECI adapter driver for Aspeed AST24xx/25xx SoCs
Message-ID: <20180416181035.rcjvt4rlrwaj5yxf@rob-hp-laptop>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-5-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410183212.16787-5-jae.hyun.yoo@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135853793781?=
X-GMAIL-MSGID: =?utf-8?q?1597927312218190904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 11:32:06AM -0700, Jae Hyun Yoo wrote:
> This commit adds a dt-bindings document of PECI adapter driver for Aspeed
> AST24xx/25xx SoCs.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> Reviewed-by: James Feist <james.feist@linux.intel.com>
> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Julia Cartwright <juliac@eso.teric.us>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Cc: Milton Miller II <miltonm@us.ibm.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stef van Os <stef.van.os@prodrive-technologies.com>
> Cc: Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  .../devicetree/bindings/peci/peci-aspeed.txt       | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
> new file mode 100644
> index 000000000000..4598bb8c20fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
> @@ -0,0 +1,60 @@
> +Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
> +
> +Required properties:
> +- compatible        : Should be "aspeed,ast2400-peci" or "aspeed,ast2500-peci"
> +		      - aspeed,ast2400-peci: Aspeed AST2400 family PECI
> +					     controller
> +		      - aspeed,ast2500-peci: Aspeed AST2500 family PECI
> +					     controller
> +- reg               : Should contain PECI controller registers location and
> +		      length.
> +- #address-cells    : Should be <1>.
> +- #size-cells       : Should be <0>.
> +- interrupts        : Should contain PECI controller interrupt.
> +- clocks            : Should contain clock source for PECI controller.
> +		      Should reference clkin.
> +- clock_frequency   : Should contain the operation frequency of PECI controller
> +		      in units of Hz.
> +		      187500 ~ 24000000

This is the frequency of the bus or used to derive it? It would be 
better to specify the bus frequency instead and have the driver 
calculate its internal freq. And then use "bus-frequency" instead.

> +
> +Optional properties:
> +- msg-timing-nego   : Message timing negotiation period. This value will
> +		      determine the period of message timing negotiation to be
> +		      issued by PECI controller. The unit of the programmed
> +		      value is four times of PECI clock period.
> +		      0 ~ 255 (default: 1)
> +- addr-timing-nego  : Address timing negotiation period. This value will
> +		      determine the period of address timing negotiation to be
> +		      issued by PECI controller. The unit of the programmed
> +		      value is four times of PECI clock period.
> +		      0 ~ 255 (default: 1)
> +- rd-sampling-point : Read sampling point selection. The whole period of a bit
> +		      time will be divided into 16 time frames. This value will
> +		      determine the time frame in which the controller will
> +		      sample PECI signal for data read back. Usually in the
> +		      middle of a bit time is the best.
> +		      0 ~ 15 (default: 8)
> +- cmd_timeout_ms    : Command timeout in units of ms.
> +		      1 ~ 60000 (default: 1000)

s/_/-/


All these either need vendor prefixes or should be standard properties 
for PECI adapters. I think probably the latter case. If so, the first 
2 should probably be in units of clocks (not 4 clocks). And they should 
then be documented in the common PECI binding doc.

> +
> +Example:
> +	peci: peci@1e78b000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x1e78b000 0x60>;

No need to show this part in examples.

> +
> +		peci0: peci-bus@0 {
> +			compatible = "aspeed,ast2500-peci";
> +			reg = <0x0 0x60>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <15>;
> +			clocks = <&clk_clkin>;
> +			clock-frequency = <24000000>;
> +			msg-timing-nego = <1>;
> +			addr-timing-nego = <1>;
> +			rd-sampling-point = <8>;
> +			cmd-timeout-ms = <1000>;
> +		};
> +	};
> -- 
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
