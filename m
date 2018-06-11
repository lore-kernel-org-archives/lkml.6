Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ecnkEWyJHlvfSQAAmS7hNA
	; Mon, 11 Jun 2018 14:40:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 849F360850; Mon, 11 Jun 2018 14:40:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B6EB3608B8;
	Mon, 11 Jun 2018 14:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6EB3608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932562AbeFKOkH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:40:07 -0400
Received: from mleia.com ([178.79.152.223]:51210 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932439AbeFKOkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:40:05 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 0C1C890CFF;
        Mon, 11 Jun 2018 15:40:04 +0100 (BST)
Subject: Re: [PATCH v6 4/5] clocksource: add driver for i.MX EPIT timer
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>
References: <20180607140544.22268-1-peron.clem@gmail.com>
 <20180607140544.22268-5-peron.clem@gmail.com>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <27c914a5-22b2-1f64-dc89-4ecee5bff2b9@mleia.com>
Date: Mon, 11 Jun 2018 17:40:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180607140544.22268-5-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180611_154004_081972_96036B82 
X-CRM114-Status: GOOD (  11.09  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 05:05 PM, Clément Péron wrote:
> From: Colin Didier <colin.didier@devialet.com>
> 
> Add driver for NXP's EPIT timer used in i.MX SoC.
> 
> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> Signed-off-by: Clément Peron <clement.peron@devialet.com>

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Tested-by: Vladimir Zapolskiy <vz@mleia.com>

I tested the driver on i.MX31 only, and I didn't find any problems.

Please fix the indentation issue found by Stefan in v7.

Regarding utilization of timer-of.c it can be postponed IMHO,
but it's up to clocksource maintainers and you to decide, and if
you do such an update for v7, then please don't add my tags,
I'll review and test it again.

--
With best wishes,
Vladimir
