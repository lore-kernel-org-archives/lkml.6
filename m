Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754323AbeDTJfx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:35:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32965 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754217AbeDTJfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:35:51 -0400
X-Google-Smtp-Source: AIpwx48oZIuV6j+q7FB9yKI1leek9tq3wCPZuIK7iPh10d6+OyCB6E3mOzMd4m0wPqxvh8d0sJ1Xbg==
Date: Fri, 20 Apr 2018 15:05:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Markus Mayer <code@mmayer.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Power Management List <linux-pm@vger.kernel.org>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>
Subject: Re: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if
 supported
Message-ID: <20180420093548.GA2989@vireshk-i7>
References: <20180418155643.36464-1-code@mmayer.net>
 <20180418155643.36464-3-code@mmayer.net>
 <20180419041632.GF24576@vireshk-i7>
 <74b70865-dfa9-25c8-20f8-3d2f722b9b2d@arm.com>
 <20180420044259.GA2873@vireshk-i7>
 <d09b1f87-d467-72d0-cb5d-fd747c7e30c8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09b1f87-d467-72d0-cb5d-fd747c7e30c8@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-18, 10:15, Sudeep Holla wrote:
> It still doesn't give the flexibility to switch between the two
> implementations boot time based on some firmware config(e.g. DT status
> property).

I agree, but it didn't look like they need flexibility :)

Lets see how the intend to use it. If they are *always* going to use SCPI if
that is available, then it should be solved at Kconfig level only. Else they
shouldn't put such code in the driver to quit early.

-- 
viresh
