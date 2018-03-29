Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeC2QP6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:15:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33118 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeC2QPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:15:54 -0400
X-Google-Smtp-Source: AIpwx4/kzmalUhoUt1A11JDVafLjNIwlLIFLVPw3/yMh99dpSZy5V32X9YHWlyA/JxMUmE7QSPYFOA==
Date: Thu, 29 Mar 2018 09:15:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Chen Zhong <chen.zhong@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linus Walleij <linus.walleij@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v6 2/6] dt-bindings: input: Add common keyboard document
 bindings
Message-ID: <20180329161551.GB107392@dtor-ws>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
 <1508937364-30054-3-git-send-email-chen.zhong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508937364-30054-3-git-send-email-chen.zhong@mediatek.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2017 at 09:16:00PM +0800, Chen Zhong wrote:
> This patch adds the device tree binding documentation for common
> keyboard.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  Documentation/devicetree/bindings/input/keys.txt |    8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/keys.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/keys.txt b/Documentation/devicetree/bindings/input/keys.txt
> new file mode 100644
> index 0000000..a0ea7eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/keys.txt
> @@ -0,0 +1,8 @@
> +General Keys Properties:
> +
> +Optional properties for Keys:
> +- power-off-time-sec: Duration in seconds which the key should be kept
> + 	pressed for device to power off automatically. Device with key pressed
> + 	shutdown feature can specify this property.
> +- linux,keycodes: Specifies the numeric keycode values to be used for
> +	reporting key presses.
> \ No newline at end of file
> -- 
> 1.7.9.5
> 

-- 
Dmitry
