Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeDZGxq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:53:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60258 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752018AbeDZGxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:53:43 -0400
X-UUID: b16aa31a20be4dbfb0c105cdf96bb694-20180426
Message-ID: <1524725617.31521.0.camel@mhfsdcap03>
Subject: Re: [GIT PULL] Immutable branch between MFD, Input and RTC due for
 the v4.18 merge window
From: Chen Zhong <chen.zhong@mediatek.com>
To: Lee Jones <lee.jones@linaro.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Eddie Huang" <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linus Walleij <linus.walleij@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-rtc@vger.kernel.org>
Date: Thu, 26 Apr 2018 14:53:37 +0800
In-Reply-To: <20180416141809.34l2ofmeljqvyicm@dell>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
         <20180416141809.34l2ofmeljqvyicm@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-16 at 15:18 +0100, Lee Jones wrote:
> Enjoy!
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-rtc-v4.18
> 
> for you to fetch changes up to 55d1d1547ab5e52269988af5e7c553796ff68e97:
> 
>   mfd: mt6397: Add PMIC keys support to MT6397 driver (2018-04-16 15:16:11 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD, Input and RTC due for the v4.18 merge window
> 
> ----------------------------------------------------------------
> Chen Zhong (5):
>       mfd: mt6397: Create irq mappings in mfd core driver
>       dt-bindings: input: Add document bindings for mtk-pmic-keys
>       dt-bindings: mfd: Add bindings for the keys as subnode of PMIC
>       input: Add MediaTek PMIC keys support
>       mfd: mt6397: Add PMIC keys support to MT6397 driver
> 
>  .../devicetree/bindings/input/mtk-pmic-keys.txt    |  43 +++
>  Documentation/devicetree/bindings/mfd/mt6397.txt   |   6 +
>  drivers/input/keyboard/Kconfig                     |   9 +
>  drivers/input/keyboard/Makefile                    |   1 +
>  drivers/input/keyboard/mtk-pmic-keys.c             | 339 +++++++++++++++++++++
>  drivers/mfd/mt6397-core.c                          |  26 +-
>  drivers/rtc/rtc-mt6397.c                           |   7 +-
>  7 files changed, 424 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
>  create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c
> 

Hi Lee,

I’m sorry that I found this patch
https://patchwork.kernel.org/patch/10026705/

is missing in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
ib-mfd-input-rtc-v4.18

Could you please take this patch up?

Thanks.

Best regards,
Chen Zhong
