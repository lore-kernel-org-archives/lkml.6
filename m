Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeCZWZM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:25:12 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34745 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeCZWZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:25:08 -0400
X-Google-Smtp-Source: AG47ELv9fsm8oZKfrATx5RvR3e70UxtfKsDtVWq1NtdV9eIXwZyknDpJRitpUr7+AI6a1V4rfeDoEw==
Date: Mon, 26 Mar 2018 17:25:06 -0500
From: Rob Herring <robh@kernel.org>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/7] dt-bindings: clock: reset: Add AXG AO Clock and
 Reset Bindings
Message-ID: <20180326222506.jkn5i7eyto3li3ws@rob-hp-laptop>
References: <20180323143816.200573-1-yixun.lan@amlogic.com>
 <20180323143816.200573-5-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323143816.200573-5-yixun.lan@amlogic.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 10:38:13PM +0800, Yixun Lan wrote:
> Add dt-bindings headers for the Meson-AXG's AO clock and
> reset controller.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  include/dt-bindings/clock/axg-aoclkc.h | 26 ++++++++++++++++++++++++++
>  include/dt-bindings/reset/axg-aoclkc.h | 20 ++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
>  create mode 100644 include/dt-bindings/reset/axg-aoclkc.h

Reviewed-by: Rob Herring <robh@kernel.org>
