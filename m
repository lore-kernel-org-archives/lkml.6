Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbeBICgW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 21:36:22 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41181 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbeBICgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 21:36:20 -0500
X-Google-Smtp-Source: AH8x227xh6w5SNBQBHEQbuEaQ8ihOEx9s6pmhqCt19poVigOpxkfTt6FEyYhIyzLGVbgpaBUA8rWUA==
Date: Thu, 8 Feb 2018 20:36:17 -0600
From: Rob Herring <robh@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH 6/8] ASoC: samsung: i2s: Update clock-output-names
 property documentation
Message-ID: <20180209023617.ifjdibfe4xgdj27w@rob-hp-laptop>
References: <20180205154403.13520-1-s.nawrocki@samsung.com>
 <CGME20180205154529epcas2p3478546ef61294ac06cd9d8ed3d7e12c9@epcas2p3.samsung.com>
 <20180205154403.13520-7-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205154403.13520-7-s.nawrocki@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 04:44:01PM +0100, Sylwester Nawrocki wrote:
> The clock-output-names property is marked as deprecated. While at it,
> #clock-cells property's value is corrected in the example snippet
> and few typos are fixed.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  .../devicetree/bindings/sound/samsung-i2s.txt          | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
