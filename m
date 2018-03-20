Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbeCTBhg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 21:37:36 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36435 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeCTBhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 21:37:33 -0400
X-Google-Smtp-Source: AG47ELszFevmvfcFynjUCMhkPs32RdVGSyCqdrBFZCfEhbkhGocgSmUjLlpKdMUrnD68Ldwp6IosFg==
Date: Tue, 20 Mar 2018 09:37:31 +0800
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org, arnd.bergmann@linaro.org,
        Rafael Wysocki <rjw@rjwysocki.net>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] ARM64: dts: meson: Remove
 "cooling-{min|max}-level" for CPU nodes
Message-ID: <20180320013731.olxjil4qfj6ppjsl@vireshk-mac-ubuntu>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <6c91ebfecf86da98a7682c6d262ff1218a1d7343.1518166039.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c91ebfecf86da98a7682c6d262ff1218a1d7343.1518166039.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-02-18, 14:28, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> a CPU cooling device is found by referring to the cpufreq table instead.
> 
> Remove the unused properties from the CPU nodes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 4 ----
>  1 file changed, 4 deletions(-)

@Arnd: Can you please pick this and patch 8/10 from this series for 4.17 ? Both
are already Acked by Neil. I have just re-bounced both the messages to
arm@kernel.org. Thanks.

--
viresh
