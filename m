Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11C1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9282064D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9282064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbeGUPxe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 11:53:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:55478 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbeGUPxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 11:53:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jul 2018 08:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,385,1526367600"; 
   d="scan'208";a="68788039"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2018 08:00:25 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 21 Jul 2018 08:00:25 -0700
Received: from fmsmsx117.amr.corp.intel.com ([169.254.3.3]) by
 fmsmsx115.amr.corp.intel.com ([169.254.4.136]) with mapi id 14.03.0319.002;
 Sat, 21 Jul 2018 08:00:25 -0700
From:   "Jiang, Dave" <dave.jiang@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the nvdimm tree
Thread-Topic: linux-next: Signed-off-by missing for commits in the nvdimm
 tree
Thread-Index: AQHUIQAx/Lgu7bRRVUKrWShGrW5wvqSZxRrE
Date:   Sat, 21 Jul 2018 15:00:24 +0000
Message-ID: <E0B67B6C-0862-4E2F-9796-C266E6ECF4FE@intel.com>
References: <20180722003608.42e7164c@canb.auug.org.au>
In-Reply-To: <20180722003608.42e7164c@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 21, 2018, at 7:36 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> Hi Dan,
> 
> Commits
> 
>  212a28b4dae9 ("MAINTAINERS: Add Jan Kara for filesystem DAX")
>  30153e5ba54d ("MAINTAINERS: update Ross Zwisler's email address")
> 
> are missing a Signed-off-by from their committer.

That’s my fault. I’ll fix. 



> 
> -- 
> Cheers,
> Stephen Rothwell
