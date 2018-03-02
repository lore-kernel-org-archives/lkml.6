Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425873AbeCBPxY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:53:24 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45680 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425385AbeCBPxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:53:21 -0500
X-Google-Smtp-Source: AG47ELu+5eQ0UvhTLnnwXt+dkvB9evhcsE+cP/yQB5UJNU134EdNfgu7sJAdnW8v11zpHDW5MLZwVw==
Date: Fri, 2 Mar 2018 09:53:19 -0600
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 02/19] dt-bindings: cpufreq: mediatek: use - instead
 of _ in examples
Message-ID: <20180302155319.xvp2awguosm7kyyo@rob-hp-laptop>
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <fd1fc4c6760ab8fcbf7518df1cecf3837ab18d2c.1519378871.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1fc4c6760ab8fcbf7518df1cecf3837ab18d2c.1519378871.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 06:16:22PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> It should be good that no use "_" is in examples. Consequently,
> those nodes in certain files which have an inappropriate name containing
> "_" are all being replaced with "-".
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
