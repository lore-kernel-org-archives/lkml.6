Return-Path: <riproute@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525293573; cv=none;
        d=google.com; s=arc-20160816;
        b=hkbTyy9qr1x9MAUhqrpEGCn4SJrUfvEweoeIWR5sG0AFkw4q1FwpVVL493JgNpqX3p
         Rbj8En7+mABbfD3AQIs10cfYnU3Z8CZ7mEkM44CfFevTZ4a2uNO6eSgOd4EzYpohu13Q
         dCD2BQs9rpe+3zEmFo17c+xe/EkHB98VWh6LIPjiQgoNKh20LSjr2A14hbBNc6e5Ii/p
         JHRRicoFqD/wS25NiFZ0nLPbAu9LSReAlyxDqWUdAzUi+Wci/lYG99d4LuZv4rPsneQ7
         5SI1VVDYtOxzDAgn8RK7/3W/qwwbTj22Sh3A9fToi8TGNo3Iy3XxOGqlhCf6v5Z6oeza
         reeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=zEey9fOJxznyyN3RxGXtbQoCWa75t3ZlHz9ucTsLHpw=;
        b=XxEPAb8XuzBRmsJY0i9EMEAOktgrZUiQ+8ZF6WiJBGLqzre2S0qRh5WzMRHDwgxScu
         HKjLtyloctcEYoLanOBAd7PM5P1TGfkITFzyvo9w1otbI/tG5hlaZkiPplRroXZLjF//
         /zXmfW0fHeWKAN1uiYib0RVnadjMd0ob30J9dwO7/0zpTWleyhR9ooaDMaVQ+t1o2bD8
         qAz7TqGzEw+0pc0HP35NOshk1nI7UqcQ1Xr5zM5+vRfEaEonIs/gnVF4jPmE59NlLOtZ
         P8qT/Fts807nywChcroPjzVJPI3VNrx7dqfL6tFLUHyDmmJzryAy5mBbT+6JeqoLVr4J
         mPBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=i4tKjErg;
       spf=pass (google.com: domain of riproute@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=riproute@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=i4tKjErg;
       spf=pass (google.com: domain of riproute@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=riproute@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrkJwAcmfpUlBPzQqJ4QedlOUfj6phxu6uuVd1RZPLo/ztVBD8b69c7CpRF+WicMUHiVw+MN/mtYZIQLAr6Yn0=
MIME-Version: 1.0
In-Reply-To: <4293e8bf-59f1-4085-a287-7ee0989d4e05@hauke-m.de>
References: <20180502141102.31769-1-zajec5@gmail.com> <4293e8bf-59f1-4085-a287-7ee0989d4e05@hauke-m.de>
From: Rip Route <riproute@gmail.com>
Date: Wed, 2 May 2018 14:39:32 -0600
Message-ID: <CALZrXOnPowtX_ghKwzS79jw=rXJtDMGGZjENOTktJ4nJkmvYwg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: BCM5301X: Relicense most DTS files to the GPL
 2.0+ / MIT
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, Dan Haab <dhaab@luxul.com>,
	Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: multipart/alternative; boundary="0000000000009904f1056b3f15c7"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599361889970961407?=
X-GMAIL-MSGID: =?utf-8?q?1599386234431804124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--0000000000009904f1056b3f15c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 On 05/02/2018 04:11 PM, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> These files were created and ever touched by a group of three people
> only: Dan, Hauke and me. They were licensed under GNU/GPL or ISC.
>
> Introducing and discussing SPDX-License-Identifier resulted in a
> conclusion that ISC is a not recommended license (see also a
> license-rules.rst). Moveover an old e-mail from Alan Cox was pointed
> which explained that dual licensing is a safer solution than depending
> on a common compatibility belief.
>
> This commit switches most of BCM5301X DTS files to dual licensing using:
> 1) GPL 2.0+ to make sure they are compatible with Linux kernel
> 2) MIT to allow sharing with more permissive projects Both licenses
> belong to the preferred ones (see LICENSES/preferred/).
>
> An attempt to relicense remaining files will be made separately and
> will require approve from more/other developers.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Acked-by: Dan Haab <dan.haab@luxul.com>
re-sent without footer

