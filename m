Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4532DECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 07:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5D020834
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 07:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5D020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeGNHlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 03:41:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:24824 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeGNHlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 03:41:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2018 00:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,351,1526367600"; 
   d="scan'208";a="57599362"
Received: from blu2-desk2.ccr.corp.intel.com (HELO [10.0.2.15]) ([10.239.13.1])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2018 00:23:32 -0700
Subject: Re: [PATCH v4 9/9] iommu/vt-d: Remove the obsolete per iommu pasid
 tables
To:     Peter Xu <peterx@redhat.com>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
 <1531113778-28238-10-git-send-email-baolu.lu@linux.intel.com>
 <20180711024506.GB2359@xz-mi> <5B4801A6.1090200@linux.intel.com>
 <20180713050003.GA2379@xz-mi>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5B49A4F4.4060204@linux.intel.com>
Date:   Sat, 14 Jul 2018 15:23:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180713050003.GA2379@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/13/2018 01:00 PM, Peter Xu wrote:
> On Fri, Jul 13, 2018 at 09:34:30AM +0800, Lu Baolu wrote:
>> Hi Peter,
>>
>> Do you have further comments for this series? I will work out a
>> new version if there are no ones.
> Not for now.  Though since you mentioned about the work to remove the
> pasid state table, not sure whether it'll be nice to put that into
> this series, or even put more patches that are directly related
> (e.g. including the two-level pasid table work and anything related)
> so the series could be more complete.
>
>> Thank you for reviewing my patches. Do you allow me to add your
>> reviewed-by to the patches which you've reviewed?
> I'm glad to read your work.  I didn't leave r-bs because I'm not that
> familiar with the codes so I'm not confident to leave any, just to
> raise the questions.  Please feel free to post a new version as you
> wish, I'll try to leave r-b there if possible.
>
> Thanks,
>

Okay! Thank you!

Best regards,
Lu Baolu
