Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeC0Iku (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:40:50 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34260 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeC0Ikr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:40:47 -0400
X-Google-Smtp-Source: AG47ELvOoCtyW0XhLl6NhIao3/qD7EAMcOJNyacXCG3+ElIQEN2XXrT0q+dmqy9a0HXlyjAG3+mqQw==
Message-ID: <1522140044.2632.19.camel@baylibre.com>
Subject: Re: [PATCH v2 1/7] clk: meson: drop meson_aoclk_gate_regmap_ops
From: Jerome Brunet <jbrunet@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Mar 2018 10:40:44 +0200
In-Reply-To: <20180323143816.200573-2-yixun.lan@amlogic.com>
References: <20180323143816.200573-1-yixun.lan@amlogic.com>
         <20180323143816.200573-2-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-23 at 22:38 +0800, Yixun Lan wrote:
> let's remove the unused meson_aoclk_gate_regmap_ops
> 
> Fixes: 1f932d99710d ("clk: meson: remove superseded aoclk_gate_regmap")
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---

Applied, Thx
