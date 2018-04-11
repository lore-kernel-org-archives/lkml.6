Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523447541; cv=none;
        d=google.com; s=arc-20160816;
        b=reYzf0bP4SlCM87lQTRo2kp/nUasZCTq3+ogfWlF3Wz5OmvsCNdLX+odgCuWMBH15A
         5rxwWZnVyhhctQNX+Wv5IDAvrgcThcDoOFXQbSNH/EuA8k9yTdx+EitTxzXOR1mHePp8
         87qBxw1viuTatUB/ILGt4j3KRh+RunnEPY5M7giKsRjWd8/O0DOoQ5VC6UaGlg/98A3f
         jD+Vnenw6ior4P/9rXe8y9pRDdVpK7+HV9sxYqIClzlOkhWuVTR67uaGOdVAjuFVD32J
         TUNuzHOVzM3h/6whRViQ2WQnCnT6Y+3yOsS0gU34MZFBjDY6citAEk5hinkRAXIY4681
         twvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=txYX6GDr7IC9OiqUgoLl8hc0t7gEN1RLpwxxc7tEydk=;
        b=dEJqFXxd0gmGLg5uzmXHncnFINCLntlIod2cTM4/DcpSnu2WNZhMRQ0zy4D0zWmcmH
         +Nsds4bwKXAO6Th5fKKtKejj2jH5u2W/SDR8Jir3a2YPWbIoAS1isEBBER0+WG9UgTtM
         nHI08JnuZgF3HPKsj8j8kuQJ5SGLfDbOGUCdXRZTV31bTHQ9HHPW89I9FecHjH+hqw5H
         bjQJq70T6YZi23DRnPAmYb9y8gfgg8NCaYIj8miNzX4DwaDSQrHDv2WaFagKU6hev8EH
         jJ5QeyT+jkgObX5dUR/fP7k8e6FuEQrkMfB2+E1uZxGh2/v4XQmn/PwUqu5UBqKnvdLl
         c6Qw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bmoRQj0m;
       dkim=pass header.i=@jms.id.au header.s=google header.b=OSiQOki2;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bmoRQj0m;
       dkim=pass header.i=@jms.id.au header.s=google header.b=OSiQOki2;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AIpwx4/W6HosTJLpgajgov4mosY8NK7oZ+9TfAI+BLxUlxvc2rWUAvg8E5rgTJQwCy96nxxN9Q4nnbl74zsYAq6rK0U=
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180410183212.16787-2-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com> <20180410183212.16787-2-jae.hyun.yoo@linux.intel.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Apr 2018 21:22:00 +0930
X-Google-Sender-Auth: DmTtIusvZxLPm4AV0-klbDdTn2s
Message-ID: <CACPK8XfwVTKfOQSteY8-Dy2=YiC6qjd1qZ2f8n1hTv8w06DWRg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] Documentations: dt-bindings: Add documents of
 generic PECI bus, adapter and client drivers
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Rob Herring <robh+dt@kernel.org>
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
X-GMAIL-THRID: =?utf-8?q?1597385124256903080?=
X-GMAIL-MSGID: =?utf-8?q?1597450528879464245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jae,

On 11 April 2018 at 04:02, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> This commit adds documents of generic PECI bus, adapter and client drivers.
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

That's a hefty cc list. I can't see Rob Herring though, and he's
usually the person who you need to convince to get your bindings
accepted.

I recommend using ./scripts/get_maintainers.pl to build your CC list,
and then add others you think are relevant.

I'm not sure what the guidelines are for generic bindings, so I'll
defer to Rob for this patch.

Cheers,

Joel

> ---
>  .../devicetree/bindings/peci/peci-adapter.txt      | 23 ++++++++++++++++++++
>  .../devicetree/bindings/peci/peci-bus.txt          | 15 +++++++++++++
>  .../devicetree/bindings/peci/peci-client.txt       | 25 ++++++++++++++++++++++
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
> +                  match an adapter driver implementation.
> +- reg            : Should contain PECI controller registers location and length.
> +- #address-cells : Should be <1>.
> +- #size-cells    : Should be <0>.
> +
> +Example:
> +       peci: peci@10000000 {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0x0 0x10000000 0x1000>;
> +
> +               peci0: peci-bus@0 {
> +                       compatible = "soc,soc-peci";
> +                       reg = <0x0 0x1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +       };
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
> +- #address-cells : Should be <1>.
> +- #size-cells    : Should be <1>.
> +- ranges         : Should contain PECI controller registers ranges.
> +
> +Example:
> +       peci: peci@10000000 {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0x0 0x10000000 0x1000>;
> +       };
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
> +              match a client driver implementation.
> +- reg        : Should contain address of a client CPU. Address range of CPU
> +              clients is starting from 0x30 based on PECI specification.
> +              <0x30> .. <0x37> (depends on the PECI_OFFSET_MAX definition)
> +
> +Example:
> +       peci-bus@0 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               < more properties >
> +
> +               function@cpu0 {
> +                       compatible = "device,function";
> +                       reg = <0x30>;
> +               };
> +
> +               function@cpu1 {
> +                       compatible = "device,function";
> +                       reg = <0x31>;
> +               };
> +       };
> --
> 2.16.2
>
