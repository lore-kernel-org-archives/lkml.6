Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9167C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F79820863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBKKqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:46:17 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:37535 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKKqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:46:16 -0500
Received: from [192.168.1.110] ([95.117.94.93]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQgtC-1ghVpc0418-00Ng7Y; Mon, 11 Feb 2019 11:46:10 +0100
Subject: Re: [PATCH 1/2] x86: gpio: AMD G-Series pch gpio platform driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
References: <1549588593-4856-1-git-send-email-lkml@metux.net>
 <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <f751539b-d844-9ab1-169b-ce6aa0056de6@metux.net>
Date:   Mon, 11 Feb 2019 11:46:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IrT7+WxouvTj5l2lbq+SHn30x4X5EALYHZs9zNbmNPhfNPpjZbS
 35fc/eEW/8D6Mif+wXFMHCbH3Qjhi8nj2xQwQwUxNZgU2BNHfRcbTBa5Tddbt5wARYD3Tsz
 d77FN6rgwhputl0wQ/ZxGeDTbS9SQsx61ILl0L0DpbD1PRbG7DtxuWUFSkZGcNAK0u+Pz7b
 B9h30y4j+gy/F1V9TZ9Cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WeKBZmzXCUE=:vz7xVFXOTEAlduR8qmtFQR
 cTykfSXvYdaiyyW8B6/0AzmnD13aOw/etrl8CYDjpds/a97xrwetaOzGTEaZlZY6BsGtr1msA
 0IIa6qtWQpdsusRW9Io4opiikXzvNz8F6uyfORrljq+pck8tYZzAWUq1BjTQAVzi0ZpHdMIyn
 zu20i28SwA4FUsnys0+16IJb3LLVZ3mDzJJa8L5WB5guYSRp50ZHLVzciq8cg4H9LJwaHy1nL
 ux83Vmz6iRduB2sPFxcD5c5N4TJuLussyHMnrV1zTrtq/lSCwk2tWIWHNE1tUH9E1gcK6M4p0
 j2ltCjzsKdzE44ptVVfyX2XklH8ibEUuZ58suRDddqu25F2KpypJyzdv8U7QdG8oJUoCj5tLp
 Jiql8b8ppOncCJe1zfNkAv5ru/DRlIUHZVMF7MS03RYh5GzHDlR+2iEoLydiYg5IOBJTd4eCS
 H2qF8sZF/iijAHgvxVx13phLG8J5rsd0m31xHLMz9kJdKMzJUsddT6DI6rQfpqtTQx7wpPJou
 aqeNQERyRn1Wn3u8cMW+l18XLe40fU0VACLPfiicsDnTBAzkq314eVkYEXY64jE5CaGOyyTH8
 r39JcUGWFFuNIFEwJ4mfoPUs7UNAzCOvdSw5i6SLZBOz4e9lTGriOIbHhM4I02ZhPj/5ReTtO
 q362OeRZrZDA4mcQmL7mXzbbSdkCwSSdtQwDw8yDTN5PisCWtlpSPtxvGSKgoE5gxy4ucmFjE
 gpS9uvnk1pBHQNtqRIB5JoEW50SEAmxhsG+6eCzsiLXWXuJX0tv5e4/V9EY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.19 15:25, Linus Walleij wrote:

Hi,

<snip>

>> +/*>> + * struct amd_fch_gpio_reg - GPIO register definition>> + * @reg:
register index>> + * @name: signal name>> + */>> +struct
amd_fch_gpio_reg {>> +    int         reg;>> +    const char* name;>>
+};> > Can't you put this in the driver file?
I'm afraid, I can't. Because the board driver needs to tell the
gpio driver which gpio's we actually have. This seems to be really
board specific, and the register layout of the FCHs gpio bank seems
to be not actually linear (or maybe the pin naming is just weird)

What I really don't want is undocumented registers or lines being
exposed as gpio somewhere (not knowing what they actually do).
Therefore, I'd like to add only those gpio registers that I can
confirm being safe - at least until I've managed to get more
information.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
