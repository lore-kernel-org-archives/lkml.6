Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeFBGRi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbeFBGRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:17:35 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1527765086-19873-9-git-send-email-xieyisheng1@huawei.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Eric Anholt <eric@anholt.net>, andy.shevchenko@gmail.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-9-git-send-email-xieyisheng1@huawei.com>
Message-ID: <152792025405.225090.5224138914235298506@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 08/21] clk: bcm2835: use match_string() helper
Date: Fri, 01 Jun 2018 23:17:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w526HiwL003924

Quoting Yisheng Xie (2018-05-31 04:11:13)
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---

Applied to clk-next