> ---
>  arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        | 13 +------------
>  arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        | 13 +------------
>  arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts    |  3 +--
>  arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       |  3 +--
>  arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |  3 +--
>  arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     | 13 +------------
>  arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |  3 +--
>  arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        | 13 +------------
>  arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 13 +------------
>  arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts      |  3 +--
>  arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts      |  3 +--
>  arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts |  3 +--
>  arch/arm/boot/dts/bcm4709-linksys-ea9200.dts       |  3 +--
>  arch/arm/boot/dts/bcm4709-netgear-r7000.dts        | 13 +------------
>  arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  |  3 +--
>  arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      | 13 +------------
>  arch/arm/boot/dts/bcm47094-linksys-panamera.dts    |  3 +--
>  arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts      |  3 +--
>  arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts      |  3 +--
>  arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |  3 +--
>  arch/arm/boot/dts/bcm47094-netgear-r8500.dts       |  3 +--
>  arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi      |  3 +--
>  arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi      |  3 +--
>  arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi      |  3 +--
>  arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi           |  3 +--
>  25 files changed, 25 insertions(+), 120 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
> b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
> index 4175174e589a..ff2e551b9058 100644
> --- a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
> +++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
> @@ -1,20 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Broadcom BCM470X / BCM5301X ARM platform code.
>   * DTS for Asus RT-AC56U
>   *
>   * Copyright (C) 2015 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> - *
> - * Permission to use, copy, modify, and/or distribute this software
> for any
> - * purpose with or without fee is hereby granted, provided that the
> above
> - * copyright notice and this permission notice appear in all copies.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
> WARRANTIES WITH
> - * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> MERCHANTABILITY
> - * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
> SPECIAL, DIRECT,
> - * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
> RESULTING FROM
> - * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
> NEGLIGENCE
> - * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
> USE OR
> - * PERFORMANCE OF THIS SOFTWARE.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> index 8fa033fea959..3bcc03788f38 100644
> --- a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> +++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> @@ -1,20 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Broadcom BCM470X / BCM5301X ARM platform code.
>   * DTS for Asus RT-AC68U
>   *
>   * Copyright (C) 2015 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> - *
> - * Permission to use, copy, modify, and/or distribute this software
> for any
> - * purpose with or without fee is hereby granted, provided that the
> above
> - * copyright notice and this permission notice appear in all copies.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
> WARRANTIES WITH
> - * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> MERCHANTABILITY
> - * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
> SPECIAL, DIRECT,
> - * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
> RESULTING FROM
> - * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
> NEGLIGENCE
> - * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
> USE OR
> - * PERFORMANCE OF THIS SOFTWARE.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
> b/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
> index 126ab5867772..6c8f0ad82332 100644
> --- a/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
> +++ b/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (C) 2017 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> - *
> - * Licensed under the ISC license.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
> b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
> index f591b0f256d8..ebda45fe9ea4 100644
> --- a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
> +++ b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright 2016 Luxul Inc.
> - *
> - * Licensed under the ISC license.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
> b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
> index 5efb6f31164d..9dd0e22c906a 100644
> --- a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
> +++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
> @@ -1,10 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Broadcom BCM470X / BCM5301X ARM platform code.
>   * DTS for Luxul XWC-1000
>   *
>   * Copyright 2014 Luxul Inc.
> - *
> - * Licensed under the GNU/GPL. See COPYING for details.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
> b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
> index bb66cebe0bd8..2642494c97a1 100644
> --- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
> +++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
> @@ -1,20 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Broadcom BCM470X / BCM5301X ARM platform code.
>   * DTS for Netgear R6300 V2
>   *
>   * Copyright (C) 2014 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> - *
> - * Permission to use, copy, modify, and/or distribute this software
> for any
> - * purpose with or without fee is hereby granted, provided that the
> above
> - * copyright notice and this permission notice appear in all copies.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
> WARRANTIES WITH
> - * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> MERCHANTABILITY
> - * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
> SPECIAL, DIRECT,
> - * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
> RESULTING FROM
> - * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
> NEGLIGENCE
> - * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
> USE OR
> - * PERFORMANCE OF THIS SOFTWARE.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> index 83a4c60bb431..e7b09b7b7d25 100644
> --- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> +++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> @@ -1,10 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Broadcom BCM470X / BCM5301X arm platform code.
>   * DTS for SmartRG SR400ac
>   *
>   * Copyright (C) 2015 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> - *
> - * Licensed under the GNU/GPL. See COPYING for details.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
> b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
> index 0800a964f2fe..16314fcc6e56 100644
> --- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
> +++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
> @@ -1,20 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Broadcom BCM470X / BCM5301X ARM platform code.
>   * DTS for Asus RT-N18U
>   *
>   * Copyright (C) 2014 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> - *
> - * Permission to use, copy, modify, and/or distribute this software
> for any
> - * purpose with or without fee is hereby granted, provided that the
> above
> - * copyright notice and this permission notice appear in all copies.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
> WARRANTIES WITH
> - * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> MERCHANTABILITY
> - * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
> SPECIAL, DIRECT,
> - * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
> RESULTING FROM
> - * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
> NEGLIGENCE
> - * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
> USE OR
> - * PERFORMANCE OF THIS SOFTWARE.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
> b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
> index c2af33eb47de..328aa90240ce 100644
> --- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
> +++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
> @@ -1,20 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Broadcom BCM470X / BCM5301X ARM platform code.
>   * DTS for Buffalo WZR-600DHP2
>   *
>   * Copyright (C) 2014 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> - *
> - * Permission to use, copy, modify, and/or distribute this software
> for any
> - * purpose with or without fee is hereby granted, provided that the
> above
> - * copyright notice and this permission notice appear in all copies.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
> WARRANTIES WITH
> - * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> MERCHANTABILITY
> - * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
> SPECIAL, DIRECT,
> - * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
> RESULTING FROM
> - * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
> NEGLIGENCE
> - * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
> USE OR
> - * PERFORMANCE OF THIS SOFTWARE.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
> b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
> index 9b5759849983..5eeac7302329 100644
> --- a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
> +++ b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright 2017 Luxul Inc.
> - *
> - * Licensed under the ISC license.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
> b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
> index ba1c19b1b3eb..da4d9ec62fc6 100644
> --- a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
> +++ b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright 2017 Luxul Inc.
> - *
> - * Licensed under the ISC license.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
> b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
> index 3ed8de42cb48..c94c732188fb 100644
> --- a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
> +++ b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (C) 2017 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> - *
> - * Licensed under the ISC license.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
> b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
> index 3d1d9c2c4efc..db744a5e122d 100644
> --- a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
> +++ b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (C) 2017 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> - *
> - * Licensed under the ISC license.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> index f43ab4721456..9e267d38df4c 100644
> --- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> +++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> @@ -1,20 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Broadcom BCM470X / BCM5301X ARM platform code.
>   * DTS for Netgear R7000
>   *
>   * Copyright (C) 2015 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> - *
> - * Permission to use, copy, modify, and/or distribute this software
> for any
> - * purpose with or without fee is hereby granted, provided that the
> above
> - * copyright notice and this permission notice appear in all copies.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
> WARRANTIES WITH
> - * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> MERCHANTABILITY
> - * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
> SPECIAL, DIRECT,
> - * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
> RESULTING FROM
> - * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
> NEGLIGENCE
> - * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
> USE OR
> - * PERFORMANCE OF THIS SOFTWARE.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
> b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
> index ec4a50e440f6..f5bf6586ae07 100644
> --- a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
> +++ b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (C) 2016 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> - *
> - * Licensed under the ISC license.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
> b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
> index 7cc7d344fe5b..494dbd39658c 100644
> --- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
> +++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
> @@ -1,20 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Broadcom BCM470X / BCM5301X ARM platform code.
>   * DTS for D-Link DIR-885L
>   *
>   * Copyright (C) 2016 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> - *
> - * Permission to use, copy, modify, and/or distribute this software
> for any
> - * purpose with or without fee is hereby granted, provided that the
> above
> - * copyright notice and this permission notice appear in all copies.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
> WARRANTIES WITH
> - * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> MERCHANTABILITY
> - * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
> SPECIAL, DIRECT,
> - * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
> RESULTING FROM
> - * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
> NEGLIGENCE
> - * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
> USE OR
> - * PERFORMANCE OF THIS SOFTWARE.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> index b6750f70dffb..f47afe36d857 100644
> --- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> +++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (C) 2017 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> - *
> - * Licensed under the ISC license.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
> b/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
> index ecd22a246746..a5cef51cfe4f 100644
> --- a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
> +++ b/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (C) 2017 Luxul Inc.
> - *
> - * Licensed under the ISC license.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
> b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
> index 15ffb1abc440..7496aabf8f77 100644
> --- a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
> +++ b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (C) 2017 Luxul Inc.
> - *
> - * Licensed under the ISC license.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
> b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
> index bc1d1e10d4ac..53aaa5212610 100644
> --- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
> +++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright 2016 Luxul Inc.
> - *
> - * Licensed under the ISC license.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
> b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
> index 859929973158..0e718edc065a 100644
> --- a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
> +++ b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (C) 2016 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> - *
> - * Licensed under the ISC license.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi
> b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi
> index 24b099c00f13..c349e8f0afc5 100644
> --- a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Broadcom Northstar NAND.
>   *
>   * Copyright (C) 2016 Rafa=C5=82 Mi=C5=82ecki <rafal.milecki@gmail.com>
> - *
> - * Licensed under the ISC license.
>   */
>
>  #include "bcm5301x-nand-cs0.dtsi"
> diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi
> b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi
> index b4e875df9528..18e25e302b13 100644
> --- a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright 2016 Luxul Inc.
> - *
> - * Licensed under the ISC license.
>   */
>
>  #include "bcm5301x-nand-cs0.dtsi"
> diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
> b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
> index 9a9630ded306..c8e56d30bd6f 100644
> --- a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Broadcom BCM470X / BCM5301X Nand chip defaults.
>   *
> @@ -5,8 +6,6 @@
>   * and uses 8 bit ECC.
>   *
>   * Copyright (C) 2015 Hauke Mehrtens <hauke@hauke-m.de>
> - *
> - * Licensed under the GNU/GPL. See COPYING for details.
>   */
>
>  #include "bcm5301x-nand-cs0.dtsi"
> diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
> b/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
> index 168495106b82..e5a2d62daf92 100644
> --- a/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Broadcom Northstar NAND.
>   *
>   * Copyright (C) 2015 Hauke Mehrtens <hauke@hauke-m.de>
> - *
> - * Licensed under the GNU/GPL. See COPYING for details.
>   */
>
>  / {
>

--0000000000009904f1056b3f15c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">

<div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial">On 05/02/2018 04:11 PM, Rafa=C5=82 Mi=C5=82ecki wrote:=
</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:a=
rial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;white-space:normal;word-spaci=
ng:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial">&gt; From: Rafa=C5=82 Mi=C5=82ecki &lt;<a href=
=3D"mailto:rafal@milecki.pl">rafal@milecki.pl</a>&gt;</div><div class=3D"gm=
ail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-s=
ize:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps=
:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:=
0px;text-transform:none;white-space:normal;word-spacing:0px;background-colo=
r:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:init=
ial">&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt; These files were created and ever =
touched by a group of three people</div><div class=3D"gmail_extra" style=3D=
"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-styl=
e:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial">&gt; only: Dan=
, Hauke and me. They were licensed under GNU/GPL or ISC.</div><div class=3D=
"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;fon=
t-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;white-space:normal;word-spacing:0px;background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial">&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">&gt; Introducing and discussing SPDX=
-License-Identifier resulted in a</div><div class=3D"gmail_extra" style=3D"=
color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial">&gt; conclusion=
 that ISC is a not recommended license (see also a</div><div class=3D"gmail=
_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
">&gt; license-rules.rst). Moveover an old e-mail from Alan Cox was pointed=
</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:a=
rial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;white-space:normal;word-spaci=
ng:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial">&gt; which explained that dual licensing is a sa=
fer solution than depending</div><div class=3D"gmail_extra" style=3D"color:=
rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-de=
coration-style:initial;text-decoration-color:initial">&gt; on a common comp=
atibility belief.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,=
34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial">&gt;</div><div class=3D"gmail_e=
xtra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial">=
&gt; This commit switches most of BCM5301X DTS files to dual licensing usin=
g:</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family=
:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:=
normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial">&gt; 1) GPL 2.0+ to make sure they are compati=
ble with Linux kernel</div><div class=3D"gmail_extra" style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial">&gt; 2) MIT to allow sharin=
g with more permissive projects Both licenses</div><div class=3D"gmail_extr=
a" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:smal=
l;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;=
font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text=
-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(25=
5,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt=
; belong to the preferred ones (see LICENSES/preferred/).</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial">&gt; An attempt to relicense rema=
ining files will be made separately and</div><div class=3D"gmail_extra" sty=
le=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial">&gt; will=
 require approve from more/other developers.</div><div class=3D"gmail_extra=
" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:a=
rial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;white-space:normal;word-spaci=
ng:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial">&gt; Signed-off-by: Rafa=C5=82 Mi=C5=82ecki &lt;=
<a href=3D"mailto:rafal@milecki.pl">rafal@milecki.pl</a>&gt;</div><div clas=
s=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif=
;font-size:small;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial"><br></div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,3=
4);font-family:arial,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial">Acked-by: Dan Haab &lt;<a href=
=3D"mailto:dan.haab@luxul.com">dan.haab@luxul.com</a>&gt;</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">re-sent without footer</div><div class=3D"gmail_extra" style=3D"=
color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial"><br></div><div =
class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-s=
erif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial">&gt; ---</div><div class=3D"gmail_extra" style=3D"color:rgb=
(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial">&gt;=C2=A0 arch/arm/boot=
/dts/bcm4708-asus-rt-ac56u.dts=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 13 +-----------=
-</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:=
arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial">&gt;=C2=A0 arch/arm/boot/dts/bcm4708-asus-rt-ac=
68u.dts=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 13 +------------</div><div class=3D"gm=
ail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-s=
ize:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps=
:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:=
0px;text-transform:none;white-space:normal;word-spacing:0px;background-colo=
r:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:init=
ial">&gt;=C2=A0 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts=C2=A0 =C2=
=A0 |=C2=A0 3 +--</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,=
34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial">&gt;=C2=A0 arch/arm/boot/dts/bc=
m4708-luxul-xap-1510.dts=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +--</div><div =
class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-s=
erif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial">&gt;=C2=A0 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts=C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +--</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =
arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts=C2=A0 =C2=A0 =C2=A0| 13 +---=
---------</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt;=C2=A0 arch/arm/boot/dts/bcm4708-sm=
artrg-sr400ac.dts=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +--</div><div class=3D"gmai=
l_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-siz=
e:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;background-color:=
rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initia=
l">&gt;=C2=A0 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 13 +------------</div><div class=3D"gmail_extra" style=3D"colo=
r:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 arch/arm=
/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 13 +------------</div><div cla=
ss=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-seri=
f;font-size:small;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial">&gt;=C2=A0 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts=C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 3 +--</div><div class=3D"gmail_extra" style=3D"color=
:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 arch/arm/=
boot/dts/bcm47081-luxul-xwr-1200.dts=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +--</div=
><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial">&gt;=C2=A0 arch/arm/boot/dts/bcm47081-tplink-archer-c=
5-v2.dts |=C2=A0 3 +--</div><div class=3D"gmail_extra" style=3D"color:rgb(3=
4,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial">&gt;=C2=A0 arch/arm/boot/d=
ts/bcm4709-linksys-ea9200.dts=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +--</div>=
<div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial">&gt;=C2=A0 arch/arm/boot/dts/bcm4709-netgear-r7000.dts=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 13 +------------</div><div class=3D"gmail_ext=
ra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sma=
ll;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal=
;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(2=
55,255,255);text-decoration-style:initial;text-decoration-color:initial">&g=
t;=C2=A0 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts=C2=A0 |=C2=A0 3 =
+--</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-famil=
y:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial">&gt;=C2=A0 arch/arm/boot/dts/bcm47094-dlink-d=
ir-885l.dts=C2=A0 =C2=A0 =C2=A0 | 13 +------------</div><div class=3D"gmail=
_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
">&gt;=C2=A0 arch/arm/boot/dts/bcm47094-linksys-panamera.dts=C2=A0 =C2=A0 |=
=C2=A0 3 +--</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">&gt;=C2=A0 arch/arm/boot/dts/bcm4709=
4-luxul-abr-4500.dts=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +--</div><div class=3D"g=
mail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial">&gt;=C2=A0 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts=C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 3 +--</div><div class=3D"gmail_extra" style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial">&gt;=C2=A0 arch/arm/boot/dt=
s/bcm47094-luxul-xwr-3100.dts=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +--</div><div c=
lass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">&gt;=C2=A0 arch/arm/boot/dts/bcm47094-netgear-r8500.dts=C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +--</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =
arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3=
 +--</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fami=
ly:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial">&gt;=C2=A0 arch/arm/boot/dts/bcm5301x-nand-c=
s0-bch4.dtsi=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +--</div><div class=3D"gmail_ext=
ra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sma=
ll;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal=
;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(2=
55,255,255);text-decoration-style:initial;text-decoration-color:initial">&g=
t;=C2=A0 arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi=C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 3 +--</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);=
font-family:arial,sans-serif;font-size:small;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial">&gt;=C2=A0 arch/arm/boot/dts/bcm530=
1x-nand-cs0.dtsi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +--</div=
><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial">&gt;=C2=A0 25 files changed, 25 insertions(+), 120 de=
letions(-)</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fon=
t-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial">&gt;</div><div class=3D"gmail_extra" s=
tyle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial">&gt; di=
ff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts</div><div class=3D"g=
mail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial">&gt; b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts</div><div class=3D=
"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;fon=
t-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;white-space:normal;word-spacing:0px;background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial">&gt; index 4175174e589a..ff2e551b9058 100644</div><div class=3D"gma=
il_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-si=
ze:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;white-space:normal;word-spacing:0px;background-color=
:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initi=
al">&gt; --- a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt; +++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts</div><div=
 class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-=
serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial">&gt; @@ -1,20 +1,9 @@</div><div class=3D"gmail_extra" styl=
e=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial">&gt; +// S=
PDX-License-Identifier: GPL-2.0-or-later OR MIT</div><div class=3D"gmail_ex=
tra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial">&=
gt;=C2=A0 /*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Broadcom BCM470X =
/ BCM5301X ARM platform code.</div><div class=3D"gmail_extra" style=3D"colo=
r:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* =
DTS for Asus RT-AC56U</div><div class=3D"gmail_extra" style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0*</div><di=
v class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans=
-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial">&gt;=C2=A0 =C2=A0* Copyright (C) 2015 Rafa=C5=82 Mi=C5=82=
ecki &lt;<a href=3D"mailto:zajec5@gmail.com">zajec5@gmail.com</a>&gt;</div>=
<div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial">&gt; - *</div><div class=3D"gmail_extra" style=3D"colo=
r:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial">&gt; - * Permission=
 to use, copy, modify, and/or distribute this software</div><div class=3D"g=
mail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial">&gt; for any</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34=
,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial">&gt; - * purpose with or witho=
ut fee is hereby granted, provided that the</div><div class=3D"gmail_extra"=
 style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial">&gt; =
above</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fam=
ily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatur=
es:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial">&gt; - * copyright notice and this permissi=
on notice appear in all copies.</div><div class=3D"gmail_extra" style=3D"co=
lor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial">&gt; - *</div><di=
v class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans=
-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial">&gt; - * THE SOFTWARE IS PROVIDED &quot;AS IS&quot; AND T=
HE AUTHOR DISCLAIMS ALL</div><div class=3D"gmail_extra" style=3D"color:rgb(=
34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial">&gt; WARRANTIES WITH</div=
><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial">&gt; - * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIE=
D WARRANTIES OF</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial">&gt; MERCHANTABILITY</div><div cl=
ass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial">&gt; - * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE =
FOR ANY</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; SPECIAL, DIRECT,</div><div class=3D"=
gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial">&gt; - * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVE=
R</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:=
arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial">&gt; RESULTING FROM</div><div class=3D"gmail_ex=
tra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial">&=
gt; - * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,</di=
v><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial=
,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial">&gt; NEGLIGENCE</div><div class=3D"gmail_extra" styl=
e=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial">&gt; - * O=
R OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE</div><div=
 class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-=
serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial">&gt; USE OR</div><div class=3D"gmail_extra" style=3D"color=
:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial">&gt; - * PERFORMANCE=
 OF THIS SOFTWARE.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34=
,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0*/</div><div =
class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-s=
erif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial">&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,=
34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoratio=
n-style:initial;text-decoration-color:initial">&gt;=C2=A0 /dts-v1/;</div><d=
iv class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,san=
s-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fon=
t-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:star=
t;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;b=
ackground-color:rgb(255,255,255);text-decoration-style:initial;text-decorat=
ion-color:initial">&gt; diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac68=
u.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fam=
ily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatur=
es:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial">&gt; b/arch/arm/boot/dts/bcm4708-asus-rt-ac=
68u.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; index 8fa033fea959..3bcc03788f38 100=
644</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-famil=
y:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial">&gt; --- a/arch/arm/boot/dts/bcm4708-asus-rt-=
ac68u.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt; +++ b/arch/arm/boot/dts/bcm4708-as=
us-rt-ac68u.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial">&gt; @@ -1,20 +1,9 @@</div><div c=
lass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">&gt; +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT</d=
iv><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:aria=
l,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norma=
l;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align=
:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:=
0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-de=
coration-color:initial">&gt;=C2=A0 /*</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =
=C2=A0* Broadcom BCM470X / BCM5301X ARM platform code.</div><div class=3D"g=
mail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial">&gt;=C2=A0 =C2=A0* DTS for Asus RT-AC68U</div><div class=3D"gmail_ext=
ra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sma=
ll;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal=
;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(2=
55,255,255);text-decoration-style:initial;text-decoration-color:initial">&g=
t;=C2=A0 =C2=A0*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,3=
4);font-family:arial,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Copyright (C)=
 2015 Rafa=C5=82 Mi=C5=82ecki &lt;<a href=3D"mailto:zajec5@gmail.com">zajec=
5@gmail.com</a>&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,3=
4,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-v=
ariant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;white-spac=
e:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration=
-style:initial;text-decoration-color:initial">&gt; - *</div><div class=3D"g=
mail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial">&gt; - * Permission to use, copy, modify, and/or distribute this soft=
ware</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fami=
ly:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial">&gt; for any</div><div class=3D"gmail_extra"=
 style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial">&gt; =
- * purpose with or without fee is hereby granted, provided that the</div><=
div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sa=
ns-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
background-color:rgb(255,255,255);text-decoration-style:initial;text-decora=
tion-color:initial">&gt; above</div><div class=3D"gmail_extra" style=3D"col=
or:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:no=
rmal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial">&gt; - * copyright=
 notice and this permission notice appear in all copies.</div><div class=3D=
"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;fon=
t-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;white-space:normal;word-spacing:0px;background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial">&gt; - *</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,3=
4);font-family:arial,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial">&gt; - * THE SOFTWARE IS PROVIDE=
D &quot;AS IS&quot; AND THE AUTHOR DISCLAIMS ALL</div><div class=3D"gmail_e=
xtra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial">=
&gt; WARRANTIES WITH</div><div class=3D"gmail_extra" style=3D"color:rgb(34,=
34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoratio=
n-style:initial;text-decoration-color:initial">&gt; - * REGARD TO THIS SOFT=
WARE INCLUDING ALL IMPLIED WARRANTIES OF</div><div class=3D"gmail_extra" st=
yle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial">&gt; MER=
CHANTABILITY</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">&gt; - * AND FITNESS. IN NO EVENT SH=
ALL THE AUTHOR BE LIABLE FOR ANY</div><div class=3D"gmail_extra" style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial">&gt; SPECIAL, DI=
RECT,</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fam=
ily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatur=
es:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial">&gt; - * INDIRECT, OR CONSEQUENTIAL DAMAGES=
 OR ANY DAMAGES WHATSOEVER</div><div class=3D"gmail_extra" style=3D"color:r=
