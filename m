Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933220AbeCSLOv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:14:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:40983 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932616AbeCSLOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:14:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,330,1517904000";
   d="scan'208";a="26089405"
Date: Mon, 19 Mar 2018 13:14:45 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI: Add Time and Alarm Device (TAD) driver
Message-ID: <20180319111445.GM2703@lahna.fi.intel.com>
References: <6419044.RXe4JATo1K@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6419044.RXe4JATo1K@aspire.rjw.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 01:51:01PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce a driver for the ACPI Time and Alarm Device (TAD) based on
> Section 9.18 of ACPI 6.2.
> 
> This driver only supports the system wakeup capabilities of the TAD
> which are mandatory.  Support for the RTC capabilities of the TAD
> will be added to it in the future.
> 
> This driver is entirely sysfs-based.  It provides attributes (under
> the TAD platform device) to allow user space to manage the AC and DC
> wakeup timers of the TAD: set and read their values, set and check
> their expire timer wake policies, check and clear their status and
> check the capabilities of the TAD reported by AML.  The DC timer
> attributes are only present if the TAD supports a separate DC alarm
> timer.
> 
> The wakeup events handling and power management of the TAD is
> expected to be taken care of by the ACPI PM domain attached to its
> platform device.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
