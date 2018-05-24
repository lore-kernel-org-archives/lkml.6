Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeEXEet (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 00:34:49 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34556 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeEXEer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 00:34:47 -0400
X-Google-Smtp-Source: AB8JxZpFFx1TzsoiSBqHIKVJpmYXV1ng8a4BuP1oThGHV3VsFZczeG9/8T2SlgPVBj4uPxS4xng5SQ==
Date: Thu, 24 May 2018 10:04:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ilia Lin <ilialin@codeaurora.org>, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/2] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180524043443.adivshl2un53n6hm@vireshk-i7>
References: <1527079139-3558-1-git-send-email-ilialin@codeaurora.org>
 <1527079139-3558-2-git-send-email-ilialin@codeaurora.org>
 <1ec7645d-72b6-5a1a-48c3-831a3c484a0e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec7645d-72b6-5a1a-48c3-831a3c484a0e@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 14:25, Sudeep Holla wrote:
> On 23/05/18 13:38, Ilia Lin wrote:
> > +config ARM_QCOM_CPUFREQ_KRYO
> > +	bool "Qualcomm Kryo based CPUFreq"
> > +	depends on QCOM_QFPROM
> > +	depends on QCOM_SMEM
> > +	select PM_OPP
> > +	help
> > +	  This adds the CPUFreq driver for Qualcomm Kryo SoC based boards.
> > +
> > +	  If in doubt, say N.
> > +
> 
> Sorry but just noticed now, any reason why this can't be module. I can't
> imagine any.

Actually I asked him to do that as cpufreq-dt itself can be compiled
in as module and this driver wasn't doing much and isn't big enough
(size wise) as well.

-- 
viresh
