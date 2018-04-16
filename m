Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeDPVfz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:35:55 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:41614 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbeDPVfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:35:53 -0400
X-Google-Smtp-Source: AIpwx48MGKVy+FT/zjyLJoNbrAwT7iuIdr1tFkZCv7orvelaGXNQo3kW1jut19uVx6pZcBADXhn3nw==
Date: Mon, 16 Apr 2018 16:35:52 -0500
From: Rob Herring <robh@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] pinctrl: mediatek: update pinmux defintions for MT7623
Message-ID: <20180416213552.wbtv2ljwqpxgogqx@rob-hp-laptop>
References: <c8748c81711b0d41e83418b6c23d82d8c78c7094.1523845138.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8748c81711b0d41e83418b6c23d82d8c78c7094.1523845138.git.ryder.lee@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 10:32:19AM +0800, Ryder Lee wrote:
> Fulfill the pinmux macros for MT7623
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  include/dt-bindings/pinctrl/mt7623-pinfunc.h | 90 +++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
