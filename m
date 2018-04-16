Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523902464; cv=none;
        d=google.com; s=arc-20160816;
        b=XCguZbX03Ixq9sVF2gNewk6pbag+DB/CtW4LkQliVxpl/28UJrGPdmjGGhEkPrO/ox
         NUdavFCY1DtaKbD7+w3hnwiX1+QTiKXwN4JrsylT9htMjH0piHL5kPGN/776GGycL8wO
         BtsUq3mqAftTmvkEQ+hKUyxMpstYMLEmp1U1uVo+Pnip7PAV44ajgvWfVjusff/l4cle
         87/rjZ7tyTtjVUBWiFoWbotz4F/gsS3jZyhebcJuXY5BuNpYOoMoyjNABLcwv76qbk+T
         Q98jtCUMp+xyllmYWY0AyEQYuNpRs2g54b05vhcIQYcRHcjVNO+ll6LgHa2NmqlZ+WN/
         aEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=5ncPdJs0NSduTmGTHETPjedHn/Z7t05UxemEBzO5400=;
        b=efE+8F5IchbOcKbdlRP+SEidbEsBaQ6i7pOElOaWO0U8fdjHUWEcKg6coYSdH+e50T
         Er+bR5hIvvP1wke3U7UKGLYJRHKmKLrR5LN5fa70vP1FLOmaP8RrsMEw0nFfJfpNpH1I
         f9wgTkirH0wlteU7hh5xxcPKD2a6ez0ouRVlnnnYbpJWNpAoqGhuQ+pygBQ+NBA+AuaF
         g3PoI8zFfwsGhLeSE5CW8ByHha2rpuO66xqtsY77mb7Fx7Tr3OzaktdLxKQjXj9IqFtH
         GZlK6w2iusE3E4JHcSe4N5hHINiT6DWFXKFENz8Pq6NDYRYhIpXkEy+QDiolcXC+wyUx
         RgRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4+I/bpqOktBJf1+WuW6UPaNJliu9oACn+gdk+bGt3v7WymvF+v+8Bim3aiHnTtZ+UgrkTj60Q==
Date: Mon, 16 Apr 2018 13:14:23 -0500
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
Subject: Re: [PATCH v3 07/10] Documentation: dt-bindings: Add documents for
 PECI hwmon client drivers
Message-ID: <20180416181423.t4vf7sugv6z3aw5h@rob-hp-laptop>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-8-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410183212.16787-8-jae.hyun.yoo@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385139320717723?=
X-GMAIL-MSGID: =?utf-8?q?1597927550743812937?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 11:32:09AM -0700, Jae Hyun Yoo wrote:
> This commit adds dt-bindings documents for PECI cputemp and dimmtemp client
> drivers.

"dt-bindings: hwmon: ..." for the subject.

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
>  .../devicetree/bindings/hwmon/peci-cputemp.txt     | 24 +++++++++++++++++++++
>  .../devicetree/bindings/hwmon/peci-dimmtemp.txt    | 25 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
> new file mode 100644
> index 000000000000..d5530ef9cfd2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
> @@ -0,0 +1,24 @@
> +Bindings for Intel PECI (Platform Environment Control Interface) cputemp driver.
> +
> +Required properties:
> +- compatible : Should be "intel,peci-cputemp".
> +- reg        : Should contain address of a client CPU. Address range of CPU
> +	       clients is starting from 0x30 based on PECI specification.
> +	       <0x30> .. <0x37> (depends on the PECI_OFFSET_MAX definition)

Again, where is PECI_OFFSET_MAX defined? It can't depend on something in 
the kernel.

> +
> +Example:
> +	peci-bus@0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		< more properties >
> +
> +		peci-cputemp@cpu0 {
> +			compatible = "intel,peci-cputemp";
> +			reg = <0x30>;
> +		};
> +
> +		peci-cputemp@cpu1 {
> +			compatible = "intel,peci-cputemp";
> +			reg = <0x31>;
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt b/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
> new file mode 100644
> index 000000000000..56e5deb61e5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
> @@ -0,0 +1,25 @@
> +Bindings for Intel PECI (Platform Environment Control Interface) dimmtemp
> +driver.
> +
> +Required properties:
> +- compatible : Should be "intel,peci-dimmtemp".
> +- reg        : Should contain address of a client CPU. Address range of CPU
> +	       clients is starting from 0x30 based on PECI specification.
> +	       <0x30> .. <0x37> (depends on the PECI_OFFSET_MAX definition)
> +
> +Example:
> +	peci-bus@0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		< more properties >
> +
> +		peci-dimmtemp@cpu0 {

unit-address is wrong.

It is a different bus from cputemp? Otherwise, you have conflicting 
addresses. If that's the case, probably should make it clear by showing 
different host adapters for each example.

> +			compatible = "intel,peci-dimmtemp";
> +			reg = <0x30>;
> +		};
> +
> +		peci-dimmtemp@cpu1 {
> +			compatible = "intel,peci-dimmtemp";
> +			reg = <0x31>;
> +		};
> +	};
> -- 
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
