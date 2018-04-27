Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757912AbeD0Jdp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:33:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39367 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbeD0Jdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:33:43 -0400
X-Google-Smtp-Source: AB8JxZpcLZt4VXHGnmYsmcA9v1/+JGmWCvDBVNeU7b6yjJeyLBRPrFWPDJzj+a+G+di1Hyw0YXHgkQ==
Message-ID: <1524821620.4026.113.camel@baylibre.com>
Subject: Re: [PATCH 0/2] clk: meson: mpll: add round closest support
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Fri, 27 Apr 2018 11:33:40 +0200
In-Reply-To: <20180420095603.29964-1-jbrunet@baylibre.com>
References: <20180420095603.29964-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-20 at 11:56 +0200, Jerome Brunet wrote:
> ATM, the mpll driver can only round the requested rate down, even if
> rounding up would have provided a better approximation of the requested
> rate.
> 
> This patchset adds a flag to enable rounding to the closest rate possible,
> even if it means rounding up.
> 
> The flag is then enabled on the axg platform to improve the rates provided
> to the audio subsystem.
> 
> Jerome Brunet (2):
>   clk: meson: mpll: add round closest support
>   clk: meson: axg: let mpll clocks round closest
> 
>  drivers/clk/meson/axg.c      |  4 ++++
>  drivers/clk/meson/clk-mpll.c | 25 ++++++++++++++++++++-----
>  drivers/clk/meson/clkc.h     |  3 +++
>  3 files changed, 27 insertions(+), 5 deletions(-)
> 

Series applied with Neil's ack
