Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7ub3JJOJHlvQSQAAmS7hNA
	; Mon, 11 Jun 2018 14:39:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1C2CE607BB; Mon, 11 Jun 2018 14:39:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 97F5660541;
	Mon, 11 Jun 2018 14:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97F5660541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754074AbeFKOjv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:39:51 -0400
Received: from mleia.com ([178.79.152.223]:51170 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753893AbeFKOjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:39:48 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id AC61C90CFB;
        Mon, 11 Jun 2018 15:39:47 +0100 (BST)
Subject: Re: [PATCH v6 2/5] ARM: imx: remove inexistant EPIT timer init
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
 <20180607140544.22268-3-peron.clem@gmail.com>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <11263b41-4f43-9f72-28a4-459e4ccd8bd7@mleia.com>
Date: Mon, 11 Jun 2018 17:39:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180607140544.22268-3-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180611_153947_727472_8A4D1CFB 
X-CRM114-Status: UNSURE (   7.51  )
X-CRM114-Notice: Please train this message. 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 05:05 PM, Clément Péron wrote:
> From: Clément Peron <clement.peron@devialet.com>
> 
> i.MX EPIT timer has been removed but not the init function declaration.
> 
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Tested-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
