Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeEGON3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:13:29 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41829 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeEGON1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:13:27 -0400
X-Google-Smtp-Source: AB8JxZqab9SXfyVaGQ1p5OB7xlFTIvESeHhqNnEXgcgC1y9uf5BQEzLvBc3aca/O0m6SGxF7mULbbw==
Date: Mon, 7 May 2018 09:13:25 -0500
From: Rob Herring <robh@kernel.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de,
        linux-pm@vger.kernel.org, dbasehore@chromium.org,
        linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org,
        kernel@collabora.com, hl@rock-chips.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: devfreq: rk3399_dmc: move interrupts
 to be optional.
Message-ID: <20180507141325.GB31442@rob-hp-laptop>
References: <20180505093450.17327-1-enric.balletbo@collabora.com>
 <20180505093450.17327-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505093450.17327-5-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 11:34:49AM +0200, Enric Balletbo i Serra wrote:
> In ATF we already wait for DDR DVFS finish, so move the interrupts properties
> to be optional.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> 
> Changes in v3:
> - [4/6] Move interrupts to be optional instead of remove.
> 
> Changes in v2:
> - [4/6] Add Reviewed-by Chanwoo Choi.
> 
>  .../devicetree/bindings/devfreq/rk3399_dmc.txt         | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