gb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal=
;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial">&gt; RESULTING FROM</d=
iv><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:aria=
l,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norma=
l;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align=
:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:=
0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-de=
coration-color:initial">&gt; - * LOSS OF USE, DATA OR PROFITS, WHETHER IN A=
N ACTION OF CONTRACT,</div><div class=3D"gmail_extra" style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial">&gt; NEGLIGENCE</div><div c=
lass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">&gt; - * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONN=
ECTION WITH THE</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial">&gt; USE OR</div><div class=3D"gm=
ail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-s=
ize:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps=
:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:=
0px;text-transform:none;white-space:normal;word-spacing:0px;background-colo=
r:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:init=
ial">&gt; - * PERFORMANCE OF THIS SOFTWARE.</div><div class=3D"gmail_extra"=
 style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
=C2=A0 =C2=A0*/</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial">&gt;</div><div class=3D"gmail_ext=
ra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sma=
ll;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal=
;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(2=
55,255,255);text-decoration-style:initial;text-decoration-color:initial">&g=
t;=C2=A0 /dts-v1/;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34=
,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial">&gt; diff --git a/arch/arm/boo=
t/dts/bcm4708-linksys-ea6300-v1.dts</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt; b/arch=
/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts</div><div class=3D"gmail_extra"=
 style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial">&gt; =
