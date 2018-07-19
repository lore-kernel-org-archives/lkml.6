Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EF6C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A61320693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A61320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeGSJon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:44:43 -0400
Received: from mx.socionext.com ([202.248.49.38]:38413 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbeGSJon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:44:43 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Jul 2018 18:02:32 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id D8CA2180D69;
        Thu, 19 Jul 2018 18:02:32 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 19 Jul 2018 18:02:32 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 6A80740399;
        Thu, 19 Jul 2018 18:02:32 +0900 (JST)
Received: from DESKTOP0FARE34 (unknown [10.213.134.218])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 3427C120448;
        Thu, 19 Jul 2018 18:02:32 +0900 (JST)
From:   "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To:     "'kbuild test robot'" <lkp@intel.com>
Cc:     <kbuild-all@01.org>, <linus.walleij@linaro.org>,
        =?iso-2022-jp?B?WWFtYWRhLCBNYXNhaGlyby8bJEI7M0VEGyhCIBskQj8/OTAbKEI=?= 
        <yamada.masahiro@socionext.com>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <masami.hiramatsu@linaro.org>, <jaswinder.singh@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        =?iso-2022-jp?B?SGF5YXNoaSwgS3VuaWhpa28vGyRCTlMbKEIgGyRCSy5JJxsoQg==?= 
        <hayashi.kunihiko@socionext.com>,
        =?iso-2022-jp?B?SGF5YXNoaWJhcmEsIEtlaWppLxskQk5TODYbKEIgGyRCNzxGcxsoQg==?= 
        <hayashibara.keiji@socionext.com>
References: <1531981249-26329-1-git-send-email-hayashibara.keiji@socionext.com> <201807191518.CFD3QbbB%fengguang.wu@intel.com>
In-Reply-To: <201807191518.CFD3QbbB%fengguang.wu@intel.com>
Subject: RE: [PATCH] pinctrl: uniphier: add spi pin-mux settings
Date:   Thu, 19 Jul 2018 18:02:28 +0900
Message-ID: <000001d41f3f$38818500$a9848f00$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHUHyi8Jz7/kamrU0SFVRTi9as75KSVmFQAgACmHGA=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry.
I will fix this and send v2 patch.

Thank you.

Best Regards,
Keiji Hayashibara

> -----Original Message-----
> From: kbuild test robot [mailto:lkp@intel.com]
> Sent: Thursday, July 19, 2018 5:02 PM
> To: Hayashibara, Keiji/林原 啓二 <hayashibara.keiji@socionext.com>
> Cc: kbuild-all@01.org; linus.walleij@linaro.org; Yamada, Masahiro/山田 真弘 <yamada.masahiro@socionext.com>;
> linux-gpio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; masami.hiramatsu@linaro.org;
> jaswinder.singh@linaro.org; linux-kernel@vger.kernel.org; Hayashibara, Keiji/林原 啓二
> <hayashibara.keiji@socionext.com>; Hayashi, Kunihiko/林 邦彦 <hayashi.kunihiko@socionext.com>
> Subject: Re: [PATCH] pinctrl: uniphier: add spi pin-mux settings
>
> Hi Kunihiko,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on pinctrl/devel] [also build test WARNING on v4.18-rc5 next-20180718] [if your patch
> is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:
> https://github.com/0day-ci/linux/commits/Keiji-Hayashibara/pinctrl-uniphier-add-spi-pin-mux-settings/2018071
> 9-144943
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
> config: mips-allyesconfig (attached as .config)
> compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=mips
>
> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c:21:0:
>    drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c:629:27: error: 'spi0_groups' undeclared here (not in a
> function); did you mean 'spi_groups'?
>      UNIPHIER_PINMUX_FUNCTION(spi0),
>                               ^
>    drivers/pinctrl/uniphier/pinctrl-uniphier.h:188:13: note: in definition of macro 'UNIPHIER_PINMUX_FUNCTION'
>       .groups = func##_groups,    \
>                 ^~~~
>    In file included from include/linux/kernel.h:15:0,
>                     from drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c:16:
>    include/linux/build_bug.h:29:45: error: bit-field '<anonymous>' width not an integer constant
>     #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
>                                                 ^
>    include/linux/compiler-gcc.h:65:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>     #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>                                ^~~~~~~~~~~~~~~~~
>    include/linux/kernel.h:72:59: note: in expansion of macro '__must_be_array'
>     #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>                                                               ^~~~~~~~~~~~~~~
> >> drivers/pinctrl/uniphier/pinctrl-uniphier.h:189:17: note: in expansion of macro 'ARRAY_SIZE'
>       .num_groups = ARRAY_SIZE(func##_groups),  \
>                     ^~~~~~~~~~
> >> drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c:629:2: note: in expansion of macro
> 'UNIPHIER_PINMUX_FUNCTION'
>      UNIPHIER_PINMUX_FUNCTION(spi0),
>      ^~~~~~~~~~~~~~~~~~~~~~~~
>
> vim +/UNIPHIER_PINMUX_FUNCTION +629 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
>
>    618
>    619	static const struct uniphier_pinmux_function uniphier_sld8_functions[] = {
>    620		UNIPHIER_PINMUX_FUNCTION(emmc),
>    621		UNIPHIER_PINMUX_FUNCTION(ether_mii),
>    622		UNIPHIER_PINMUX_FUNCTION(ether_rmii),
>    623		UNIPHIER_PINMUX_FUNCTION(i2c0),
>    624		UNIPHIER_PINMUX_FUNCTION(i2c1),
>    625		UNIPHIER_PINMUX_FUNCTION(i2c2),
>    626		UNIPHIER_PINMUX_FUNCTION(i2c3),
>    627		UNIPHIER_PINMUX_FUNCTION(nand),
>    628		UNIPHIER_PINMUX_FUNCTION(sd),
>  > 629		UNIPHIER_PINMUX_FUNCTION(spi0),
>    630		UNIPHIER_PINMUX_FUNCTION(system_bus),
>    631		UNIPHIER_PINMUX_FUNCTION(uart0),
>    632		UNIPHIER_PINMUX_FUNCTION(uart1),
>    633		UNIPHIER_PINMUX_FUNCTION(uart2),
>    634		UNIPHIER_PINMUX_FUNCTION(uart3),
>    635		UNIPHIER_PINMUX_FUNCTION(usb0),
>    636		UNIPHIER_PINMUX_FUNCTION(usb1),
>    637		UNIPHIER_PINMUX_FUNCTION(usb2),
>    638	};
>    639
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


