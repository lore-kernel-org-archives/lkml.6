Return-Path: <heiko@sntech.de>
X-Google-Smtp-Source: AH8x225NZdK3VCtklk4MLNKWipBwZQebWZtC8JZBbntlwOckJCYf+ruwSKS7NA/vxmdOOcDWlHvU
ARC-Seal: i=1; a=rsa-sha256; t=1518615591; cv=none;
        d=google.com; s=arc-20160816;
        b=yct2rOqXI3qZ466cmsnzT95zHa5nEYkSn8D1MY+ia1fA2dIH8QRmBRN6w3Ox/+mzSv
         v2Xcui0WzOfkzKVvOmjhKH9HEmyIqpTp0ZdD9Y4qImU+HirKzzS79ois5kE0pxwXsM7F
         FaTlx8UhYg4fe30GoCNFg7oLzrgC8M4vGSXnuJY7dvzy9WrCQODGMDH8H1kzpdTwCMpU
         ZshrpxCybH8Kjcp3Tvp13W0NRpIxuHWvU2YXJLsgn428WfrXd68mm7aQx3fR17TBUGw+
         qsquyqre81piA5EbraIk/SGxjARG2wCF7W8Om9zES49i0fGaEwWQRDhDDkO2O6wwBauO
         uzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=a75ojVT6Nj8Te8ll1s0AVTqbWkR4m39H6uC69W6vC+c=;
        b=SKAtcuM4+TH/pph7K5nL98hi/tgRWDfaHYIcKt10LH4Eqzw50490+Sm9+LBP75UdbT
         HduM3tGbYGviL9HofX2mFQJ9Oxx4ISEMgiWLmItbFdPEAqYoEmvQpaGtp8srA3xaqJOf
         J+KfX0fhkhwP2HX+IsoS/dzMlaQB1qnHHsIcjIlVzcM/SC5z049BfzCu8M8bcIdxBlHM
         P4E153qMYngib/NfXVxbEa/vabcTWVGgNCJx/iONoVg58YdJ/GaRbaSA8TpB0f8cWnYd
         Hk2QWYRB2U8Hy2g3X2yLXdHLX8qKnXZh7xK1Y3RDND3W9MQtSuPD7i5Lj35BgFZeFIi3
         mTQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heiko@sntech.de designates 95.129.55.99 as permitted sender) smtp.mailfrom=heiko@sntech.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heiko@sntech.de designates 95.129.55.99 as permitted sender) smtp.mailfrom=heiko@sntech.de
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, dtor@google.com, dianders@google.com, Arnd Bergmann <arnd@arndb.de>, Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Emil Renner Berthing <kernel@esmil.dk>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, linux-rockchip@lists.infradead.org, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/3] gpio-keys: Add support for specifying wakeup event action
Date: Wed, 14 Feb 2018 14:39:35 +0100
Message-ID: <1541427.8RRpDbxO4f@diego>
In-Reply-To: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592012039137400382?=
X-GMAIL-MSGID: =?utf-8?q?1592383862163767717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jeffy,

Am Samstag, 10. Februar 2018, 12:09:04 CET schrieb Jeffy Chen:
> On chromebook kevin, we are using gpio-keys for pen insert event. But
> we only want it to wakeup the system when ejecting the pen.
> 
> So we may need to change the interrupt trigger type during suspending.
> 
> Changes in v2:
> Specify wakeup event action instead of irq trigger type as Brian
> suggested.
> 
> Jeffy Chen (3):
>   Input: gpio-keys - add support for wakeup event action
>   Input: gpio-keys - allow setting wakeup event action in DT
>   arm64: dts: rockchip: Avoid wakeup when inserting the pen

The recipient-selection for the mail thread seems to be a bit off and
I only got the cover-letter and patch 3/3.
Therefore I won't really see if and when the Input-changes get
accepted. So please ping me once that has happened so I can pick up
the rockchip dts change for it.


Thanks
Heiko