index 126ab5867772..6c8f0ad82332 100644</div><div class=3D"gmail_extra" sty=
le=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial">&gt; --- =
a/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts</div><div class=3D"gmail_=
extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:=
small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial"=
>&gt; +++ b/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt; @@ -1,7 +1,6 @@</div><div class=3D"gmail_extra" style=3D"co=
lor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial">&gt; +// SPDX-Lic=
ense-Identifier: GPL-2.0-or-later OR MIT</div><div class=3D"gmail_extra" st=
yle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=
=A0 /*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fa=
mily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;white-space:normal;word=
-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initia=
l;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Copyright (C) 2017 Rafa=
=C5=82 Mi=C5=82ecki &lt;<a href=3D"mailto:rafal@milecki.pl">rafal@milecki.p=
l</a>&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt; - *</div><div class=3D"gmail_extra=
" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
 - * Licensed under the ISC license.</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =
=C2=A0*/</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-=
family:arial,sans-serif;font-size:small;font-style:normal;font-variant-liga=
tures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal=
;text-align:start;text-indent:0px;text-transform:none;white-space:normal;wo=
rd-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:init=
ial;text-decoration-color:initial">&gt;</div><div class=3D"gmail_extra" sty=
le=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=
=A0 /dts-v1/;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);=
font-family:arial,sans-serif;font-size:small;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial">&gt; diff --git a/arch/arm/boot/dts=
/bcm4708-luxul-xap-1510.dts</div><div class=3D"gmail_extra" style=3D"color:=
rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-de=
coration-style:initial;text-decoration-color:initial">&gt; b/arch/arm/boot/=
dts/bcm4708-luxul-xap-1510.dts</div><div class=3D"gmail_extra" style=3D"col=
or:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:no=
rmal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial">&gt; index f591b0f=
256d8..ebda45fe9ea4 100644</div><div class=3D"gmail_extra" style=3D"color:r=
gb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal=
;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial">&gt; --- a/arch/arm/bo=
ot/dts/bcm4708-luxul-xap-1510.dts</div><div class=3D"gmail_extra" style=3D"=
color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial">&gt; +++ b/arch=
/arm/boot/dts/bcm4708-luxul-xap-1510.dts</div><div class=3D"gmail_extra" st=
yle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial">&gt; @@ =
-1,7 +1,6 @@</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">&gt; +// SPDX-License-Identifier: GP=
L-2.0-or-later OR MIT</div><div class=3D"gmail_extra" style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial">&gt;=C2=A0 /*</div><div cla=
ss=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-seri=
f;font-size:small;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial">&gt;=C2=A0 =C2=A0* Copyright 2016 Luxul Inc.</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt; - *</div><div class=3D"gmail_extra" style=3D"color:rgb(34,3=
4,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-v=
ariant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;white-spac=
e:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration=
-style:initial;text-decoration-color:initial">&gt; - * Licensed under the I=
SC license.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fo=
nt-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:i=
nitial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0*/</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial">&gt;=C2=A0 /dts-v1/;</div><div cl=
ass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial">&gt; diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dt=
s</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:=
arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial">&gt; b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000=
.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fami=
ly:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial">&gt; index 5efb6f31164d..9dd0e22c906a 100644=
</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:a=
rial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;white-space:normal;word-spaci=
ng:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial">&gt; --- a/arch/arm/boot/dts/bcm4708-luxul-xwc-1=
000.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; +++ b/arch/arm/boot/dts/bcm4708-luxu=
l-xwc-1000.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34)=
;font-family:arial,sans-serif;font-size:small;font-style:normal;font-varian=
t-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:=
normal;text-align:start;text-indent:0px;text-transform:none;white-space:nor=
mal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial">&gt; @@ -1,10 +1,9 @@</div><div cl=
ass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial">&gt; +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT</di=
v><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial=
,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial">&gt;=C2=A0 /*</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =
=C2=A0* Broadcom BCM470X / BCM5301X ARM platform code.</div><div class=3D"g=
mail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial">&gt;=C2=A0 =C2=A0* DTS for Luxul XWC-1000</div><div class=3D"gmail_ex=
tra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial">&=
gt;=C2=A0 =C2=A0*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,=
34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Copyright 20=
14 Luxul Inc.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);=
font-family:arial,sans-serif;font-size:small;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial">&gt; - *</div><div class=3D"gmail_e=
xtra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial">=
&gt; - * Licensed under the GNU/GPL. See COPYING for details.</div><div cla=
ss=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-seri=
f;font-size:small;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial">&gt;=C2=A0 =C2=A0*/</div><div class=3D"gmail_extra" style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial">&gt;</div><div c=
lass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">&gt;=C2=A0 /dts-v1/;</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt; diff -=
-git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts</div><div class=3D"gm=
ail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-s=
ize:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps=
:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:=
0px;text-transform:none;white-space:normal;word-spacing:0px;background-colo=
r:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:init=
ial">&gt; b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt; index bb66cebe0bd8..2642494c97a1 100644</div><div class=3D"=
gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial">&gt; --- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts</div><div =
class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-s=
erif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial">&gt; +++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts</=
div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ari=
al,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norm=
al;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing=
:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-d=
ecoration-color:initial">&gt; @@ -1,20 +1,9 @@</div><div class=3D"gmail_ext=
ra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sma=
ll;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal=
;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(2=
55,255,255);text-decoration-style:initial;text-decoration-color:initial">&g=
t; +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT</div><div class=3D"=
gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial">&gt;=C2=A0 /*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,=
34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoratio=
n-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Broadcom =
BCM470X / BCM5301X ARM platform code.</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =
=C2=A0* DTS for Netgear R6300 V2</div><div class=3D"gmail_extra" style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=
=A0*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fami=
ly:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Copyright (C) 2014 Rafa=
=C5=82 Mi=C5=82ecki &lt;<a href=3D"mailto:zajec5@gmail.com">zajec5@gmail.co=
m</a>&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt; - *</div><div class=3D"gmail_extra=
" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
 - * Permission to use, copy, modify, and/or distribute this software</div>=
<div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial">&gt; for any</div><div class=3D"gmail_extra" style=3D"=
color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial">&gt; - * purpos=
e with or without fee is hereby granted, provided that the</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt; above</div><div class=3D"gmail_extra" style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial">&gt; - * copyright notice a=
nd this permission notice appear in all copies.</div><div class=3D"gmail_ex=
tra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial">&=
gt; - *</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; - * THE SOFTWARE IS PROVIDED &quot;A=
S IS&quot; AND THE AUTHOR DISCLAIMS ALL</div><div class=3D"gmail_extra" sty=
le=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial">&gt; WARR=
ANTIES WITH</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fo=
nt-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:i=
nitial;text-decoration-color:initial">&gt; - * REGARD TO THIS SOFTWARE INCL=
UDING ALL IMPLIED WARRANTIES OF</div><div class=3D"gmail_extra" style=3D"co=
lor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial">&gt; MERCHANTABIL=
ITY</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-famil=
y:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial">&gt; - * AND FITNESS. IN NO EVENT SHALL THE A=
UTHOR BE LIABLE FOR ANY</div><div class=3D"gmail_extra" style=3D"color:rgb(=
34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial">&gt; SPECIAL, DIRECT,</di=
v><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial=
,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial">&gt; - * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY D=
AMAGES WHATSOEVER</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,=
34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial">&gt; RESULTING FROM</div><div c=
lass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">&gt; - * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION =
OF CONTRACT,</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">&gt; NEGLIGENCE</div><div class=3D"g=
mail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial">&gt; - * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WI=
TH THE</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fa=
mily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;white-space:normal;word=
-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initia=
l;text-decoration-color:initial">&gt; USE OR</div><div class=3D"gmail_extra=
" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
 - * PERFORMANCE OF THIS SOFTWARE.</div><div class=3D"gmail_extra" style=3D=
