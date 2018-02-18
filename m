Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeBRX1A (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:27:00 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43477 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbeBRX06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:26:58 -0500
X-Google-Smtp-Source: AH8x225PAqevG5E1dJiLrYn/POo3tTvUEO/leakS0egdh2dmiPL2FjrpeXz03u0z+Bc5xKd6uBuvRg==
Date: Sun, 18 Feb 2018 17:26:56 -0600
From: Rob Herring <robh@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] dt-bindings: cpufreq-dt: Remove
 "cooling-{min|max}-level" properties
Message-ID: <20180218232656.bjkomzkuv2my3ngy@rob-hp-laptop>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <aef1b506b365920d82b17c0712a3428196f72dc5.1518166039.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef1b506b365920d82b17c0712a3428196f72dc5.1518166039.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 02:28:09PM +0530, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of kernel currently and the max cooling state of a
> CPU cooling device is found by referring to the cpufreq table instead.
> 
> Remove the unused bindings.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
