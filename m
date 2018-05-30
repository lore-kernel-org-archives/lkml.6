Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968493AbeE3A4Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 20:56:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:24671 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968341AbeE3A4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 20:56:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,458,1520924400";
   d="scan'208";a="58734680"
Subject: Re: [PATCH v2 0/9] iommu/vt-d: Improve PASID id and table management
To: Joerg Roedel <joro@8bytes.org>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
 <20180515141101.GF18595@8bytes.org> <5AFBE53C.2070604@linux.intel.com>
 <20180529115605.GI18595@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5B0DF6B4.1040908@linux.intel.com>
Date: Wed, 30 May 2018 08:56:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180529115605.GI18595@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/29/2018 07:56 PM, Joerg Roedel wrote:
> On Wed, May 16, 2018 at 04:01:00PM +0800, Lu Baolu wrote:
>> You are right. System-wide pasid space is necessary, hence PATCH
>> 1~3 implement it. But PATCH 4~9 don't go into the opposite direction,
>> it's designed to address another potential issue.
> Okay, thanks for the clarification. Please send me a rebased version of
> this after the merge window I will review again.

Sure.

Best regards,
Lu Baolu
