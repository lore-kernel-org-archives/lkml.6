Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeEPPOS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:14:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45698 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeEPPOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:14:16 -0400
X-Google-Smtp-Source: AB8JxZr/KKlvJgZfkF1w1piVNnp0ZrmRTm2ohMwR8fzC5lDlfUacWFmV7kSONc6mt280kK6Os8oG5Q==
Message-ID: <1526483653.2897.62.camel@baylibre.com>
Subject: Re: [PATCH v2] clk: meson: use SPDX license identifiers consistently
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 May 2018 17:14:13 +0200
In-Reply-To: <152648298576.210890.18097934570675275263@swboyd.mtv.corp.google.com>
References: <20180516085040.6771-1-jbrunet@baylibre.com>
         <152648298576.210890.18097934570675275263@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-16 at 08:03 -0700, Stephen Boyd wrote:
> Quoting Jerome Brunet (2018-05-16 01:50:40)
> > Replace every license notices in drivers/clk/meson by SPDX license
> > identifiers, as described in license-rules.rst
> > 
> > Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> 
> I take it this will come through a PR? Otherwise I can apply it to
> clk-meson branch.

We may have a few other patches coming this week. I was planning on making
another PR sometime next week, if this is OK with you.
