Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A8DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED58206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED58206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeIDLut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:50:49 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42897 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeIDLut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:50:49 -0400
Received: from [192.168.178.69] ([109.104.51.230]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0M5gZk-1fhtEA3LZY-00xcUc; Tue, 04 Sep 2018 09:26:50 +0200
Subject: Re: [PATCH 3/4 next] net: lan78xx: Switch to SPDX identifier
To:     RaghuramChary.Jallipalli@microchip.com, Woojung.Huh@microchip.com
Cc:     UNGLinuxDriver@microchip.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
 <1535994759-8938-4-git-send-email-stefan.wahren@i2se.com>
 <0573C9D4B793EF43BF95221F2F4CC8515912C3@CHN-SV-EXMX06.mchp-main.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <21c3f5d9-c884-3c78-6441-dbfd47001ffe@i2se.com>
Date:   Tue, 4 Sep 2018 09:26:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0573C9D4B793EF43BF95221F2F4CC8515912C3@CHN-SV-EXMX06.mchp-main.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:zofeaWntMl2hw1AUzx4rCfEPfpuO7Z2dKaiEyFvXehQ8YPyNHRh
 XTQJUaXatelBZJx5KX21DaYVd5JThs0cP5mZai+GOYyE33EL9x8qg2cZ6Q5K5zXXfYLN81I
 6TfMFGBhhW62dgtXHgca1KEHab2IBIx5tJbBTuVMBs7ayX+y++0beeic7i1ZHowMhqdTi9B
 fnT8tGOt4HHTXzs9zzZJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:541SBWQtZb8=:rgVdNqjEYFjGESodd8fuLu
 LVr/GZFtkogrgOz4HB9fJGWh6U93ttZVTNbmluVLo1TgsoMo5erOqQhO7vZqowoulq5lTBqIK
 MG+n6HBi1DYxkVX890PILx666DPWG9xFjI842XwuagVgFIWuv8YVyPj3V/T1AQ14TCs8pWZNY
 NR6y1buwhPOM4Fpc2puRFe5HjhcqCC8Hmk+Nys0xAa06lRct9btVM9XKbBu5bEJ3q4hRff0nI
 L6cy9yialoY/g4L5ROqXmDKtac+SAqmB/IfkLerZsetBYdc0fzir6eg8ZRG47mF6sOwGdAg5o
 vttCtLbRC/Saeqy62XRGXAB4IIiIJBpon0E6abyTGiXQEwCNG19zkcKz0yqJyHw/NQC+FgJgW
 R/JTB+dLkBucIS/u4x/fCON7mAMSVtwd+izI9WFOkYSiaz/jC5MZeUgG/GLh6hFcUYzafPShc
 bJhhGXw3H1vTSjiaYG98WWogD5pse/VLujkYcwc3mVNiQLpOvvh0e7ZrJLWniAu8N+2TezyA9
 JvK5znctDZZe20TF8k0RE3S7AUfu/J3DFtitCB+VbEnINgInv97ZYT1lMGdH3OXemwVs6aoiU
 teASoROQ4GPKsFRUVXG1Rd6TXSpFCT9DrGrAIiuyNOmr3kp8Kvww3zy7+mm4bnbGyFcyREoMS
 c8wl/bC6AQyXT/Ibko0p7vsdNDsvBTdvdRsKIms/Wp/HW/o64itehwgXg1nw2r3N31wrjdeh2
 4f3vihlDy0iTr2vl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raghu,


Am 04.09.2018 um 06:29 schrieb RaghuramChary.Jallipalli@microchip.com:
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/* Copyright (C) 2015 Microchip Technology */
> Can we merge both in single comment line?

i don't think we can do this. I'm simply following this guideline [1].

How about this:

// SPDX-License-Identifier: GPL-2.0+
/*
 * Copyright (C) 2015 Microchip Technology
 */

[1] - https://www.kernel.org/doc/html/v4.18/process/license-rules.html

>
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/* Copyright (C) 2015 Microchip Technology */
> Here too.
>
> Thanks,
> -Raghu

