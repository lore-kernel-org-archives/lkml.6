Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523447564; cv=none;
        d=google.com; s=arc-20160816;
        b=gl8yCRgmxOKM9L6HAGhF9UPyV9KRDT/GTwpvP9a03dMmxo5Gp5uW9/itgyBC/RUwjv
         cx4OY7Nz2M+LO5tqenDplGGjbf7wGCFNWIw7utELeH1haPupeCb5zkuw7PXaT+4Y7dHR
         sAOetbOoq8g+jzO4xyuNf1Duki4k1buVypPA+vxxLJl8/Low5Vt7x+SHYZ5jJ6aJ0u27
         uBrMHmEbg8KAW40XjmTckMjucJlqyCJjq6yY1QsronsoG/BEtj9OS2sg7t9PM4OF0n2T
         A01DjGCvdt2CFkvEyFmmHKnqAb400sfiyQwy+jpKsFbKcv1rXrKf60w4y59q7xB+p0oi
         JX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=+xF/QQrbDaB/C2STWUBftaDCOueXgSmK3FO0WBIu0SA=;
        b=S5PjTUrLaZwoFNLXdMdXEeY28HyLDJdMF/WMpbVtTtWufdVAXEtIbUeaJlD7o7j04+
         EuD+MW/0N5NdK6Sla0JCyxbjRQqKfd7bUi1MGQM3Klu+kzpC15iCN5f66WT/wmAxQQyA
         mXZMffew5c26LBMtVzJybBxkt/2kccGUlSvQ6shvWmOIq1T1ydpHr5fN7mvi3C6GilJG
         MMLC3WJBnvqRCWrw1iPU3hKdbF7mvYtXsQ8euGvFZJDkBP9Vliz3RfWiCSZD73RtOzvs
         NwLivzPKRJGhd4RVkG82nYi1fHDLTl6blOVIOXGOgwjEvUxSeIgq+itwsvQbOa2pIodv
         33AQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DUyPo2ab;
       dkim=pass header.i=@jms.id.au header.s=google header.b=ivyWI6KY;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DUyPo2ab;
       dkim=pass header.i=@jms.id.au header.s=google header.b=ivyWI6KY;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AIpwx4/Aqmu5PtGzNci0HuzuI7OnTYQrQEc2oFxPJYTA5ygPhGTacIJEvlXMAE/2pTiQQ7y6Wkc4Z3EEJJ6tbmF6zbw=
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180410183212.16787-5-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com> <20180410183212.16787-5-jae.hyun.yoo@linux.intel.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Apr 2018 21:22:23 +0930
X-Google-Sender-Auth: FToGwyE2BzKPG5iVm8whVxLh0Rw
Message-ID: <CACPK8XcfrheC+UDB7mLPkgPRCuk8f+P830NG+cy2v6F_PJvUTw@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] Documentations: dt-bindings: Add a document of
 PECI adapter driver for Aspeed AST24xx/25xx SoCs
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Rob Herring <robh+dt@kernel.org>,
	linux-aspeed@lists.ozlabs.org, Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>, Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Fengguang Wu <fengguang.wu@intel.com>,
	Greg KH <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
	Haiyue Wang <haiyue.wang@linux.intel.com>, James Feist <james.feist@linux.intel.com>,
	Jason M Biils <jason.m.bills@linux.intel.com>, Jean Delvare <jdelvare@suse.com>,
	Julia Cartwright <juliac@eso.teric.us>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Stef van Os <stef.van.os@prodrive-technologies.com>,
	Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>, linux-hwmon@vger.kernel.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135853793781?=
X-GMAIL-MSGID: =?utf-8?q?1597450553500239996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 11 April 2018 at 04:02, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> This commit adds a dt-bindings document of PECI adapter driver for Aspeed

We try to capitalise ASPEED.

> AST24xx/25xx SoCs.
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
> +                     - aspeed,ast2400-peci: Aspeed AST2400 family PECI
> +                                            controller
> +                     - aspeed,ast2500-peci: Aspeed AST2500 family PECI
> +                                            controller
> +- reg               : Should contain PECI controller registers location and
> +                     length.
> +- #address-cells    : Should be <1>.
> +- #size-cells       : Should be <0>.
> +- interrupts        : Should contain PECI controller interrupt.
> +- clocks            : Should contain clock source for PECI controller.
> +                     Should reference clkin.

Are you sure that this is driven by clkin? Most peripherals on the
Aspeed are attached to the apb, so should reference that clock.

> +- clock_frequency   : Should contain the operation frequency of PECI controller
> +                     in units of Hz.
> +                     187500 ~ 24000000

Can you explain why you need both the parent clock and this frequency
to be specified?

> +
> +Optional properties:
> +- msg-timing-nego   : Message timing negotiation period. This value will

Perhaps msg-timing-period? Or just msg-timing?

> +                     determine the period of message timing negotiation to be
> +                     issued by PECI controller. The unit of the programmed
> +                     value is four times of PECI clock period.
> +                     0 ~ 255 (default: 1)
> +- addr-timing-nego  : Address timing negotiation period. This value will
> +                     determine the period of address timing negotiation to be
> +                     issued by PECI controller. The unit of the programmed
> +                     value is four times of PECI clock period.
> +                     0 ~ 255 (default: 1)
> +- rd-sampling-point : Read sampling point selection. The whole period of a bit
> +                     time will be divided into 16 time frames. This value will
> +                     determine the time frame in which the controller will
> +                     sample PECI signal for data read back. Usually in the
> +                     middle of a bit time is the best.
> +                     0 ~ 15 (default: 8)
> +- cmd_timeout_ms    : Command timeout in units of ms.
> +                     1 ~ 60000 (default: 1000)
> +
> +Example:
> +       peci: peci@1e78b000 {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0x0 0x1e78b000 0x60>;
> +
> +               peci0: peci-bus@0 {
> +                       compatible = "aspeed,ast2500-peci";
> +                       reg = <0x0 0x60>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       interrupts = <15>;
> +                       clocks = <&clk_clkin>;
> +                       clock-frequency = <24000000>;
> +                       msg-timing-nego = <1>;
> +                       addr-timing-nego = <1>;
> +                       rd-sampling-point = <8>;
> +                       cmd-timeout-ms = <1000>;
> +               };
> +       };
> --
> 2.16.2
>
