Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754710AbeBGQuJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:50:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52576 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754538AbeBGQuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:50:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2AC1360209
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Wed, 7 Feb 2018 16:50:05 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings/interrupt-controller: pdc: descibe
 PDC device binding
Message-ID: <20180207165005.GB16153@codeaurora.org>
References: <20180207154958.13421-1-ilina@codeaurora.org>
 <20180207154958.13421-3-ilina@codeaurora.org>
 <20180207164324.GP9465@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180207164324.GP9465@builder>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07 2018 at 16:43 +0000, Bjorn Andersson wrote:
>On Wed 07 Feb 07:49 PST 2018, Lina Iyer wrote:
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
>[..]
>> +Example:
>[..]
>> +	wake-device {
>> +		[...]
>> +		interrupt-controller = <&pdc>;
>
>Sorry for not seeing this earlier, but this should be:
>
>		interrupt-parent = <&pdc>;
>
Thats right. Thanks for pointing out.

>Or as it's not unlikely that clients might use a mix of pdc and non-pdc
>interrupts the example could use the form:
>
>		interrupts-extended = <&pdc 2 IRQ_TYPE_LEVEL_HIGH>;
>
OK. Will add it as another example.

>> +		interrupt = <2 IRQ_TYPE_LEVEL_HIGH>;
>> +	};
>
Thanks,
Lina
