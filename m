Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeDMSeI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 14:34:08 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:39505 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeDMSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 14:34:06 -0400
X-Google-Smtp-Source: AIpwx4+7UcicPvTq0pKQRj4LJpRsbwyUxhlk5lj/1GqdsCqXBuKSjlVmhD1KJTh6S7Jrh4CQKWMbgw==
Date: Fri, 13 Apr 2018 13:34:04 -0500
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: jic23@kernel.org, ludovic.desroches@microchip.com,
        alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v3 05/11] dt-bindings: input: touchscreen:
 resistive-adc-touch: create bindings
Message-ID: <20180413183404.2bt6wmjbozwvkyck@rob-hp-laptop>
References: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
 <1523350677-27106-6-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523350677-27106-6-git-send-email-eugen.hristev@microchip.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 11:57:51AM +0300, Eugen Hristev wrote:
> Added bindings for generic resistive touchscreen ADC.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v3:
>  - renamed file and compatible to exclude "generic" keyword
>  - removed the pressure threshold property, added it as a common
> touchscreen property in the touchscreen common bindings in a separate
> commit.
> 
> Changes in v2:
>  - modified bindings to have a generic resistive touchscreen adc driver
> instead of specific architecture one.
> 
>  .../input/touchscreen/resistive-adc-touch.txt      | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt

Reviewed-by: Rob Herring <robh@kernel.org>
