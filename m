Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936028AbeBLOoV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:44:21 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45707 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754356AbeBLOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:44:03 -0500
X-Google-Smtp-Source: AH8x226R13HeyNVHZQ4703mYN25ltIJ8IJWmJW88Q8ISKqgF6dkstdlNShHyYE9a30up640pPuO9tQ==
Date: Mon, 12 Feb 2018 08:44:01 -0600
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: add header files required for
 MT7623A SCPSYS dt-binding
Message-ID: <20180212144401.yzrecztdveua3zix@rob-hp-laptop>
References: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
 <9955178588f8bde01782d0645b25a7b24cceb87b.1517998367.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9955178588f8bde01782d0645b25a7b24cceb87b.1517998367.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 06:22:48PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add relevant header files required for dt-bindings of SCPSYS power domain
> control for subsystems found on MT7623A SoC.
> 
> v1 -> v2: fix typos and treat the patch as a dt-binding patch
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  include/dt-bindings/power/mt7623a-power.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt7623a-power.h

Reviewed-by: Rob Herring <robh@kernel.org>
