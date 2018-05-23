Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754827AbeEWQX3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:23:29 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35690 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754530AbeEWQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:23:26 -0400
X-Google-Smtp-Source: AB8JxZqi5B1VBzMHJwYrAfrkHt7jal6VL3hDJfsK3JZFAx4gaagW/pE2t8PykbfQRYHmV70r51GooA==
Date: Wed, 23 May 2018 11:23:23 -0500
From: Rob Herring <robh@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: heiko@sntech.de, mark.rutland@arm.com, devicetree@vger.kernel.org,
        rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v3 08/13] dt-bindings: power: add RK3228 SoCs header for
 power-domain
Message-ID: <20180523162323.GA8821@rob-hp-laptop>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
 <1527058286-10503-1-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527058286-10503-1-git-send-email-zhangqing@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 02:51:26PM +0800, Elaine Zhang wrote:
> According to a description from TRM, add all the power domains.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/power/rk3228-power.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 include/dt-bindings/power/rk3228-power.h

Reviewed-by: Rob Herring <robh@kernel.org>
