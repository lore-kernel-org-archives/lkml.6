Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OxbuGrGJHlsrQAAAmS7hNA
	; Mon, 11 Jun 2018 14:39:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6182D607BB; Mon, 11 Jun 2018 14:39:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EB87D60351;
	Mon, 11 Jun 2018 14:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB87D60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754037AbeFKOjm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:39:42 -0400
Received: from mleia.com ([178.79.152.223]:51126 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753893AbeFKOjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:39:41 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 05EC990CB4;
        Mon, 11 Jun 2018 15:39:40 +0100 (BST)
Subject: Re: [PATCH v6 0/5] Reintroduce i.MX EPIT Timer
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
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <74959a6a-60bb-f854-6ef2-21c3c60d3451@mleia.com>
Date: Mon, 11 Jun 2018 17:39:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180607140544.22268-1-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180611_153940_054640_596AA8DD 
X-CRM114-Status: UNSURE (   8.49  )
X-CRM114-Notice: Please train this message. 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

On 06/07/2018 05:05 PM, Clément Péron wrote:
> From: Clément Peron <clement.peron@devialet.com>
> 
> As suggested in the commit message we have added the device tree support,
> proper bindings and we moved the driver into the correct folder.
> 
> Moreover we made some changes like use of relaxed IO accesor,
> implement sched_clock, delay_timer and reduce the clockevents min_delta.
> 

I reviewed and tested the driver on i.MX31, as expected it works fine,
and I'll give my tags per a commit, please add them to v7 changes.

--
Best wishes,
Vladimir
