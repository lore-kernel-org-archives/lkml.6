Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeEUXAj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 19:00:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:46351 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbeEUXAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 19:00:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,427,1520924400";
   d="scan'208";a="60547644"
Date: Mon, 21 May 2018 16:03:28 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Message-ID: <20180521160328.02bc9414@jacob-builder>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439BF2B2D@SHSMSX104.ccr.corp.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
        <A2975661238FB949B60364EF0F2C257439BF2537@SHSMSX104.ccr.corp.intel.com>
        <20180517085909.7470dfb5@jacob-builder>
        <A2975661238FB949B60364EF0F2C257439BF2B2D@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018 23:22:43 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > So as long as in-kernel PRQ handling can do queuing, there is no
> > need for queuing in the host reporting path.  
> 
> Will it affect current interface? Here the handler only get an "evt"
> per a PRQ IRQ. And I suppose vfio needs not rely on host iommu
> queuing?

I don't think it needs iommu driver queuing.
