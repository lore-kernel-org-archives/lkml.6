Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DC1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EC32075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EC32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbeIGUIS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:08:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:5598 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbeIGUIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:08:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 08:26:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,342,1531810800"; 
   d="scan'208";a="78751948"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2018 08:26:53 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.148]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.245]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 08:26:53 -0700
From:   "Wyborny, Carolyn" <carolyn.wyborny@intel.com>
To:     "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>
CC:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
Thread-Topic: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build
 error
Thread-Index: AQHURpzDr0D43w/Ol0qvGBPE3lF+X6Tk8JMg
Date:   Fri, 7 Sep 2018 15:26:52 +0000
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6267C604A79@ORSMSX102.amr.corp.intel.com>
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1536319175-3660-3-git-send-email-dongsheng.wang@hxt-semitech.com>
 <77898840b49847a7a835b20b383e21a2@HXTBJIDCEMVIW02.hxtcorp.net>
In-Reply-To: <77898840b49847a7a835b20b383e21a2@HXTBJIDCEMVIW02.hxtcorp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjYwYTQ4YTMtZGQyMy00M2Y4LTgxNWItNmNmMTM5NzBjNGUxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUzNybUU3N2Rha3ZUM1BNbkJqSVVpcWwza0hCbW9yczlJRXN4d05jNFZRSkVmaGFvT2JYdkRCclBcL1Y1bVd5WVYifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Wang, Dongsheng [mailto:dongsheng.wang@hxt-semitech.com]
> Sent: Friday, September 07, 2018 5:34 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> sergei.shtylyov@cogentembedded.com
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; davem@davemloft.net;
> intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Wyborny, Carolyn <carolyn.wyborny@intel.com>
> Subject: Re: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
> 
> Hello Jacob,
> 
> Since Carolyn' team is working this, I think we don't need this patch
> anymore because this header file is only for ethtool.c.
> [..]
Hello Dongsheng,

The commonization effort we're working on is prioritizing our newest drivers.  The i40e work is still being scoped, so we should fix this problem as needed now and not wait.

I apologize for any miscommunication.  Was trying to let people know that we aware of the issue and are trying to make progress in that direction.

Thanks,

Carolyn
