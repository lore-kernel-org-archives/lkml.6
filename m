Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeEOUl7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbeEOUl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:41:57 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Chanwoo Choi <cw00.choi@samsung.com>, David Airlie <airlied@linux.ie>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180514211610.26618-8-enric.balletbo@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Lin Huang <hl@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
 <20180514211610.26618-8-enric.balletbo@collabora.com>
Message-ID: <152641691632.237094.11483387696003404182@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH 07/10] clk: rockchip: set clk-ddr to GET_RATE_NOCACHE.
Date: Tue, 15 May 2018 13:41:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FKg4Ek021717

Quoting Enric Balletbo i Serra (2018-05-14 14:16:07)
> From: Derek Basehore <dbasehore@chromium.org>
> 
> This adds the flag to the clk-ddr in rockchip to not use the cached
> rate for get_rate. This is to handle timeout error conditions in SMC
> for the set rate function.

We need some more information here. Why does timeout error condition in
set_rate() matter for get_rate()?
