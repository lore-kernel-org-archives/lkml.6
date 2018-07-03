Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7ADC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD4624A3A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD4624A3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbeGCLac convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:30:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:46630 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752533AbeGCLa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:30:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 04:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,303,1526367600"; 
   d="scan'208";a="52288719"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jul 2018 04:30:28 -0700
Received: from hasmsx112.ger.corp.intel.com (10.184.198.40) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 3 Jul 2018 04:30:28 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.94]) by
 HASMSX112.ger.corp.intel.com ([169.254.11.94]) with mapi id 14.03.0319.002;
 Tue, 3 Jul 2018 14:28:12 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc 1/2] mei: remove unused MEI_IAMTHIF_STALL_TIMER
 define
Thread-Topic: [char-misc 1/2] mei: remove unused MEI_IAMTHIF_STALL_TIMER
 define
Thread-Index: AQHT/d3q1jTeZAeK7kGfcBayhzj9saR9TxSAgAA2svA=
Date:   Tue, 3 Jul 2018 11:28:12 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D95AFF1@hasmsx108.ger.corp.intel.com>
References: <20180606213148.9469-1-tomas.winkler@intel.com>
 <20180606213148.9469-2-tomas.winkler@intel.com>
 <20180703111113.GA14839@kroah.com>
In-Reply-To: <20180703111113.GA14839@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZThhMDFiOWQtOTc0Mi00MTlhLThkNGUtYzFhYjYzZDI3NGI1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWjUrb2ZaTkk1VUJrVGo5ZGE2TmZ5QW5QbllwWjdIVHBma3A4d1h5dURpbzRMT0o2RGtcL0RYRHRrWTJcL2hVM051In0=
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.12.116.121]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Thu, Jun 07, 2018 at 12:31:47AM +0300, Tomas Winkler wrote:
> > From: Alexander Usyskin <alexander.usyskin@intel.com>
> >
> > MEI_IAMTHIF_STALL_TIMER is unused now and can be safely removed.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> >  drivers/misc/mei/hw.h | 2 --
> >  1 file changed, 2 deletions(-)
> 
> Not a regression fix :(

No problem, please merge to next.
Thanks
Tomas

