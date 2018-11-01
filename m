Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A08C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A7B20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A7B20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeKARU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:20:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:55863 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeKARUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:20:55 -0400
Received: from [192.168.178.52] ([109.104.44.235]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MjjGV-1fp5pg2ymh-00lDlM; Thu, 01 Nov 2018 09:18:35 +0100
Received: from [192.168.178.52] ([109.104.44.235]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MjjGV-1fp5pg2ymh-00lDlM; Thu, 01 Nov 2018 09:18:35 +0100
Subject: Re: [PATCH] pinctrl: bcm2835: Use define directive for
 BCM2835_PINCONF_PARAM_PULL
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20181101004653.7552-1-natechancellor@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <4619d04e-3f17-f1d8-2cca-a9b62f063d75@i2se.com>
Date:   Thu, 1 Nov 2018 09:18:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181101004653.7552-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:0XryzxZInnGOdhDTgdmrj/jwdSEcY2efwlwvsdI0nYExYmEF/pO
 CGDsK9RPo5TnbDZaf3wasrCqE8Z8YVFlp2EOiEQEw7EURo4IWtWzaBSHQ5d3DYt18tnCldz
 MCOi69jO63k4CXsB29V3nfVDjPxhuKuf48nzhJ2F/GJp9u5Y1/WfTjC3PlBZNYO28bhCJOW
 UU56+143syn9Z+bL/Lfsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X7eWaRVH0L0=:pJ5AULNYDHyP/wtlOpEhUq
 7Hr8x+rZOWedn/pJLBVf4XChfY4uot5HyxOkdKQGMqK42STAN6ajnFxYnmGhWzzCaGry/FUlH
 7PHataT9qhm5UkTGXg09ui5zm84Mo1hhomm0shDEq9YEsX1OOGaoVePPxvHTzKW/xUX16zc2L
 ufgap63dUpruSR1/m1mcaX3/DptCOr2ry8bfUZDaqBDCf345UeSjkdruk6P7TgBkbu6lIILIV
 5+i5cTMyiimo3+E+1on6sm8kcMmZbhVGGED1+BhcKihQuGsYzHPxlWyHwl2WO6xqGWdyDMI/C
 q9La4iurDwH0WEL/fAINvzBMMY9mYCDagfYLwqisnj4O/lElDGIoZx8qkSYsvVy2uTVpFzI5o
 QieNZHUWpqyevpAmR0+iUwq7Ge0oz03txkFsyhnNEwZ7j/5Vh0vjie/YaagCGNrBchLiEAABJ
 LG0bLwvdvM3rgtbDqCQC6O1E9QMFzmosc4AX8TnptzaYVXc4tcY3PxZILXDfj4kT3t99ALOJ3
 ucsgNvusraonqYitjqXRRM1/Lu25CU51HWaJgqcqfftTudfsWDeScw4uSW6+cJ5evbUbQ/Or3
 f8VQ8X59mwLnso140MgKlYpEVw+8/n2sE5OvV0zZ6MfqikENhPMmnRh0W/6ot+gegKzJNKWkB
 AOpSFXYZ7qlq/FcYNKAYsXdmHQD0lO9Pkrc6lmyhL97i/RIIXtvGkh3jNJNbH3dSNExpSAKID
 oDuOJRV4DDVpo/f5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.11.18 um 01:46 schrieb Nathan Chancellor:
> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/pinctrl/bcm/pinctrl-bcm2835.c:707:40: warning: implicit
> conversion from enumeration type 'enum bcm2835_pinconf_param' to
> different enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         configs[0] = pinconf_to_config_packed(BCM2835_PINCONF_PARAM_PULL, pull);
>                      ~~~~~~~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
>
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>


