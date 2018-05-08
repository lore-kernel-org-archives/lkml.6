Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755323AbeEHPjs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:39:48 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35093 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755222AbeEHPjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:39:44 -0400
X-Google-Smtp-Source: AB8JxZqPAnBvXJJ1NVRzFe0yArJVeQ+SMRkpQFvM9ITCGiZTWiKUSYLPfmGNGsh54cGYPbqZpM+n3Q==
Date: Tue, 8 May 2018 10:39:41 -0500
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        matthias.bgg@gmail.com, eddie.huang@mediatek.com,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/17] dt-bindings: rtc: mt6397: add bindings for
 MediaTek PMIC based RTC
Message-ID: <20180508153941.GA23906@rob-hp-laptop>
References: <cover.1524646231.git.sean.wang@mediatek.com>
 <ae63c2a511e40ab4f6778197a1f15e41505d5682.1524646231.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae63c2a511e40ab4f6778197a1f15e41505d5682.1524646231.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 05:32:28PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add device-tree binding for MediaTek PMIC based RTC
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/rtc/rtc-mt6397.txt         | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt

Reviewed-by: Rob Herring <robh@kernel.org>
