Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523901578; cv=none;
        d=google.com; s=arc-20160816;
        b=nkfa0g9/elsF78o1s8vH1UmkPr7A4FF12tpr5oaDE6vrYePJr2Lwy5JOr0Gx3yErzA
         98nB4E9axZtGevPZH4GBMSmTfmpr8gJHqGBpUPk7a76BEEZLDckhBcBwesiAiX7ZWlIZ
         e207O+3cwk8OFaVME9WKHaF482GnjNmrZcKKrxPbhu2nzPhPzt/td1bCN0zKASkylCak
         lJ0W64iEVYvHvU+BmTvxBIJk0b5dxRphZ+bFSu3pJy8/sMmUYG9eFiFQb/acJ2LmAqHf
         gqKB//HHR9FOZTVODmSItp6M1VdyyFADnhnMe8uoSSFkm5hNAsV3VAVAiPkiDyoXSVhw
         OiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=it7fvg/RmS45jORTLrF+0fEudoPMAAjNAUFbU82WO70=;
        b=uMvvwVBJWEl+AlPMPQYYkBDzbzwXtQ/7Ieurli6mEN/sqx/YBgvTF7OaCXUVHnWmFR
         3nVzdqZ/py7bpiGUUKThJFSINVhhtxE6sIBIlV9y4zhb1DC/xwZeEtcjSSgRT7qGfmIX
         9PrUkhlm0nttOE28OmESDRpqmIJsxwDvdaaz3ct7OH+vgtgwEjaFVqJkcm0gLI8UVZQ5
         iJB4lAgCxm1DUcITo8sQc4t9aTF9lja7+GxBM31tq5uu++0mxvjuNQv+pTTPeM5n4xN0
         ncHG5Zx2shOzHmbjuHn6wgSZGszYhdt/M2XFBY+IhHaF0w5sOB4pzeJNsRrKTjdr3Z4X
         GLNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx48KtQi9/ERrGRe5futmHihby/75KSwZyiTr8vw3ELqCZh1MqhUESK+HP0+kVy/WBABS5xSMRA==
Date: Mon, 16 Apr 2018 12:59:36 -0500
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
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 01/10] Documentations: dt-bindings: Add documents of
 generic PECI bus, adapter and client drivers
Message-ID: <20180416175936.4vcse73mrnyk242m@rob-hp-laptop>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-2-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410183212.16787-2-jae.hyun.yoo@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385124256903080?=
X-GMAIL-MSGID: =?utf-8?q?1597926621007888223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 11:32:03AM -0700, Jae Hyun Yoo wrote:
> This commit adds documents of generic PECI bus, adapter and client drivers.

"dt-bindings: ..." for the subject prefix please.

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
>  .../devicetree/bindings/peci/peci-adapter.txt      | 23 ++++++++++++++++++++
>  .../devicetree/bindings/peci/peci-bus.txt          | 15 +++++++++++++
>  .../devicetree/bindings/peci/peci-client.txt       | 25 ++++++++++++++++++++++

This should be all one document.

>  3 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-adapter.txt
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-bus.txt
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-client.txt
> 
> diff --git a/Documentation/devicetree/bindings/peci/peci-adapter.txt b/Documentation/devicetree/bindings/peci/peci-adapter.txt
> new file mode 100644
> index 000000000000..9221374f6b11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-adapter.txt
> @@ -0,0 +1,23 @@
> +Generic device tree configuration for PECI adapters.
> +
> +Required properties:
> +- compatible     : Should contain hardware specific definition strings that can
> +		   match an adapter driver implementation.
> +- reg            : Should contain PECI controller registers location and length.

No need for these 2 here.

> +- #address-cells : Should be <1>.
> +- #size-cells    : Should be <0>.

Some details on the addressing for PECI would be good.

> +
> +Example:
> +	peci: peci@10000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x10000000 0x1000>;
> +

This part of the example is not relevant. Just start with the adapter 
node.

> +		peci0: peci-bus@0 {
> +			compatible = "soc,soc-peci";
> +			reg = <0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/peci/peci-bus.txt b/Documentation/devicetree/bindings/peci/peci-bus.txt
> new file mode 100644
> index 000000000000..90bcc791ccb0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-bus.txt
> @@ -0,0 +1,15 @@
> +Generic device tree configuration for PECI buses.
> +
> +Required properties:
> +- compatible     : Should be "simple-bus".

I don't understand what this has to do with PECI? "simple-bus" already 
has a defined meaning.

> +- #address-cells : Should be <1>.
> +- #size-cells    : Should be <1>.
> +- ranges         : Should contain PECI controller registers ranges.
> +
> +Example:
> +	peci: peci@10000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x10000000 0x1000>;
> +	};
> diff --git a/Documentation/devicetree/bindings/peci/peci-client.txt b/Documentation/devicetree/bindings/peci/peci-client.txt
> new file mode 100644
> index 000000000000..8e2bfd8532f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-client.txt
> @@ -0,0 +1,25 @@
> +Generic device tree configuration for PECI clients.
> +
> +Required properties:
> +- compatible : Should contain target device specific definition strings that can
> +	       match a client driver implementation.

Bindings are for h/w, not client drivers.

How are PECI devices defined?

> +- reg        : Should contain address of a client CPU. Address range of CPU
> +	       clients is starting from 0x30 based on PECI specification.
> +	       <0x30> .. <0x37> (depends on the PECI_OFFSET_MAX definition)

8 devices should be enough for anyone...

Where is PECI_OFFSET_MAX defined?

> +
> +Example:
> +	peci-bus@0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		< more properties >
> +
> +		function@cpu0 {

Not a valid node name. "function@30" is what it probably should be. For 
a new bus you can define unit-address format you like, but it must be 
based on the contents of reg. However, it doesn't look like you should 
create anything special here.

> +			compatible = "device,function";
> +			reg = <0x30>;
> +		};
> +
> +		function@cpu1 {
> +			compatible = "device,function";
> +			reg = <0x31>;
> +		};
> +	};
> -- 
> 2.16.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
