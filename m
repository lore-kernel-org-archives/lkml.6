Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756BEECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292C020C0C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292C020C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeGMFND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:13:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbeGMFND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:13:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74F1B8A3C5;
        Fri, 13 Jul 2018 05:00:10 +0000 (UTC)
Received: from xz-mi (dhcp-14-142.nay.redhat.com [10.66.14.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5782B2026D74;
        Fri, 13 Jul 2018 05:00:05 +0000 (UTC)
Date:   Fri, 13 Jul 2018 13:00:03 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v4 9/9] iommu/vt-d: Remove the obsolete per iommu pasid
 tables
Message-ID: <20180713050003.GA2379@xz-mi>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
 <1531113778-28238-10-git-send-email-baolu.lu@linux.intel.com>
 <20180711024506.GB2359@xz-mi>
 <5B4801A6.1090200@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B4801A6.1090200@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 05:00:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 05:00:10 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'peterx@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 09:34:30AM +0800, Lu Baolu wrote:
> Hi Peter,
> 
> Do you have further comments for this series? I will work out a
> new version if there are no ones.

Not for now.  Though since you mentioned about the work to remove the
pasid state table, not sure whether it'll be nice to put that into
this series, or even put more patches that are directly related
(e.g. including the two-level pasid table work and anything related)
so the series could be more complete.

> 
> Thank you for reviewing my patches. Do you allow me to add your
> reviewed-by to the patches which you've reviewed?

I'm glad to read your work.  I didn't leave r-bs because I'm not that
familiar with the codes so I'm not confident to leave any, just to
raise the questions.  Please feel free to post a new version as you
wish, I'll try to leave r-b there if possible.

Thanks,

-- 
Peter Xu
