Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeDFSXG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbeDFSXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:23:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9911920B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180320083323.23289-1-nikita.yoush@cogentembedded.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
References: <20180320083323.23289-1-nikita.yoush@cogentembedded.com>
Message-ID: <152303898290.143116.8216108906293639953@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: cs2000: set pm_ops in hibernate-compatible way
Date: Fri, 06 Apr 2018 11:23:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nikita Yushchenko (2018-03-20 01:33:23)
> Use SET_LATE_SYSTEM_SLEEP_PM_OPS() macro instead of direct assignment to
> .resume_early field.
> 
> This fixes initialization of CS2000 in restore from hibernation in case
> of kernel used to load image did not initialize CS2000 while kernel
> being restored had CS2000 initialized.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---

Applied to clk-next
