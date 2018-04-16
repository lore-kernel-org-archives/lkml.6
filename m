Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeDPVn7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:43:59 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45008 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbeDPVn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:43:57 -0400
X-Google-Smtp-Source: AIpwx4+uhEIdJl8XHMLy0AbL/KdmeafxC/FaqCr3psB0kEV5DMDSS3eLgKFoHfDtUCE0yX8Az9e6tQ==
Date: Mon, 16 Apr 2018 16:43:55 -0500
From: Rob Herring <robh@kernel.org>
To: Fabian Mewes <architekt@coding4coffee.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, Lukas Wunner <lukas@wunner.de>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: mcp320x: Use vendor prefix
 compatible strings
Message-ID: <20180416214355.qa4y3jbqnaegmtzl@rob-hp-laptop>
References: <1523892846-25000-1-git-send-email-architekt@coding4coffee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523892846-25000-1-git-send-email-architekt@coding4coffee.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 05:34:06PM +0200, Fabian Mewes wrote:
> Update the example to use the compatible string including the
> vendor prefix instead of the ones deprecated in 3a872138e4b.
> 
> Signed-off-by: Fabian Mewes <architekt@coding4coffee.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/mcp320x.txt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
