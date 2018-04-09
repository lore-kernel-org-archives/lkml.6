Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbeDISrs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:47:48 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43566 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753250AbeDISrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:47:45 -0400
X-Google-Smtp-Source: AIpwx4/BJKibZuQJwMyB6mtg7dI4xjbNdRYxhFEAxAuZfv3Wc3aF/VypCsgJl3DBPtArbcYGO2eAEA==
Date: Mon, 9 Apr 2018 13:47:43 -0500
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: jic23@kernel.org, ludovic.desroches@microchip.com,
        alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v2 08/10] dt-bindings: iio: adc: at91-sama5d2_adc: add
 channel specific consumer info
Message-ID: <20180409184743.zu7ihom6tvi7aino@rob-hp-laptop>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
 <1522153963-1121-9-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522153963-1121-9-git-send-email-eugen.hristev@microchip.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 03:32:41PM +0300, Eugen Hristev wrote:
> Added defines for channel consumer device-tree binding
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  .../devicetree/bindings/iio/adc/at91-sama5d2_adc.txt     |  9 +++++++++
>  include/dt-bindings/iio/adc/at91-sama5d2_adc.h           | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 include/dt-bindings/iio/adc/at91-sama5d2_adc.h

Reviewed-by: Rob Herring <robh@kernel.org>
