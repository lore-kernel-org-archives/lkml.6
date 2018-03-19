Return-Path: <groeck7@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476947-2-2018682321112344963
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25,
  FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.68', Host='mail-pl0-f68.google.com', Country='US',
  FromHeader='net', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: groeck7@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521476946; b=V/nvwHuUk4W322TFA375PHC64D5zpSbAa41qYWn/4leUl1S
    BrM2gnLHC62NvfHllIbWKUqylgYfvCIdwTnhA3CSxX7mha4MPxTheKiGvpPGA/ty
    yceLOvC7ys5L6JtG/otv92R4M5kYB+9JylFPNF/Ojc3oIusmU6895yhLNKVLLAsB
    inxRVBMDhdLO1tdKfYdWgMenVZ/VG+ZNCSTl/ImMTSnF0RhaH08Q4Fbk3ZaAiSuB
    s9b7tjuYE3JmS2qW2gfV9XflRqZfQHvrW9MVfi9NJyLKXZrEBNK8NViXurh6Gp9f
    vdwkptLUFFYx+Zt6v3fevysY9LNvDDFNfbHO9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521476946; bh=0Mb+Ot6g1aztEL22hAsYGR75kqGGAKZo142kyoEgNZM=; b=m
    Md5goAdEuL9T8pgO3nZTdiqRYExJ5JpsBRAK1oiuOXWJu+8fF6EysaZ0NJATZj9g
    XbeyUzI4PxlZ+7jJeKxk6czHaUYSoevk+t8Ixt1Ri8lIuFIxtxtnHS++1s+psTSd
    WRZS4D0mTAC/Rh8AOexMElUgfVrhU9hfSDyW4sPWNG2SCOOfngNfvDgdoFI1YCdN
    sf3aajYewXSxKLwNCLDApy15ZfIOv1JAnZhc7MTkf5Azps3QyzC2MEUuyW4KOqZ0
    M9snph2uAZJcQ0sD0nN5MXh3lf19U61DHfbzGv4rn1qcb7zNIJk6NtFypvO9PzXJ
    rMXZ9EDTczTiDpVaO7TZQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eWX/OaNq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=groeck7@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpehsfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhuvghnthgvrhcutfhovggtkhcuoehlihhnuhigsehrohgvtghkqdhushdrnhgvtheqnecukfhppedvtdelrdekhedrudeitddrieekpddutdekrddvvdefrdegtddrieeinecurfgrrhgrmhepihhnvghtpedvtdelrdekhedrudeitddrieekpdhhvghlohepmhgrihhlqdhplhdtqdhfieekrdhgohhoghhlvgdrtghomhdpmhgrihhlfhhrohhmpeeoghhrohgvtghkjeesghhmrghilhdrtghomhequcfukfgkgfephedtledunecuvehluhhsthgvrhfuihiivgeptd;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=P/hE1E9H;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eWX/OaNq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.85.160.68 (mail-pl0-f68.google.com);
    spf=pass smtp.mailfrom=groeck7@gmail.com smtp.helo=mail-pl0-f68.google.com;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpehsfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhuvghnthgvrhcutfhovggtkhcuoehlihhnuhigsehrohgvtghkqdhushdrnhgvtheqnecukfhppedvtdelrdekhedrudeitddrieekpddutdekrddvvdefrdegtddrieeinecurfgrrhgrmhepihhnvghtpedvtdelrdekhedrudeitddrieekpdhhvghlohepmhgrihhlqdhplhdtqdhfieekrdhgohhoghhlvgdrtghomhdpmhgrihhlfhhrohhmpeeoghhrohgvtghkjeesghhmrghilhdrtghomhequcfukfgkgfephedtledunecuvehluhhsthgvrhfuihiivgeptd;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=P/hE1E9H;
    x-ptr=pass x-ptr-helo=mail-pl0-f68.google.com x-ptr-lookup=mail-pl0-f68.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELtbNXAjEv2oH/M4mGNEwL4/HJ86ZGLqFge8SWXutEGGpBHkvXnN0tcZXiV+de23MbTUkRb5QA==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Mar 2018 09:29:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: ShuFan Lee <leechu729@gmail.com>
Cc: greg@kroah.com, heikki.krogerus@linux.intel.com, shufan_lee@richtek.com,
	cy_huang@richtek.com, jun.li@nxp.com, mats.dev.list@gmail.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: usb: rt1711h device tree binding
 document
Message-ID: <20180319162903.GB17189@roeck-us.net>
References: <1521431375-23207-1-git-send-email-leechu729@gmail.com>
 <1521431375-23207-3-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521431375-23207-3-git-send-email-leechu729@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 11:49:35AM +0800, ShuFan Lee wrote:
> From: ShuFan Lee <shufan_lee@richtek.com>
> 
> Add device tree binding document for Richtek RT1711H Type-C chip driver

Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
is missing. Added here but it might make sense to resend.

>
> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
> ---
>  .../devicetree/bindings/usb/richtek,rt1711h.txt    | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
> 
>  changelogs between v2 & v3
>  - add dt-bindings document for rt1711h typec chip driver
> 
> diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
> new file mode 100644
> index 000000000000..7da4dac78ea7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
> @@ -0,0 +1,30 @@
> +Richtek RT1711H TypeC PD Controller.
> +
> +Required properties:
> + - compatible : Must be "richtek,rt1711h".
> + - reg : Must be 0x4e, it's slave address of RT1711H.
> +
> +Recommended properties :
> + - interrupt-parent : the phandle for the interrupt controller that
> +   provides interrupts for this device.
> + - interrupts : <a b> where a is the interrupt number and b represents an
> +   encoding of the sense and level information for the interrupt.
> +
> +Optional properties :
> + - rt,intr-gpios : IRQ GPIO pin that's connected to RT1711H interrupt.
> +   if interrupt-parent & interrupts are not defined, use this property instead.
> +
> +Example :
> +rt1711h@4e {
> +	compatible = "richtek,rt1711h";
> +	reg = <0x4e>;
> +	interrupt-parent = <&gpio26>;
> +	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +};
> +
> +Example using rt,intr-gpios :
> +rt1711h@4e {
> +	compatible = "richtek,rt1711h";
> +	reg = <0x4e>;
> +	rt,intr-gpios = <&gpio26 0 0x0>;
> +};
> -- 
> 1.9.1
> 
