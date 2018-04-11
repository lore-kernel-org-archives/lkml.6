Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeDKKcQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:32:16 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35156 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeDKKcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:32:14 -0400
X-Google-Smtp-Source: AIpwx4/Zp5ot+nA5/RSxrmvPfNboPkd9mUSEib/MA0CXrL5bucoHzR++Zrhctwpng2upCRhMJ9zWng==
Subject: Re: [PATCH] irqchip/gic-v3: Support v2m frame backwards compatibility
 mode
To: Stephen Boyd <sboyd@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-arm-msm@vger.kernel.org,
        Hanna Hawa <hannah@marvell.com>, Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20170320223614.1351-1-sboyd@codeaurora.org>
 <bac1e827-3860-d92c-7bb4-eaf9840c608f@arm.com>
 <20180410170155.6e07113d@windsurf>
 <a4451252-35e4-e63f-8cca-a072f90fa9ad@arm.com>
 <152338426182.180276.1835672071236851795@swboyd.mtv.corp.google.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6e5cc936-8f2e-3b5c-a912-1f7577db8413@linaro.org>
Date: Wed, 11 Apr 2018 11:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <152338426182.180276.1835672071236851795@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/18 19:17, Stephen Boyd wrote:
> Anyway, this is mostly an FYI that I don't have the hardware to test
> with anymore and I'm not going to keep sending patches on this topic.
> Srini should have some hardware to test whatever solution you come up
> with.
Yep, I can test PCI MSI side of it with DragonBoard 820c.

thanks,
srini