"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-styl=
e:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=
=A0*/</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fam=
ily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatur=
es:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial">&gt;</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =
/dts-v1/;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt; diff --git a/arch/arm/boot/dts/bcm=
4708-smartrg-sr400ac.dts</div><div class=3D"gmail_extra" style=3D"color:rgb=
(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial">&gt; b/arch/arm/boot/dts=
/bcm4708-smartrg-sr400ac.dts</div><div class=3D"gmail_extra" style=3D"color=
:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial">&gt; index 83a4c60bb=
431..e7b09b7b7d25 100644</div><div class=3D"gmail_extra" style=3D"color:rgb=
(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial">&gt; --- a/arch/arm/boot=
/dts/bcm4708-smartrg-sr400ac.dts</div><div class=3D"gmail_extra" style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial">&gt; +++ b/arch/=
arm/boot/dts/bcm4708-smartrg-sr400ac.dts</div><div class=3D"gmail_extra" st=
yle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial">&gt; @@ =
-1,10 +1,9 @@</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);=
font-family:arial,sans-serif;font-size:small;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial">&gt; +// SPDX-License-Identifier: G=
PL-2.0-or-later OR MIT</div><div class=3D"gmail_extra" style=3D"color:rgb(3=
4,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial">&gt;=C2=A0 /*</div><div cl=
ass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial">&gt;=C2=A0 =C2=A0* Broadcom BCM470X / BCM5301X arm platform c=
ode.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fami=
ly:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial">&gt;=C2=A0 =C2=A0* DTS for SmartRG SR400ac</=
div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ari=
al,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norm=
al;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing=
:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-d=
ecoration-color:initial">&gt;=C2=A0 =C2=A0*</div><div class=3D"gmail_extra"=
 style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
=C2=A0 =C2=A0* Copyright (C) 2015 Rafa=C5=82 Mi=C5=82ecki &lt;<a href=3D"ma=
ilto:zajec5@gmail.com">zajec5@gmail.com</a>&gt;</div><div class=3D"gmail_ex=
tra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial">&=
gt; - *</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; - * Licensed under the GNU/GPL. See =
COPYING for details.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,=
34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoratio=
n-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0*/</div><di=
v class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans=
-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial">&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(3=
4,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial">&gt;=C2=A0 /dts-v1/;</div>=
<div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial">&gt; diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n=
18u.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; b/arch/arm/boot/dts/bcm47081-asus-rt=
-n18u.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt; index 0800a964f2fe..16314fcc6e56 1=
00644</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fam=
ily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatur=
es:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial">&gt; --- a/arch/arm/boot/dts/bcm47081-asus-=
rt-n18u.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fo=
nt-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:i=
nitial;text-decoration-color:initial">&gt; +++ b/arch/arm/boot/dts/bcm47081=
-asus-rt-n18u.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,=
34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial">&gt; @@ -1,20 +1,9 @@</div><div=
 class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-=
serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial">&gt; +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT<=
/div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ar=
ial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial">&gt;=C2=A0 /*</div><div class=3D"gmail_extra" sty=
le=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=
=A0 =C2=A0* Broadcom BCM470X / BCM5301X ARM platform code.</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt;=C2=A0 =C2=A0* DTS for Asus RT-N18U</div><div class=3D"gmail=
_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
">&gt;=C2=A0 =C2=A0*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,=
34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoratio=
n-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Copyright=
 (C) 2014 Rafa=C5=82 Mi=C5=82ecki &lt;<a href=3D"mailto:zajec5@gmail.com">z=
ajec5@gmail.com</a>&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(=
34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial">&gt; - *</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt; - * Permission to use, copy, modify, and/or distribute this=
 software</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt; for any</div><div class=3D"gmail_e=
xtra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial">=
&gt; - * purpose with or without fee is hereby granted, provided that the</=
div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ari=
al,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norm=
al;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing=
:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-d=
ecoration-color:initial">&gt; above</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt; - * co=
pyright notice and this permission notice appear in all copies.</div><div c=
lass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">&gt; - *</div><div class=3D"gmail_extra" style=3D"color:rgb(=
34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial">&gt; - * THE SOFTWARE IS =
PROVIDED &quot;AS IS&quot; AND THE AUTHOR DISCLAIMS ALL</div><div class=3D"=
gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial">&gt; WARRANTIES WITH</div><div class=3D"gmail_extra" style=3D"color:=
rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-de=
coration-style:initial;text-decoration-color:initial">&gt; - * REGARD TO TH=
IS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF</div><div class=3D"gmail_ex=
tra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial">&=
gt; MERCHANTABILITY</div><div class=3D"gmail_extra" style=3D"color:rgb(34,3=
4,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-v=
ariant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;white-spac=
e:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration=
-style:initial;text-decoration-color:initial">&gt; - * AND FITNESS. IN NO E=
VENT SHALL THE AUTHOR BE LIABLE FOR ANY</div><div class=3D"gmail_extra" sty=
le=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial">&gt; SPEC=
IAL, DIRECT,</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">&gt; - * INDIRECT, OR CONSEQUENTIAL =
DAMAGES OR ANY DAMAGES WHATSOEVER</div><div class=3D"gmail_extra" style=3D"=
color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial">&gt; RESULTING =
FROM</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fami=
ly:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial">&gt; - * LOSS OF USE, DATA OR PROFITS, WHETH=
ER IN AN ACTION OF CONTRACT,</div><div class=3D"gmail_extra" style=3D"color=
:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial">&gt; NEGLIGENCE</div=
><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial">&gt; - * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR =
IN CONNECTION WITH THE</div><div class=3D"gmail_extra" style=3D"color:rgb(3=
4,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial">&gt; USE OR</div><div clas=
s=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif=
;font-size:small;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial">&gt; - * PERFORMANCE OF THIS SOFTWARE.</div><div class=3D"gmail=
_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
">&gt;=C2=A0 =C2=A0*/</div><div class=3D"gmail_extra" style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial">&gt;</div><div class=3D"gma=
il_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-si=
ze:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;white-space:normal;word-spacing:0px;background-color=
:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initi=
al">&gt;=C2=A0 /dts-v1/;</div><div class=3D"gmail_extra" style=3D"color:rgb=
(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial">&gt; diff --git a/arch/a=
rm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts</div><div class=3D"gmail_extra=
" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
 b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts</div><div class=3D"gm=
ail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-s=
ize:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps=
:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:=
0px;text-transform:none;white-space:normal;word-spacing:0px;background-colo=
r:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:init=
ial">&gt; index c2af33eb47de..328aa90240ce 100644</div><div class=3D"gmail_=
extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:=
small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial"=
>&gt; --- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts</div><div cl=
ass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial">&gt; +++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts=
</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:a=
rial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;white-space:normal;word-spaci=
ng:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial">&gt; @@ -1,20 +1,9 @@</div><div class=3D"gmail_e=
xtra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial">=
&gt; +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt;=C2=A0 /*</div><div class=3D"gmail_extra" style=3D"color:rgb=
(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Broad=
com BCM470X / BCM5301X ARM platform code.</div><div class=3D"gmail_extra" s=
tyle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=
=A0 =C2=A0* DTS for Buffalo WZR-600DHP2</div><div class=3D"gmail_extra" sty=
le=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=
=A0 =C2=A0*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fo=
nt-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:i=
nitial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Copyright (C) 2014=
 Rafa=C5=82 Mi=C5=82ecki &lt;<a href=3D"mailto:zajec5@gmail.com">zajec5@gma=
il.com</a>&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34)=
;font-family:arial,sans-serif;font-size:small;font-style:normal;font-varian=
t-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:=
normal;text-align:start;text-indent:0px;text-transform:none;white-space:nor=
mal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial">&gt; - *</div><div class=3D"gmail_=
extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:=
small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial"=
>&gt; - * Permission to use, copy, modify, and/or distribute this software<=
/div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ar=
ial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial">&gt; for any</div><div class=3D"gmail_extra" styl=
e=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial">&gt; - * p=
urpose with or without fee is hereby granted, provided that the</div><div c=
lass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">&gt; above</div><div class=3D"gmail_extra" style=3D"color:rg=
b(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;=
font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lett=
er-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whit=
e-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-deco=
ration-style:initial;text-decoration-color:initial">&gt; - * copyright noti=
ce and this permission notice appear in all copies.</div><div class=3D"gmai=
l_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-siz=
e:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;background-color:=
rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initia=
l">&gt; - *</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fo=
nt-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:i=
nitial;text-decoration-color:initial">&gt; - * THE SOFTWARE IS PROVIDED &qu=
ot;AS IS&quot; AND THE AUTHOR DISCLAIMS ALL</div><div class=3D"gmail_extra"=
 style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial">&gt; =
WARRANTIES WITH</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial">&gt; - * REGARD TO THIS SOFTWARE =
INCLUDING ALL IMPLIED WARRANTIES OF</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt; MERCHA=
NTABILITY</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt; - * AND FITNESS. IN NO EVENT SHALL=
 THE AUTHOR BE LIABLE FOR ANY</div><div class=3D"gmail_extra" style=3D"colo=
r:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial">&gt; SPECIAL, DIREC=
T,</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family=
:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:=
normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial">&gt; - * INDIRECT, OR CONSEQUENTIAL DAMAGES OR=
 ANY DAMAGES WHATSOEVER</div><div class=3D"gmail_extra" style=3D"color:rgb(=
34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial">&gt; RESULTING FROM</div>=
<div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial">&gt; - * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN A=
CTION OF CONTRACT,</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34=
,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial">&gt; NEGLIGENCE</div><div clas=
s=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif=
;font-size:small;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial">&gt; - * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECT=
ION WITH THE</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">&gt; USE OR</div><div class=3D"gmail=
_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
">&gt; - * PERFORMANCE OF THIS SOFTWARE.</div><div class=3D"gmail_extra" st=
yle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=
=A0 =C2=A0*/</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">&gt;</div><div class=3D"gmail_extra"=
 style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
=C2=A0 /dts-v1/;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,3=
4);font-family:arial,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial">&gt; diff --git a/arch/arm/boot/=
dts/bcm47081-luxul-xap-1410.dts</div><div class=3D"gmail_extra" style=3D"co=
lor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial">&gt; b/arch/arm/b=
oot/dts/bcm47081-luxul-xap-1410.dts</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt; index =
9b5759849983..5eeac7302329 100644</div><div class=3D"gmail_extra" style=3D"=
color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial">&gt; --- a/arch=
/arm/boot/dts/bcm47081-luxul-xap-1410.dts</div><div class=3D"gmail_extra" s=
tyle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial">&gt; ++=
+ b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts</div><div class=3D"gmail_=
extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:=
small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial"=
>&gt; @@ -1,7 +1,6 @@</div><div class=3D"gmail_extra" style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial">&gt; +// SPDX-License-Ident=
ifier: GPL-2.0-or-later OR MIT</div><div class=3D"gmail_extra" style=3D"col=
or:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:no=
rmal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 /*</div=
><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial">&gt;=C2=A0 =C2=A0* Copyright 2017 Luxul Inc.</div><di=
v class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans=
-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial">&gt; - *</div><div class=3D"gmail_extra" style=3D"color:r=
gb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal=
;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial">&gt; - * Licensed unde=
r the ISC license.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34=
,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0*/</div><div =
class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-s=
erif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial">&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,=
34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoratio=
n-style:initial;text-decoration-color:initial">&gt;=C2=A0 /dts-v1/;</div><d=
iv class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,san=
s-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fon=
t-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:star=
t;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;b=
ackground-color:rgb(255,255,255);text-decoration-style:initial;text-decorat=
ion-color:initial">&gt; diff --git a/arch/arm/boot/dts/bcm47081-luxul-xwr-1=
200.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; b/arch/arm/boot/dts/bcm47081-luxul-x=
wr-1200.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fo=
nt-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:i=
nitial;text-decoration-color:initial">&gt; index ba1c19b1b3eb..da4d9ec62fc6=
 100644</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; --- a/arch/arm/boot/dts/bcm47081-lux=
ul-xwr-1200.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial">&gt; +++ b/arch/arm/boot/dts/bcm4=
7081-luxul-xwr-1200.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(=
34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial">&gt; @@ -1,7 +1,6 @@</div=
><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial">&gt; +// SPDX-License-Identifier: GPL-2.0-or-later OR=
 MIT</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fami=
ly:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial">&gt;=C2=A0 /*</div><div class=3D"gmail_extra=
" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
=C2=A0 =C2=A0* Copyright 2017 Luxul Inc.</div><div class=3D"gmail_extra" st=
yle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial">&gt; - *=
</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:a=
rial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;white-space:normal;word-spaci=
ng:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial">&gt; - * Licensed under the ISC license.</div><d=
iv class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,san=
s-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fon=
t-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:star=
t;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;b=
ackground-color:rgb(255,255,255);text-decoration-style:initial;text-decorat=
ion-color:initial">&gt;=C2=A0 =C2=A0*/</div><div class=3D"gmail_extra" styl=
e=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial">&gt;</div>=
<div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial">&gt;=C2=A0 /dts-v1/;</div><div class=3D"gmail_extra" s=
tyle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial">&gt; di=
ff --git a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts</div><div cla=
ss=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-seri=
f;font-size:small;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial">&gt; b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts</div=
><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial">&gt; index 3ed8de42cb48..c94c732188fb 100644</div><di=
v class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans=
-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial">&gt; --- a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2=
.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fami=
ly:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial">&gt; +++ b/arch/arm/boot/dts/bcm47081-tplink=
-archer-c5-v2.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,=
34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial">&gt; @@ -1,7 +1,6 @@</div><div =
class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-s=
erif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial">&gt; +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT</=
div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ari=
al,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norm=
al;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing=
:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-d=
ecoration-color:initial">&gt;=C2=A0 /*</div><div class=3D"gmail_extra" styl=
e=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0=
 =C2=A0* Copyright (C) 2017 Rafa=C5=82 Mi=C5=82ecki &lt;<a href=3D"mailto:r=
afal@milecki.pl">rafal@milecki.pl</a>&gt;</div><div class=3D"gmail_extra" s=
tyle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial">&gt; - =
*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:=
arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial">&gt; - * Licensed under the ISC license.</div><=
div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sa=
ns-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
background-color:rgb(255,255,255);text-decoration-style:initial;text-decora=
tion-color:initial">&gt;=C2=A0 =C2=A0*/</div><div class=3D"gmail_extra" sty=
le=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial">&gt;</div=
><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial">&gt;=C2=A0 /dts-v1/;</div><div class=3D"gmail_extra" =
style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;f=
ont-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fon=
t-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,2=
55,255);text-decoration-style:initial;text-decoration-color:initial">&gt; d=
iff --git a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts</div><div class=3D=
"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;fon=
t-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;white-space:normal;word-spacing:0px;background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial">&gt; b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt; index 3d1d9c2c4efc..db744a5e122d 100644</div><div class=3D"=
gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial">&gt; --- a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts</div><div cl=
ass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial">&gt; +++ b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts</div>=
<div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial">&gt; @@ -1,7 +1,6 @@</div><div class=3D"gmail_extra" s=
tyle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial">&gt; +/=
/ SPDX-License-Identifier: GPL-2.0-or-later OR MIT</div><div class=3D"gmail=
_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
">&gt;=C2=A0 /*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Copyright (C) =
2017 Rafa=C5=82 Mi=C5=82ecki &lt;<a href=3D"mailto:rafal@milecki.pl">rafal@=
milecki.pl</a>&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34=
,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial">&gt; - *</div><div class=3D"gm=
ail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-s=
ize:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps=
:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:=
0px;text-transform:none;white-space:normal;word-spacing:0px;background-colo=
r:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:init=
ial">&gt; - * Licensed under the ISC license.</div><div class=3D"gmail_extr=
a" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:smal=
l;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;=
font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text=
-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(25=
5,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt=
;=C2=A0 =C2=A0*/</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,3=
4);font-family:arial,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial">&gt;</div><div class=3D"gmail_ex=
tra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial">&=
gt;=C2=A0 /dts-v1/;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,3=
4,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-v=
ariant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;white-spac=
e:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration=
-style:initial;text-decoration-color:initial">&gt; diff --git a/arch/arm/bo=
ot/dts/bcm4709-netgear-r7000.dts</div><div class=3D"gmail_extra" style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial">&gt; b/arch/arm/=
boot/dts/bcm4709-netgear-r7000.dts</div><div class=3D"gmail_extra" style=3D=
"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-styl=
e:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial">&gt; index f43=
ab4721456..9e267d38df4c 100644</div><div class=3D"gmail_extra" style=3D"col=
or:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:no=
rmal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial">&gt; --- a/arch/ar=
m/boot/dts/bcm4709-netgear-r7000.dts</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt; +++ b/=
arch/arm/boot/dts/bcm4709-netgear-r7000.dts</div><div class=3D"gmail_extra"=
 style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial">&gt; =
@@ -1,20 +1,9 @@</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,3=
4);font-family:arial,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial">&gt; +// SPDX-License-Identifier=
: GPL-2.0-or-later OR MIT</div><div class=3D"gmail_extra" style=3D"color:rg=
b(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;=
font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lett=
er-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whit=
e-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-deco=
ration-style:initial;text-decoration-color:initial">&gt;=C2=A0 /*</div><div=
 class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-=
serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial">&gt;=C2=A0 =C2=A0* Broadcom BCM470X / BCM5301X ARM platfor=
m code.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* DTS for Netgear R7000<=
/div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ar=
ial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial">&gt;=C2=A0 =C2=A0*</div><div class=3D"gmail_extra=
" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
=C2=A0 =C2=A0* Copyright (C) 2015 Rafa=C5=82 Mi=C5=82ecki &lt;<a href=3D"ma=
ilto:zajec5@gmail.com">zajec5@gmail.com</a>&gt;</div><div class=3D"gmail_ex=
tra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial">&=
gt; - *</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; - * Permission to use, copy, modify,=
 and/or distribute this software</div><div class=3D"gmail_extra" style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial">&gt; for any</di=
v><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial=
,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial">&gt; - * purpose with or without fee is hereby grant=
ed, provided that the</div><div class=3D"gmail_extra" style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial">&gt; above</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt; - * copyright notice and this permission notice appear in a=
ll copies.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fon=
t-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial">&gt; - *</div><div class=3D"gmail_extr=
a" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:smal=
l;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;=
font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text=
-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(25=
5,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt=
; - * THE SOFTWARE IS PROVIDED &quot;AS IS&quot; AND THE AUTHOR DISCLAIMS A=
LL</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family=
:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:=
normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial">&gt; WARRANTIES WITH</div><div class=3D"gmail_=
extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:=
small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial"=
>&gt; - * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF</div>=
<div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial">&gt; MERCHANTABILITY</div><div class=3D"gmail_extra" s=
tyle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial">&gt; - =
* AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY</div><div cla=
ss=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-seri=
f;font-size:small;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial">&gt; SPECIAL, DIRECT,</div><div class=3D"gmail_extra" style=3D=
"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-styl=
e:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial">&gt; - * INDIR=
ECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER</div><div class=3D"=
gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial">&gt; RESULTING FROM</div><div class=3D"gmail_extra" style=3D"color:r=
gb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal=
;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial">&gt; - * LOSS OF USE, =
DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,</div><div class=3D"gmail=
_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
">&gt; NEGLIGENCE</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,=
34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial">&gt; - * OR OTHER TORTIOUS ACTI=
ON, ARISING OUT OF OR IN CONNECTION WITH THE</div><div class=3D"gmail_extra=
" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
 USE OR</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; - * PERFORMANCE OF THIS SOFTWARE.</d=
iv><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:aria=
l,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norma=
l;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align=
:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:=
0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-de=
coration-color:initial">&gt;=C2=A0 =C2=A0*/</div><div class=3D"gmail_extra"=
 style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;<=
/div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ar=
ial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial">&gt;=C2=A0 /dts-v1/;</div><div class=3D"gmail_ext=
ra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sma=
ll;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal=
;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(2=
55,255,255);text-decoration-style:initial;text-decoration-color:initial">&g=
t; diff --git a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts</div><div=
 class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-=
serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial">&gt; b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts</=
div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ari=
al,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norm=
al;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing=
:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-d=
ecoration-color:initial">&gt; index ec4a50e440f6..f5bf6586ae07 100644</div>=
<div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial">&gt; --- a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-=
v1.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fa=
mily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;white-space:normal;word=
-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initia=
l;text-decoration-color:initial">&gt; +++ b/arch/arm/boot/dts/bcm4709-tplin=
k-archer-c9-v1.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34=
,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial">&gt; @@ -1,7 +1,6 @@</div><div=
 class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-=
serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial">&gt; +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT<=
/div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ar=
ial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial">&gt;=C2=A0 /*</div><div class=3D"gmail_extra" sty=
le=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=
=A0 =C2=A0* Copyright (C) 2016 Rafa=C5=82 Mi=C5=82ecki &lt;<a href=3D"mailt=
o:rafal@milecki.pl">rafal@milecki.pl</a>&gt;</div><div class=3D"gmail_extra=
" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
 - *</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fami=
ly:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial">&gt; - * Licensed under the ISC license.</di=
v><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial=
,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial">&gt;=C2=A0 =C2=A0*/</div><div class=3D"gmail_extra" =
style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;f=
ont-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fon=
t-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,2=
55,255);text-decoration-style:initial;text-decoration-color:initial">&gt;</=
div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ari=
al,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norm=
al;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing=
:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-d=
ecoration-color:initial">&gt;=C2=A0 /dts-v1/;</div><div class=3D"gmail_extr=
a" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:smal=
l;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;=
font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text=
-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(25=
5,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt=
; diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts</div><div clas=
s=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif=
;font-size:small;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial">&gt; b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts</div><div =
class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-s=
erif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial">&gt; index 7cc7d344fe5b..494dbd39658c 100644</div><div clas=
s=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif=
;font-size:small;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial">&gt; --- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts</div><=
div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sa=
ns-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
background-color:rgb(255,255,255);text-decoration-style:initial;text-decora=
tion-color:initial">&gt; +++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dt=
s</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:=
arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial">&gt; @@ -1,20 +1,9 @@</div><div class=3D"gmail_=
extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:=
small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial"=
>&gt; +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt;=C2=A0 /*</div><div class=3D"gmail_extra" style=3D"color:rgb=
(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Broad=
com BCM470X / BCM5301X ARM platform code.</div><div class=3D"gmail_extra" s=
tyle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=
=A0 =C2=A0* DTS for D-Link DIR-885L</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =
=C2=A0*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Copyright (C) 2016 Raf=
a=C5=82 Mi=C5=82ecki &lt;<a href=3D"mailto:zajec5@gmail.com">zajec5@gmail.c=
om</a>&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fon=
t-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial">&gt; - *</div><div class=3D"gmail_extr=
a" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:smal=
l;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;=
font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text=
-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(25=
5,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt=
; - * Permission to use, copy, modify, and/or distribute this software</div=
><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial">&gt; for any</div><div class=3D"gmail_extra" style=3D=
"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-styl=
e:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial">&gt; - * purpo=
se with or without fee is hereby granted, provided that the</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt; above</div><div class=3D"gmail_extra" style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial">&gt; - * copyright notice a=
nd this permission notice appear in all copies.</div><div class=3D"gmail_ex=
tra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial">&=
gt; - *</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; - * THE SOFTWARE IS PROVIDED &quot;A=
S IS&quot; AND THE AUTHOR DISCLAIMS ALL</div><div class=3D"gmail_extra" sty=
le=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial">&gt; WARR=
ANTIES WITH</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fo=
nt-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:i=
nitial;text-decoration-color:initial">&gt; - * REGARD TO THIS SOFTWARE INCL=
UDING ALL IMPLIED WARRANTIES OF</div><div class=3D"gmail_extra" style=3D"co=
lor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial">&gt; MERCHANTABIL=
ITY</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-famil=
y:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial">&gt; - * AND FITNESS. IN NO EVENT SHALL THE A=
UTHOR BE LIABLE FOR ANY</div><div class=3D"gmail_extra" style=3D"color:rgb(=
34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial">&gt; SPECIAL, DIRECT,</di=
v><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial=
,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial">&gt; - * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY D=
AMAGES WHATSOEVER</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,=
34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial">&gt; RESULTING FROM</div><div c=
lass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">&gt; - * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION =
OF CONTRACT,</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">&gt; NEGLIGENCE</div><div class=3D"g=
mail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial">&gt; - * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WI=
TH THE</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fa=
mily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;white-space:normal;word=
-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initia=
l;text-decoration-color:initial">&gt; USE OR</div><div class=3D"gmail_extra=
" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
 - * PERFORMANCE OF THIS SOFTWARE.</div><div class=3D"gmail_extra" style=3D=
"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-styl=
e:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=
=A0*/</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fam=
ily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatur=
es:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial">&gt;</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =
/dts-v1/;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt; diff --git a/arch/arm/boot/dts/bcm=
47094-linksys-panamera.dts</div><div class=3D"gmail_extra" style=3D"color:r=
gb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal=
;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial">&gt; b/arch/arm/boot/d=
ts/bcm47094-linksys-panamera.dts</div><div class=3D"gmail_extra" style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial">&gt; index b6750=
f70dffb..f47afe36d857 100644</div><div class=3D"gmail_extra" style=3D"color=
:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial">&gt; --- a/arch/arm/=
boot/dts/bcm47094-linksys-panamera.dts</div><div class=3D"gmail_extra" styl=
e=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial">&gt; +++ b=
/arch/arm/boot/dts/bcm47094-linksys-panamera.dts</div><div class=3D"gmail_e=
xtra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial">=
&gt; @@ -1,7 +1,6 @@</div><div class=3D"gmail_extra" style=3D"color:rgb(34,=
34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoratio=
n-style:initial;text-decoration-color:initial">&gt; +// SPDX-License-Identi=
fier: GPL-2.0-or-later OR MIT</div><div class=3D"gmail_extra" style=3D"colo=
r:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 /*</div>=
<div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial">&gt;=C2=A0 =C2=A0* Copyright (C) 2017 Rafa=C5=82 Mi=C5=
=82ecki &lt;<a href=3D"mailto:rafal@milecki.pl">rafal@milecki.pl</a>&gt;</d=
iv><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:aria=
l,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norma=
l;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align=
:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:=
0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-de=
coration-color:initial">&gt; - *</div><div class=3D"gmail_extra" style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial">&gt; - * License=
d under the ISC license.</div><div class=3D"gmail_extra" style=3D"color:rgb=
(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0*/</div=
><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial">&gt;</div><div class=3D"gmail_extra" style=3D"color:r=
gb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal=
;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial">&gt;=C2=A0 /dts-v1/;</=
div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ari=
al,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norm=
al;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing=
:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-d=
ecoration-color:initial">&gt; diff --git a/arch/arm/boot/dts/bcm47094-luxul=
-abr-4500.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);=
font-family:arial,sans-serif;font-size:small;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial">&gt; b/arch/arm/boot/dts/bcm47094-l=
uxul-abr-4500.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,=
34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;white-space:=
normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial">&gt; index ecd22a246746..a5cef5=
1cfe4f 100644</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);=
font-family:arial,sans-serif;font-size:small;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial">&gt; --- a/arch/arm/boot/dts/bcm470=
94-luxul-abr-4500.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial">&gt; +++ b/arch/arm/boot/dt=
s/bcm47094-luxul-abr-4500.dts</div><div class=3D"gmail_extra" style=3D"colo=
r:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial">&gt; @@ -1,7 +1,6 @=
@</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:=
arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial">&gt; +// SPDX-License-Identifier: GPL-2.0-or-la=
ter OR MIT</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fon=
t-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial">&gt;=C2=A0 /*</div><div class=3D"gmail=
_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
">&gt;=C2=A0 =C2=A0* Copyright (C) 2017 Luxul Inc.</div><div class=3D"gmail=
_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
">&gt; - *</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fon=
t-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial">&gt; - * Licensed under the ISC licens=
e.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family=
:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:=
normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial">&gt;=C2=A0 =C2=A0*/</div><div class=3D"gmail_e=
xtra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial">=
&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fami=
ly:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial">&gt;=C2=A0 /dts-v1/;</div><div class=3D"gmai=
l_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-siz=
e:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;background-color:=
rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initia=
l">&gt; diff --git a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts</div><di=
v class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans=
-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial">&gt; b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts</div=
><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial">&gt; index 15ffb1abc440..7496aabf8f77 100644</div><di=
v class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans=
-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial">&gt; --- a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts<=
/div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ar=
ial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial">&gt; +++ b/arch/arm/boot/dts/bcm47094-luxul-xbr-4=
500.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; @@ -1,7 +1,6 @@</div><div class=3D"g=
mail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial">&gt; +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT</div><div c=
lass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">&gt;=C2=A0 /*</div><div class=3D"gmail_extra" style=3D"color=
:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* C=
opyright (C) 2017 Luxul Inc.</div><div class=3D"gmail_extra" style=3D"color=
:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial">&gt; - *</div><div c=
lass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">&gt; - * Licensed under the ISC license.</div><div class=3D"=
gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial">&gt;=C2=A0 =C2=A0*/</div><div class=3D"gmail_extra" style=3D"color:r=
gb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal=
;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial">&gt;</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt;=C2=A0 /dts-v1/;</div><div class=3D"gmail_extra" style=3D"co=
lor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial">&gt; diff --git a=
/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts</div><div class=3D"gmail_ext=
ra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sma=
ll;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal=
;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(2=
55,255,255);text-decoration-style:initial;text-decoration-color:initial">&g=
t; b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts</div><div class=3D"gmail=
_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
">&gt; index bc1d1e10d4ac..53aaa5212610 100644</div><div class=3D"gmail_ext=
ra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sma=
ll;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal=
;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(2=
55,255,255);text-decoration-style:initial;text-decoration-color:initial">&g=
t; --- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts</div><div class=3D"g=
mail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial">&gt; +++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts</div><div cl=
ass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial">&gt; @@ -1,7 +1,6 @@</div><div class=3D"gmail_extra" style=3D=
"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-styl=
e:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial">&gt; +// SPDX-=
License-Identifier: GPL-2.0-or-later OR MIT</div><div class=3D"gmail_extra"=
 style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
=C2=A0 /*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Copyright 2016 Luxul=
 Inc.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fam=
ily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatur=
es:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial">&gt; - *</div><div class=3D"gmail_extra" st=
yle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial">&gt; - *=
 Licensed under the ISC license.</div><div class=3D"gmail_extra" style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=
=A0*/</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fam=
ily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatur=
es:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial">&gt;</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =
/dts-v1/;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt; diff --git a/arch/arm/boot/dts/bcm=
47094-netgear-r8500.dts</div><div class=3D"gmail_extra" style=3D"color:rgb(=
34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial">&gt; b/arch/arm/boot/dts/=
bcm47094-netgear-r8500.dts</div><div class=3D"gmail_extra" style=3D"color:r=
gb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal=
;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial">&gt; index 85992997315=
8..0e718edc065a 100644</div><div class=3D"gmail_extra" style=3D"color:rgb(3=
4,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial">&gt; --- a/arch/arm/boot/d=
ts/bcm47094-netgear-r8500.dts</div><div class=3D"gmail_extra" style=3D"colo=
r:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial">&gt; +++ b/arch/arm=
/boot/dts/bcm47094-netgear-r8500.dts</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt; @@ -1,=
7 +1,6 @@</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt; +// SPDX-License-Identifier: GPL-2=
.0-or-later OR MIT</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34=
,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial">&gt;=C2=A0 /*</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt;=C2=A0 =C2=A0* Copyright (C) 2016 Rafa=C5=82 Mi=C5=82ecki &l=
t;<a href=3D"mailto:rafal@milecki.pl">rafal@milecki.pl</a>&gt;</div><div cl=
ass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial">&gt; - *</div><div class=3D"gmail_extra" style=3D"color:rgb(3=
4,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial">&gt; - * Licensed under th=
e ISC license.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34)=
;font-family:arial,sans-serif;font-size:small;font-style:normal;font-varian=
t-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:=
normal;text-align:start;text-indent:0px;text-transform:none;white-space:nor=
mal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0*/</div><div clas=
s=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif=
;font-size:small;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial">&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,3=
4);font-family:arial,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial">&gt;=C2=A0 /dts-v1/;</div><div c=
lass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">&gt; diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.d=
tsi</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-famil=
y:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial">&gt; b/arch/arm/boot/dts/bcm5301x-nand-cs0-bc=
h1.dtsi</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; index 24b099c00f13..c349e8f0afc5 100=
644</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-famil=
y:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial">&gt; --- a/arch/arm/boot/dts/bcm5301x-nand-cs=
0-bch1.dtsi</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fo=
nt-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:i=
nitial;text-decoration-color:initial">&gt; +++ b/arch/arm/boot/dts/bcm5301x=
-nand-cs0-bch1.dtsi</div><div class=3D"gmail_extra" style=3D"color:rgb(34,3=
4,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-v=
ariant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;white-spac=
e:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration=
-style:initial;text-decoration-color:initial">&gt; @@ -1,9 +1,8 @@</div><di=
v class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans=
-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial">&gt; +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT=
</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:a=
rial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;white-space:normal;word-spaci=
ng:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial">&gt;=C2=A0 /*</div><div class=3D"gmail_extra" st=
yle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=
=A0 =C2=A0* Broadcom Northstar NAND.</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =
=C2=A0*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Copyright (C) 2016 Raf=
a=C5=82 Mi=C5=82ecki &lt;<a href=3D"mailto:rafal.milecki@gmail.com">rafal.m=
ilecki@gmail.com</a>&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb=
(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial">&gt; - *</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt; - * Licensed under the ISC license.</div><div class=3D"gmai=
l_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-siz=
e:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;background-color:=
rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initia=
l">&gt;=C2=A0 =C2=A0*/</div><div class=3D"gmail_extra" style=3D"color:rgb(3=
4,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial">&gt;</div><div class=3D"gm=
ail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-s=
ize:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps=
:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:=
0px;text-transform:none;white-space:normal;word-spacing:0px;background-colo=
r:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:init=
ial">&gt;=C2=A0 #include &quot;bcm5301x-nand-cs0.dtsi&quot;</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt; diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi<=
/div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ar=
ial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial">&gt; b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.d=
tsi</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-famil=
y:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial">&gt; index b4e875df9528..18e25e302b13 100644<=
/div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:ar=
ial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial">&gt; --- a/arch/arm/boot/dts/bcm5301x-nand-cs0-bc=
h4.dtsi</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-f=
amily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial">&gt; +++ b/arch/arm/boot/dts/bcm5301x-nan=
d-cs0-bch4.dtsi</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial">&gt; @@ -1,7 +1,6 @@</div><div cl=
ass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial">&gt; +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT</di=
v><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial=
,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial">&gt;=C2=A0 /*</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=A0 =
=C2=A0* Copyright 2016 Luxul Inc.</div><div class=3D"gmail_extra" style=3D"=
color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial">&gt; - *</div><=
div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sa=
ns-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
background-color:rgb(255,255,255);text-decoration-style:initial;text-decora=
tion-color:initial">&gt; - * Licensed under the ISC license.</div><div clas=
s=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif=
;font-size:small;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial">&gt;=C2=A0 =C2=A0*/</div><div class=3D"gmail_extra" style=3D"co=
lor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial">&gt;</div><div cl=
ass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial">&gt;=C2=A0 #include &quot;bcm5301x-nand-cs0.dtsi&quot;</div><=
div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sa=
ns-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
background-color:rgb(255,255,255);text-decoration-style:initial;text-decora=
tion-color:initial">&gt; diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-b=
ch8.dtsi</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-=
family:arial,sans-serif;font-size:small;font-style:normal;font-variant-liga=
tures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal=
;text-align:start;text-indent:0px;text-transform:none;white-space:normal;wo=
rd-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:init=
ial;text-decoration-color:initial">&gt; b/arch/arm/boot/dts/bcm5301x-nand-c=
s0-bch8.dtsi</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">&gt; index 9a9630ded306..c8e56d30bd6=
f 100644</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-=
family:arial,sans-serif;font-size:small;font-style:normal;font-variant-liga=
tures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal=
;text-align:start;text-indent:0px;text-transform:none;white-space:normal;wo=
rd-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:init=
ial;text-decoration-color:initial">&gt; --- a/arch/arm/boot/dts/bcm5301x-na=
nd-cs0-bch8.dtsi</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,3=
4);font-family:arial,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial">&gt; +++ b/arch/arm/boot/dts/bcm=
5301x-nand-cs0-bch8.dtsi</div><div class=3D"gmail_extra" style=3D"color:rgb=
(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial">&gt; @@ -1,3 +1,4 @@</di=
v><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial=
,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial">&gt; +// SPDX-License-Identifier: GPL-2.0-or-later O=
R MIT</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fam=
ily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatur=
es:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial">&gt;=C2=A0 /*</div><div class=3D"gmail_extr=
a" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:smal=
l;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;=
font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text=
-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(25=
5,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt=
;=C2=A0 =C2=A0* Broadcom BCM470X / BCM5301X Nand chip defaults.</div><div c=
lass=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">&gt;=C2=A0 =C2=A0*</div><div class=3D"gmail_extra" style=3D"=
color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial">&gt; @@ -5,8 +6=
,6 @@</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-fam=
ily:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatur=
es:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* and uses 8 bit ECC.</div=
><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial">&gt;=C2=A0 =C2=A0*</div><div class=3D"gmail_extra" st=
yle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=C2=
=A0 =C2=A0* Copyright (C) 2015 Hauke Mehrtens &lt;<a href=3D"mailto:hauke@h=
auke-m.de">hauke@hauke-m.de</a>&gt;</div><div class=3D"gmail_extra" style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial">&gt; - *</d=
iv><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:aria=
l,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norma=
l;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align=
:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:=
0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-de=
coration-color:initial">&gt; - * Licensed under the GNU/GPL. See COPYING fo=
r details.</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fon=
t-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0*/</div><div class=3D=
"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;fon=
t-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;white-space:normal;word-spacing:0px;background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial">&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">&gt;=C2=A0 #include &quot;bcm5301x-n=
and-cs0.dtsi&quot;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34=
,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial">&gt; diff --git a/arch/arm/boo=
t/dts/bcm5301x-nand-cs0.dtsi</div><div class=3D"gmail_extra" style=3D"color=
:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial">&gt; b/arch/arm/boot=
/dts/bcm5301x-nand-cs0.dtsi</div><div class=3D"gmail_extra" style=3D"color:=
rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-de=
coration-style:initial;text-decoration-color:initial">&gt; index 168495106b=
82..e5a2d62daf92 100644</div><div class=3D"gmail_extra" style=3D"color:rgb(=
34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial">&gt; --- a/arch/arm/boot/=
dts/bcm5301x-nand-cs0.dtsi</div><div class=3D"gmail_extra" style=3D"color:r=
gb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal=
;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial">&gt; +++ b/arch/arm/bo=
ot/dts/bcm5301x-nand-cs0.dtsi</div><div class=3D"gmail_extra" style=3D"colo=
r:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial">&gt; @@ -1,9 +1,8 @=
@</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:=
arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial">&gt; +// SPDX-License-Identifier: GPL-2.0-or-la=
ter OR MIT</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);fon=
t-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial">&gt;=C2=A0 /*</div><div class=3D"gmail=
_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
">&gt;=C2=A0 =C2=A0* Broadcom Northstar NAND.</div><div class=3D"gmail_extr=
a" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:smal=
l;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;=
font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text=
-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(25=
5,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt=
;=C2=A0 =C2=A0*</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial">&gt;=C2=A0 =C2=A0* Copyright (C) =
2015 Hauke Mehrtens &lt;<a href=3D"mailto:hauke@hauke-m.de">hauke@hauke-m.d=
e</a>&gt;</div><div class=3D"gmail_extra" style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial">&gt; - *</div><div class=3D"gmail_extra=
" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial">&gt;=
 - * Licensed under the GNU/GPL. See COPYING for details.</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial">&gt;=C2=A0 =C2=A0*/</div><div class=3D"gmail_extra" style=3D"col=
or:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:no=
rmal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial">&gt;</div><div cla=
ss=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-seri=
f;font-size:small;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial">&gt;=C2=A0 / {</div><div class=3D"gmail_extra" style=3D"color:=
rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-de=
coration-style:initial;text-decoration-color:initial">&gt;</div><div class=
=3D"gmail_extra" style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial"><br></div></div>

--0000000000009904f1056b3f15c7--
