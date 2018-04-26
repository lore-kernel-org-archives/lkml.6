Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756557AbeDZOke (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:40:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:7032 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754847AbeDZOkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:40:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="49335020"
Date: Thu, 26 Apr 2018 17:40:27 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: John Garry <john.garry@huawei.com>
Cc: andriy.shevchenko@linux.intel.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, graeme.gregory@linaro.org,
        helgaas@kernel.org, linuxarm@huawei.com, z.liuxinliang@hisilicon.com,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: Re: [RFC PATCH 1/2] ACPI / PNP: Don't add "enumeration_by_parent"
 devices
Message-ID: <20180426144027.GL2173@lahna.fi.intel.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-2-git-send-email-john.garry@huawei.com>
 <20180420130727.GV2173@lahna.fi.intel.com>
 <27c3f84e-4d53-4b6b-7382-04908082ed01@huawei.com>
 <20180420135222.GY2173@lahna.fi.intel.com>
 <75eae3ac-228f-d6a4-bb0e-4bd27e35c55d@huawei.com>
 <09e3aa95-86ae-ca30-7bb5-a9704d296b43@huawei.com>
 <20180426140808.GK2173@lahna.fi.intel.com>
 <15443a87-2622-01ee-f7f2-426a51ca0f11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15443a87-2622-01ee-f7f2-426a51ca0f11@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 03:23:17PM +0100, John Garry wrote:
> Not that I know about. Can you describe this method? I guess I also don't
> need to set the mfd_cell pnpid either for this special case device.

There is some documentation in "MFD devices" chapter of
Documentation/acpi/enumeration.txt at least.
