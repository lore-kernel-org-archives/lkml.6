Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971643AbeCSVgB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969702AbeCSVfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:35:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C707B21737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Jeffy Chen <jeffy.chen@rock-chips.com>, alexandre.belloni@bootlin.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180319035854.3265-1-jeffy.chen@rock-chips.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20180319035854.3265-1-jeffy.chen@rock-chips.com>
Message-ID: <152149531811.242365.11094328182208620465@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6] clk: lpc32xx: Set name of regmap_config
Date: Mon, 19 Mar 2018 14:35:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffy Chen (2018-03-18 20:58:54)
> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Acked-by: Vladimir Zapolskiy <vz@mleia.com>
> ---

Applied to clk-next
