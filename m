Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D5D21582
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D5D21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeKLRMO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:12:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:64591 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeKLRMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:12:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2018 23:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,494,1534834800"; 
   d="scan'208";a="107483548"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga001.jf.intel.com with ESMTP; 11 Nov 2018 23:20:15 -0800
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 11 Nov 2018 23:20:14 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 11 Nov 2018 23:20:14 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.199]) with mapi id 14.03.0415.000;
 Mon, 12 Nov 2018 15:20:12 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v2 1/1] iommu/vtd: Cleanup dma_remapping.h header
Thread-Topic: [PATCH v2 1/1] iommu/vtd: Cleanup dma_remapping.h header
Thread-Index: AQHUelL5vO25VX8S5EiXaajcsd/f6KVLupFg
Date:   Mon, 12 Nov 2018 07:20:11 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D6242F@SHSMSX104.ccr.corp.intel.com>
References: <20181112064008.2102-1-baolu.lu@linux.intel.com>
In-Reply-To: <20181112064008.2102-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzQxZjdhYWItMjJkZC00ODRhLWI1ZDgtNTJiMDUzZTU3NTdjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR0t5aDJYd3JYZFJOXC9HY3RmcWx3TE9CMk0wN1ZkZ1VqeldCTW9aMm1oUlNjRDhnSXhQbVZ2VkI3T09HSTRaXC92In0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> bounces@lists.linux-foundation.org] On Behalf Of Lu Baolu
> Sent: Monday, November 12, 2018 2:40 PM
> Subject: [PATCH v2 1/1] iommu/vtd: Cleanup dma_remapping.h header
> 
> Commit e61d98d8dad00 ("x64, x2apic/intr-remap: Intel vt-d, IOMMU
> code reorganization") moved dma_remapping.h from drivers/pci/ to
> current place. It is entirely VT-d specific, but uses a generic
> name. This merges dma_remapping.h with include/linux/intel-iommu.h
> and removes dma_remapping.h as the result.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Liu, Yi L <yi.l.liu@intel.com>

Just out of curious, did you considered to modify the original file
name to be an intel specific file name? What makes you believe
merging the file content to intel-iommu.h is better?

Regards,
Yi Liu
