Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeERQfq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:35:46 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:32776 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeERQfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:35:43 -0400
X-Google-Smtp-Source: AB8JxZoDwh2aErz0jWql3ifpZ1RBJOTBOfeuXsZVihi2dogADmMJ3zCYBt4mQKC2h9nfZ7cfq+LaLg==
Date: Fri, 18 May 2018 11:35:41 -0500
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: jic23@kernel.org, ludovic.desroches@microchip.com,
        alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v5 3/9] dt-bindings: input: touchscreen: add minimum
 pressure touchscreen property
Message-ID: <20180518163541.GA13676@rob-hp-laptop>
References: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
 <1525949114-29263-4-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525949114-29263-4-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 01:45:08PM +0300, Eugen Hristev wrote:
> Add a common touchscreen optional property that will specify
> the minimum pressure applied to the screen that is needed
> such that the driver will report the touch event.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v5:
>  - Modified property name to touchscreen-min-pressure from
> touchscreen-threshold-property
> 
>  Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
