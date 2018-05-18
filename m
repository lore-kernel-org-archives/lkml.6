Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeEROUq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:20:46 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41090 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbeEROUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:20:36 -0400
X-Google-Smtp-Source: AB8JxZqwqiRy9JX8N4Y/ojbMqV6jr4aj8DLeAvqE4o7WQVDUS+XSRQpgDWEb409HTXdMZO/QiNv2FQ==
Date: Fri, 18 May 2018 09:20:33 -0500
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: jic23@kernel.org, ludovic.desroches@microchip.com,
        alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v5 4/9] dt-bindings: input: touchscreen:
 resistive-adc-touch: create bindings
Message-ID: <20180518142033.GA28077@rob-hp-laptop>
References: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
 <1525949114-29263-5-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525949114-29263-5-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 01:45:09PM +0300, Eugen Hristev wrote:
> Added bindings for generic resistive touchscreen ADC.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v5:
>  - changed property name touchscreen-threshold-pressure to
> touchscreen-min-pressure
> 
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
> 
>  .../input/touchscreen/resistive-adc-touch.txt      | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt

Reviewed-by: Rob Herring <robh@kernel.org>
