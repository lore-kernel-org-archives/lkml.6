Return-Path: <thomas.petazzoni@bootlin.com>
X-Google-Smtp-Source: AIpwx48V6gCCg2KvZMxLMUowC5k1Jol7vfFfqX3OIsEkV2YSJsWyu5khys+lDYcxKhex0LPxc6UA
ARC-Seal: i=1; a=rsa-sha256; t=1521803447; cv=none;
        d=google.com; s=arc-20160816;
        b=NKQGMQP0V8mobLmPGTDTf42mYLlKIjd1ZVeLPufD/YVFlAWK+s9g4WwvYRk9k8F5on
         EkQR6gBsJYFFWda3BqFLpBf8ZIp/Wob+bLRmTbv3z7ff1hlIOYcop5s72+hOMQlY6pbV
         pZgmB8mCum3pD4lAFtDG8bd0wlzOZN5auifiXqfLBMUCDJcIDDSkLgkC0rAlViT34pXq
         Jl/fMDwQ5aAH5KzXXcX9xC3pBii4++8OxZuMJiPQ46v7EZDjKWmBmFmiU6uo0tNtpLJG
         w5sejnJWfam9Og3FH/mju0nA1WZKqlEsGA5v+3Y0AYUcPDf0dNvd92c1+a88oHnpZ2ue
         ovIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=llwPVb6nnVlojyW0C4ZFVy7kQuhtrDC/l9Uizel2HiU=;
        b=H+iCiu4hwY4c0F9Zg8zUgq9dlcJyqJU6zc2/I4tAJiltFHsQtkM4GIkG3tlbPeONCl
         Ts4sg7RqEckCeRqsP2A7U11bMtsmokzHM340SSBGdCCcph3u0HzRGBcezFrcAYs7AeDJ
         2XrJWyiUUntjGkCLIWgWyd4/IdWEOlgeQ8q92BaQYd9aaTK57NqH7SUXpQbumoB0qFZQ
         xtOk/MCv+qiqkDJz1IdmwDVXtxoqORHjXg4bR03YNjvIEKPjJNBD18MRJQlimym0YOC7
         dV0rfFLCVcVjjEOeG/rc3B/YbY82RzK4xB8Jrkb4zBRKJcFbtmYyrhuwz0+UwDKj7RAy
         GnvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of thomas.petazzoni@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=thomas.petazzoni@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of thomas.petazzoni@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=thomas.petazzoni@bootlin.com
Date: Fri, 23 Mar 2018 12:10:35 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw
 Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan
 Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian
 Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>,
 Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose
 <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas
 Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon
 <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll
 <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor Soares
 <Vitor.Soares@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Linus Walleij <linus.walleij@linaro.org>, Xiang Lin
 <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org, Boris Brezillon
 <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 09/11] dt-bindings: i3c: Document Cadence I3C master
 bindings
Message-ID: <20180323121035.7dc27356@windsurf>
In-Reply-To: <20180323110020.19080-10-boris.brezillon@bootlin.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
	<20180323110020.19080-10-boris.brezillon@bootlin.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725934834963345?=
X-GMAIL-MSGID: =?utf-8?q?1595726572026131529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Fri, 23 Mar 2018 12:00:18 +0100, Boris Brezillon wrote:

> +Optional properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- i2c-scl-frequency
> +- i3c-scl-frequency

These properties are now named *-scl-hz.

> +Example:
> +
> +	i3c-master@0d040000 {
> +		compatible = "cdns,i3c-master";
> +		clocks = <&coreclock>, <&i3csysclock>;
> +		clock-names = "pclk", "sysclk";
> +		interrupts = <3 0>;
> +		reg = <0x0d040000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-scl-frequency = <100000>;

Ditto.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
