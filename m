Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09270C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D625520842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfBYMNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:13:35 -0500
Received: from mx.socionext.com ([202.248.49.38]:8140 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfBYMNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:13:34 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Feb 2019 21:13:33 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 8D1DD18021D;
        Mon, 25 Feb 2019 21:13:33 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 25 Feb 2019 21:13:33 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id ECAFE403C2;
        Mon, 25 Feb 2019 21:13:32 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id D4B2B121B6C;
        Mon, 25 Feb 2019 21:13:32 +0900 (JST)
Subject: Re: [PATCH v3 7/9] dt-bindings: serial: Add Milbeaut serial driver
 description
To:     Rob Herring <robh@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1550648677-11164-1-git-send-email-sugaya.taichi@socionext.com>
 <20190222183812.GA20616@bogus>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <884ac72f-f8d2-900e-0503-a8e17f5e2143@socionext.com>
Date:   Mon, 25 Feb 2019 21:13:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190222183812.GA20616@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2019/02/23 3:38, Rob Herring wrote:
> On Wed, 20 Feb 2019 16:44:37 +0900, Sugaya Taichi wrote:
>> Add DT bindings document for Milbeaut serial driver.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thank you!

