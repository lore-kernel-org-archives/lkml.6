Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeEUJCH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:02:07 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34361 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeEUJCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:02:03 -0400
X-Google-Smtp-Source: AB8JxZpIXsElOqnC6iCNO901BVkdnEujD3gRPYmjtlgLNGEU+PKBWf0cN+MXxY5FD4bhzHrQKOhVtg==
Date: Mon, 21 May 2018 14:32:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        robh@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org
Subject: Re: [PATCH v2 0/2] Add support for QCOM cpufreq FW driver
Message-ID: <20180521090201.4ix2at6emxsdf6s2@vireshk-i7>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
 <20180521060529.kyjkglucbydr6b3f@vireshk-i7>
 <cb15a4db-77cd-8063-f323-652c6b03306e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb15a4db-77cd-8063-f323-652c6b03306e@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-18, 13:05, Taniya Das wrote:
> Hello Viresh,
> 
> Sure, will do it next time. Hope updating the fixes in this email is fine.
> Do let me know in case you need me to send it across again the series with
> cover letter updated.
> 
> On 5/21/2018 11:35 AM, Viresh Kumar wrote:
> > On 19-05-18, 23:04, Taniya Das wrote:
> > >   [v2]
> > >     * Address comments given in v0 series.
> > 
> > That's not how you do it. You need to explain every change in enough
> > detail here so that the reviewers don't need to go to their previous
> > emails to see what changed.
> > 
> Fixes in [v2]
>   * Fixed the alignment issues in "qcom_cpufreq_fw_target_index" for
> dev_err and also for "qcom_cpu_resources_init".
>  * Removed ret = 0 from qcom_get_related_cpus and added to check for
> cpu_mask_empty to return -ENOENT.
>  * Fixes qcom_cpu_resources_init function
>    * Remove initialization of 'index'
>    * Check for valid 'c'
>  * Removed initialization of 'prev_cc' from 'qcom_read_lut'.
>  * Remove initialization of 'ret' from function qcom_resources_init and add
> return -ENODEV based on 'of_get_available_child_count'.
>  * Removed initialization of 'rc' from qcom_cpufreq_fw_driver_probe
>  * Removed module_exit as this driver would not be used as module, also
> updated the Kconfig to bool from tristate.
>  * Updated the subsystem in device tree bindings.

That's what it should look like. Thanks.

-- 
viresh
