Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeDPQY5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751070AbeDPQYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:24:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339032175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180409135921.5617-1-jbrunet@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
References: <20180409135921.5617-1-jbrunet@baylibre.com>
Message-ID: <152389589448.51482.15489333464741262913@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/2] clk: honor CLK_MUX_ROUND_CLOSEST in mux
Date: Mon, 16 Apr 2018 09:24:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-04-09 06:59:19)
> CLK_MUX_ROUND_CLOSEST is part of clk_mux and meson's clk_regmap
> documentation, so it should be honored by the determine_rate() callback.
> 
> It is note the case ATM. The series fixes this problem.

I'll apply these for clk-fixes.
