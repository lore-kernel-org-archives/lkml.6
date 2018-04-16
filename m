Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeDPOci (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:32:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42876 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeDPOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:32:36 -0400
X-Google-Smtp-Source: AIpwx496KuFuRvZdUqvtt5D5b+yoapr5eaHQj+RwuNEdkF4wzyz5KaivKCUuT8jLc/D+geCfFcVbIw==
Date: Mon, 16 Apr 2018 15:32:32 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCHv4 02/10] mfd: ti-lmu: switch to gpiod
Message-ID: <20180416143232.gz2aacazsphexexy@dell>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-3-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180330172414.26575-3-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018, Sebastian Reichel wrote:

> Use new descriptor based API instead of the legacy one.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/mfd/ti-lmu.c       | 28 ++++++++++++----------------
>  include/linux/mfd/ti-lmu.h |  3 ++-
>  2 files changed, 14 insertions(+), 17 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
