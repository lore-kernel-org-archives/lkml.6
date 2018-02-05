Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeBEGKF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:10:05 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37600 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbeBEGJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:09:13 -0500
X-Google-Smtp-Source: AH8x225DfRa9EQsEulAvgWvrwcux4rtZy1/e7ijrGTfCt9XsDFa3NjAP96evJn15cxTSQWJa4gFwPw==
Date: Mon, 5 Feb 2018 00:09:11 -0600
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: add SCPSYS binding for MT7623 and
 MT7623A SoC
Message-ID: <20180205035334.rb6rsl2r6kk2kvtu@rob-hp-laptop>
References: <975fb80e1cdbe7f6d4a1d04fd3a2a21b619a193d.1517479588.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975fb80e1cdbe7f6d4a1d04fd3a2a21b619a193d.1517479588.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 06:12:47PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> document the binding for enabling SCPSYS on MediaTek MT7623 and MT7623A
> SoC. Where MT7623 SoC has the same definition about power domains with
> MT2701, so it's fine to using MT2701 ones as MT7623's fallback.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
