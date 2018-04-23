Return-Path: <Yixun.Lan@amlogic.com>
X-Google-Smtp-Source: AIpwx4/oa+WVGowRLyO8gmOhkvSsqJ5rCqUwbocjFEz5Bm7hetelJX8C7zddUFjr7+HxGQVCACd9
ARC-Seal: i=1; a=rsa-sha256; t=1524468088; cv=none;
        d=google.com; s=arc-20160816;
        b=gcseKxqVls+6ioAiBAyC8w2Gwa50JUvNdsVU+O5qF7/8SiDCiS66RpbljSE59FsvWn
         wUVVL53e/z3G809AvJhHh7g+hsAVndgmujRtQ63Q8eJWG2wjZ/x85/2DRqCfFIsfmuo/
         te5KD4Y67ijtOEZh61VGGxNTY4BxSCDoUxikKOc2fIlnXjqG77kZw9irHeUUVwCFYt3q
         L/YW/VImcto1dzDOiTuvrMDPA7j6+gi3wVl2FuP+K6e778FxoDk/HqrwaEsOyRccqiRD
         aQqbCBjD+sfw6k7tDW7ML/V3/6+eqfjbEXDGArsIynit0yYEfAUuwUrd8MEkOcH7JurI
         1eFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=4uDOyy+CC/nWdfT1nHcoRNZ9KyoJuBvuuhT58n9zETQ=;
        b=Qwr9kYlAjWkrgpBI8UDmSmhbKjK4zyKuQLAGADalAW95y4SfgmN4CC4YLyT4Mc20uH
         zNWnJc3FGDuIidk9KJUDyN2G1P1wMIBDOjoW1lW97eigydgwW0wvOQMisuuXhEQe5+Gd
         /tqf/HahWQLZXi7lNWy9m6dSzZH99kISy3ZxUMKblTHEN2fVLqRKrJNQ/9gsz/ah87Zi
         AYVM1rUlBOQUaCr9Ocmg/6ghxiVECZUUdLA6NBNm3SYvRm1FDIeBqVLtHD38R17Wc50z
         Nib0wouH2Vl7XphByOVqhasSUTiB09yOOXqbKRz0y5VAlzmnh6d1dZovoV7nIc2Y5/8e
         u4Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yixun.lan@amlogic.com designates 58.32.228.45 as permitted sender) smtp.mailfrom=Yixun.Lan@amlogic.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yixun.lan@amlogic.com designates 58.32.228.45 as permitted sender) smtp.mailfrom=Yixun.Lan@amlogic.com
Subject: Re: dt-bindings: Invalid SPDX License Identifier
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <alpine.DEB.2.21.1804222108120.6136@nanos.tec.linutronix.de>
CC: <yixun.lan@amlogic.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, linux-amlogic
	<linux-amlogic@lists.infradead.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <795a50ff-d627-bcd5-950f-71e98016707e@amlogic.com>
Date: Mon, 23 Apr 2018 15:21:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804222108120.6136@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598474920059002037?=
X-GMAIL-MSGID: =?utf-8?q?1598520650937605216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Thomas

On 04/23/18 03:14, Thomas Gleixner wrote:
> Yixun,
> 
> commit c16292578ffa437c77e17d5d3da20330a10b8a86
> Author: Yixun Lan <yixun.lan@amlogic.com>
> Date:   Fri Nov 10 16:46:49 2017 +0800
> 
>     dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller
>     
>     Add DT bindings for the Meson-AXG SoC Reset Controller include file,
>     and also slightly update documentation.
>     
>     Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>     Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>     Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Added the following SPDX-License-Identifier: (GPL-2.0+ OR BSD) in the
> middle of the top of file comment.
> 
> There are two problems with that:
> 
> 1) BSD is not a valid SPDX identifier. See https://spdx.org/licenses/
> 
>    You need to say which BSD variant you mean.
> 
> 2) Please put the License identifier to the place which is defined in
>    Documentation/process/licenses.rst, i.e. the first line of the dts file
>    and not to some random place.
> 

thanks for pointing this out

I will adjust the license to "GPL-2.0+ OR BSD-3-Clause" since this file
was copied from include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
and it's a good idea to preserve the old license.

Yixun
