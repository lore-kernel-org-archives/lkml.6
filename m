Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeCTMKZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:10:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeCTMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:10:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Mar 2018 17:40:21 +0530
From: sricharan@codeaurora.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: absahu@codeaurora.org, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, catalin.marinas@arm.com,
        david.brown@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux@armlinux.org.uk, marc.zyngier@arm.com, mark.rutland@arm.com,
        robh+dt@kernel.org, robh@kernel.org, sboyd@codeaurora.org,
        will.deacon@arm.com
Subject: Re: [PATCH v3 06/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1
 board file
In-Reply-To: <152153125818.254778.5435627269964796441@swboyd.mtv.corp.google.com>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-7-git-send-email-sricharan@codeaurora.org>
 <152153125818.254778.5435627269964796441@swboyd.mtv.corp.google.com>
Message-ID: <a8ec44084bbcf7d6b4e51f195c9d6046@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-20 13:04, Stephen Boyd wrote:
> Quoting Sricharan R (2018-03-19 20:58:49)
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts 
>> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
>> new file mode 100644
>> index 0000000..871ac3f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> +
>> +#include "qcom-ipq4019-ap.dk04.1.dtsi"
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C1";
>> +
>> +       soc {
>> +               qpic_bam: dma@7984000 {
> 
> Why the labels?
> 

   ok, will remove here and few other places to make it uniform.

Regards,
  Sricharan

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
