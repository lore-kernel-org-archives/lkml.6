Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA44C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BF921908
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbeLXM7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:59:23 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:42844 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeLXM7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:59:22 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBOCwq86075783;
        Mon, 24 Dec 2018 21:58:52 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Mon, 24 Dec 2018 21:58:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.2] (183.38.232.153.ap.dti.ne.jp [153.232.38.183])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBOCwpXv075780
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 24 Dec 2018 21:58:52 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: enable analog audio node for rock64
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181223101026.12998-1-katsuhiro@katsuster.net>
 <16987084.rf60fZEaYD@phil>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <df1c3cb9-5661-724d-4443-5b19930f4348@katsuster.net>
Date:   Mon, 24 Dec 2018 21:58:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <16987084.rf60fZEaYD@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

I understand. Thanks a lot!

Best Regards,
Katsuhiro Suzuki

On 2018/12/24 16:16, Heiko Stuebner wrote:
> Hi,
> 
> Am Sonntag, 23. Dezember 2018, 11:10:26 CET schrieb Katsuhiro Suzuki:
>> The Rock64 boards has analog audio jack on it. RK3328 can output
>> analog audio signal using I2S1 and ACODEC core.
>>
>> This patch adds sound node for analog audio for Rock64.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> I've put a patch collecting the sound-dai-cells in rk3328.dtsi
> before this one, dropped the sound-dai-cells from here and
> applied the patch for 4.22.
> 
> Thanks
> Heiko
> 
> 
> 

