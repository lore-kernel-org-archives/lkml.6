Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeEELrN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 07:47:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:45244 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbeEELrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 07:47:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,365,1520924400";
   d="scan'208";a="39464628"
Date: Sat, 5 May 2018 19:52:04 +0800
From: Yu Chen <yu.c.chen@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH][RFC] ACPI: acpi_pad: Do not launch acpi_pad threads on
 idle cpus
Message-ID: <20180505115204.GA32444@sandybridge-desktop>
References: <1525421322-23431-1-git-send-email-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525421322-23431-1-git-send-email-yu.c.chen@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 04:08:42PM +0800, Chen Yu wrote:
> According to current implementation of acpi_pad driver,
> it does not make sense to spawn any power saving threads
> on the cpus which are already idle - it might bring
> unnecessary overhead on these idle cpus and causes power
> waste. So verify the condition that if the number of 'busy'
> cpus exceeds the amount of the 'forced idle' cpus - This is
> applicable due to round-robin attribute of the power saving
> threads, otherwise ignore the setting/ACPI notification.
> 
> Suggested-by: Lenny Szubowicz <lszubowi@redhat.com>
> Suggested-by: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Rui Zhang <rui.zhang@intel.com>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>
Please ignore this one, I'm sending out another version.
Thanks,
Yu
