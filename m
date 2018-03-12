Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeCLEiV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 00:38:21 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38033 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeCLEiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 00:38:18 -0400
X-Google-Smtp-Source: AG47ELuMYKS1fPJllvy2KxmbK+02Q6GHE1HrFEB2rBrqld0nz0ooO3u7UhCdFhUXsXTC/wNAOEtYzg==
Date: Mon, 12 Mar 2018 10:08:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] dt-bindings: thermal: Remove
 "cooling-{min|max}-level" properties
Message-ID: <20180312043815.GW6842@vireshk-i7>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <0ec53640f1a09e6e0d7aa1a21d1a3266c3c209c7.1518166039.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec53640f1a09e6e0d7aa1a21d1a3266c3c209c7.1518166039.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-02-18, 14:28, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of kernel currently and the max cooling state of a
> CPU cooling device is found by referring to the cpufreq table instead.
> 
> Remove the unused bindings.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)

@Zhang/Eduardo: Can you please pick this patch (10/10) as almost everything else
is already lined up for 4.17 ?

-- 
viresh
