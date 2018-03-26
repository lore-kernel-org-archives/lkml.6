Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeCZWZE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:25:04 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39714 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeCZWY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:24:59 -0400
X-Google-Smtp-Source: AIpwx4/oXl6gYnctURxIMgTU1d79CIls//uYcs8WxbeYsN4uxHIMFjyRQLgR7KUWv1MKxQibNc4o7w==
Date: Mon, 26 Mar 2018 17:24:57 -0500
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        eddie.huang@mediatek.com, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/16] dt-bindings: mfd: mediatek: add a description
 for MT6323 RTC
Message-ID: <20180326070841.z6kuggvlsmzmrwqq@rob-hp-laptop>
References: <cover.1521794176.git.sean.wang@mediatek.com>
 <ba4708a34e43fbc12e78804840be1698f84243cc.1521794177.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba4708a34e43fbc12e78804840be1698f84243cc.1521794177.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 05:15:00PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add a description for MT6323 RTC and link it to the detailed binding
> documentation.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
