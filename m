Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbeBTPmK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:42:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeBTPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:42:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69228605FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 20 Feb 2018 15:42:05 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Rob Herring <robh@kernel.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, sboyd@codeaurora.org,
        rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Message-ID: <20180220154205.GC28504@codeaurora.org>
References: <20180216224614.24037-1-ilina@codeaurora.org>
 <20180216224614.24037-3-ilina@codeaurora.org>
 <20180219203106.mfzmxy42biwo33qj@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180219203106.mfzmxy42biwo33qj@rob-hp-laptop>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19 2018 at 20:31 +0000, Rob Herring wrote:
>On Fri, Feb 16, 2018 at 03:46:14PM -0700, Lina Iyer wrote:
>> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>>
>> +The devicetree representation of the command DB driver should be:
>
>Need to state this is a child of /reserved-memory
Yes, ofcourse. Will fix.

>
>> +
>> +PROPERTIES:
>
>Why the yelling? :)
>
Oops.

>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: Should be "qcom,cmd-db"
>
>reg?
>
Yes.

Thanks Rob for the reveiw.
-- Lina
