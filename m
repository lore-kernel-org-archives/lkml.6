Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970646AbeEXPCZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:02:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970630AbeEXPCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:02:21 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH v12 1/2] cpufreq: Add Kryo CPU scaling driver
To: ilialin@codeaurora.org
References: <1527152242-31281-1-git-send-email-ilialin@codeaurora.org>
 <1527152242-31281-2-git-send-email-ilialin@codeaurora.org>
 <860be68b-cac0-9efc-b3c7-cc75b391a4c3@arm.com>
 <000501d3f35f$96794910$c36bdb30$@codeaurora.org>
 <b4e221af-57f7-fd11-942d-6bc6f6b55a73@arm.com>
 <000701d3f368$fd31e410$f795ac30$@codeaurora.org>
 <15d6025c-1307-64e0-6715-34240fcaf8eb@arm.com>
 <000901d3f36e$c9c995e0$5d5cc1a0$@codeaurora.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <bf3662ca-3278-e218-2116-61d3583cf016@arm.com>
Date: Thu, 24 May 2018 16:02:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <000901d3f36e$c9c995e0$5d5cc1a0$@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/05/18 15:52, ilialin@codeaurora.org wrote:
> OK, got you.
> Is "operating-points-v2-kryo-cpu" good enough?
> 

Not sure if I can answer that as I don't have full knowledge on PM on
all Kryo CPUs. Will this driver work on all those platforms which will
have "operating-points-v2-kryo-cpu" ? If yes, then go ahead.

I would prefer using some compatible in the CPU node rather that OPP,
but that's just my opinion. Check with other QCOM guys on the list who
have worked on CPUFreq or still working.(Taniya, Saravana, S Boyd, ...?)

-- 
Regards,
Sudeep
