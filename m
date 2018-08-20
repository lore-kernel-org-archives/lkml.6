Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF9DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F262C21531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F262C21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeHUAuV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:50:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:11526 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbeHUAuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:50:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 14:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,266,1531810800"; 
   d="scan'208";a="74319703"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2018 14:32:51 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 20 Aug 2018 14:32:51 -0700
Received: from fmsmsx105.amr.corp.intel.com ([169.254.4.225]) by
 FMSMSX151.amr.corp.intel.com ([169.254.7.228]) with mapi id 14.03.0319.002;
 Mon, 20 Aug 2018 14:32:50 -0700
From:   "Howell, Seth" <seth.howell@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Walker, Benjamin" <benjamin.walker@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>
Subject: RE: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Thread-Topic: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Thread-Index: AQHUNB7XmXOwV8047EKXXIqMnpdlHaTB4cuA//+UiKCAAa0UAIAGDZzA
Date:   Mon, 20 Aug 2018 21:32:50 +0000
Message-ID: <EA913ED399BBA34AA4EAC2EDC24CDD0086118B12@FMSMSX105.amr.corp.intel.com>
References: <20180814223303.83556-1-seth.howell@intel.com>
 <20180815225021.GB31799@ziepe.ca>
 <EA913ED399BBA34AA4EAC2EDC24CDD008611724E@FMSMSX105.amr.corp.intel.com>
 <20180816180126.GB10507@ziepe.ca>
In-Reply-To: <20180816180126.GB10507@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGVhMTg4Y2UtMTlmOC00MGVmLWIyYWYtMTFhNmZiNjU3MTU5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSklJT09KSDA4cDlaT25zcE5ySmVucUhQT1pyTVpEWEx0MEQyRWw3TjArOUhVRWdiZmZMTW1JUjBhbWhUb0lqRSJ9
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

I apologize for the few days of radio silence on this one. I was able to apply your patch on my local configuration and can confirm that it fixes the issue of send with invalidate being improperly mapped between a user-space process and the kernel rxe driver.

Thanks again for your time and help.

Seth Howell

-----Original Message-----
From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-owner@vger.kernel.org] On Behalf Of Jason Gunthorpe
Sent: Thursday, August 16, 2018 11:01 AM
To: Howell, Seth <seth.howell@intel.com>
Cc: Walker, Benjamin <benjamin.walker@intel.com>; Doug Ledford <dledford@redhat.com>; linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org; Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi

On Wed, Aug 15, 2018 at 11:27:36PM +0000, Howell, Seth wrote:

> Thank you for taking the time to review this issue. The patch you 
> submitted will definitely fix the problem I was facing.

Can you test it to be certain?

Thanks,
Jason
