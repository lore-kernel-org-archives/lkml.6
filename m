Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeBEGIw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:08:52 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42289 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752562AbeBEGId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:08:33 -0500
X-Google-Smtp-Source: AH8x225VoiCk8dl/7AdxdtFq2DbQjmCCA55h/203fRDz8KGkPvfKhu20Wr3Xvla0JmM7li+flScIpA==
Date: Mon, 5 Feb 2018 00:08:31 -0600
From: Rob Herring <robh@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Garlic Tseng <garlic.tseng@mediatek.com>
Subject: Re: [PATCH v2 1/5] clk: mediatek: update missing clock data for
 MT7622 audsys
Message-ID: <20180205024914.os5dq5wip344hefe@rob-hp-laptop>
References: <cover.1515639336.git.ryder.lee@mediatek.com>
 <ec2dfe750291a996c54cc8aaeafafa333b992c4f.1515639336.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2dfe750291a996c54cc8aaeafafa333b992c4f.1515639336.git.ryder.lee@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 03:42:41PM +0800, Ryder Lee wrote:
> Add missing clock data 'CLK_AUDIO_AFE_CONN' for MT7622 audsys.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt7622-aud.c  | 1 +
>  include/dt-bindings/clock/mt7622-clk.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
