Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754929AbeDTN2g (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:28:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:54048 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754759AbeDTN2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:28:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,301,1520924400";
   d="scan'208";a="47750292"
Message-ID: <1524230910.21176.474.camel@linux.intel.com>
Subject: Re: [RFC PATCH 2/2] HISI LPC: Add PNP device support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, lenb@kernel.org,
        mika.westerberg@linux.intel.com, lorenzo.pieralisi@arm.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, graeme.gregory@linaro.org,
        helgaas@kernel.org, linuxarm@huawei.com, z.liuxinliang@hisilicon.com
Date: Fri, 20 Apr 2018 16:28:30 +0300
In-Reply-To: <e838b3ef-5cf8-ac12-6b44-a1f8001f8b94@huawei.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
         <1524218846-169934-3-git-send-email-john.garry@huawei.com>
         <1524228606.21176.472.camel@linux.intel.com>
         <e838b3ef-5cf8-ac12-6b44-a1f8001f8b94@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-20 at 14:09 +0100, John Garry wrote:
> On 20/04/2018 13:50, Andy Shevchenko wrote:
> > On Fri, 2018-04-20 at 18:07 +0800, John Garry wrote:

> > > +			if (res->flags | IORESOURCE_IO)
> > 
> > What does this mean?
> 
> Here we check the resource flag for each resource for this PNP device
> - 
> for IO resources we must translate the resource value from the bus 
> address to the logical PIO address.

Please, re-read your code again.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
