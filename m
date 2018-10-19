Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879E3ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43554205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43554205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJSS0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:26:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61480 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeJSS0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:26:10 -0400
Received: from 79.184.253.168.ipv4.supernova.orange.pl (79.184.253.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id b4b2fea5c4214ba0; Fri, 19 Oct 2018 12:20:41 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     corbet@lwn.net, lenb@kernel.org, viresh.kumar@linaro.org,
        robert.moore@intel.com, erik.schmauss@intel.com,
        juri.lelli@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, devel@acpica.org,
        pprakash@codeaurora.org, george.cherian@cavium.com
Subject: Re: [PATCH v4 0/3] cpufreq: intel_pstate: Base frequency attribute
Date:   Fri, 19 Oct 2018 12:17:24 +0200
Message-ID: <2009466.qjoMG8mNOh@aspire.rjw.lan>
In-Reply-To: <20181015173721.66147-1-srinivas.pandruvada@linux.intel.com>
References: <20181015173721.66147-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 15, 2018 7:37:18 PM CEST Srinivas Pandruvada wrote:
> This series presents base frequency to cpufreq sysfs when intel_pstate
> is in use in HWP mode.
> 
> Changes:
> v4:
> - Documentation update only as suggested by Rafael
> 
> v3:
> - Update documentation
> v2
> - Removed guaranteed attribute addition to acpi_cppc sysfs
> - Using the cppc_acpi interface to get base frequency and present
> 
> Srinivas Pandruvada (3):
>   ACPI / CPPC: Add support for guaranteed performance
>   cpufreq: intel_pstate: Add base_frequency attribute
>   Documentation: intel_pstate: Add base_frequency information
> 
>  Documentation/admin-guide/pm/intel_pstate.rst |  7 ++++
>  drivers/acpi/cppc_acpi.c                      |  8 +++-
>  drivers/cpufreq/intel_pstate.c                | 38 +++++++++++++++++++
>  include/acpi/cppc_acpi.h                      |  1 +
>  4 files changed, 52 insertions(+), 2 deletions(-)
> 
> 

All three applied, thanks!


