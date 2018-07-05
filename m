Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA95240AD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA95240AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeGEGr5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:47:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:56581 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751621AbeGEGrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:47:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 23:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,311,1526367600"; 
   d="scan'208";a="64299680"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jul 2018 23:47:42 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 23:47:40 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 23:47:40 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0319.002;
 Thu, 5 Jul 2018 14:47:38 +0800
From:   "Tian, Baofeng" <baofeng.tian@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhuang, Qihua" <qihua.zhuang@intel.com>
Subject: RE: [PATCH] reboot: add reboot_panic parameter
Thread-Topic: [PATCH] reboot: add reboot_panic parameter
Thread-Index: AdQRqmCHOPV++No2QMSDZDs5cwc4kQAAMhMQABdv6YAAiKTIkA==
Date:   Thu, 5 Jul 2018 06:47:37 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE649E29D75@SHSMSX101.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADD8C@shsmsx102.ccr.corp.intel.com>
        <EEBA739CCF11FE49B73E1FB4690F5EE649E1B93B@shsmsx102.ccr.corp.intel.com>
 <20180702143057.1ca20a97ddfb91056010cec8@linux-foundation.org>
In-Reply-To: <20180702143057.1ca20a97ddfb91056010cec8@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWY1Yzg4OWItYzQ1MC00MGJhLThjZjgtNGEyMzI0NjMwYTJmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidHZ3elBpN1FsMnhXM0JRMzd4MTlGaVRyejQzYjQ1Y2VoVVRjS1hqMGpKNGtlMHVyMVhNbCtPSmpmSnZMR09YYiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Morton

On android platform, if use adb reboot, it will automatically reboot with cold reset.
cold reset will reset RAM and cause RAM lose data information, if we want to enable some debug features
like pstore, and ramdump etc, warm reset is needed to keep RAM across reset

So, we add this interface to allow people to set reboot as warm to get log data across reset.

Thanks
Tim

-----Original Message-----
From: Andrew Morton [mailto:akpm@linux-foundation.org] 
Sent: Tuesday, July 3, 2018 5:31 AM
To: Tian, Baofeng <baofeng.tian@intel.com>
Cc: andrew.smirnov@gmail.com; linux-kernel@vger.kernel.org; Zhuang, Qihua <qihua.zhuang@intel.com>
Subject: Re: [PATCH] reboot: add reboot_panic parameter

On Mon, 2 Jul 2018 02:20:59 +0000 "Tian, Baofeng" <baofeng.tian@intel.com> wrote:

> This "reboot_panic" kernel cmdline parameter allow to change the 
> reboot mode in case of panic only. It use the same format as the 
> "reboot" parameter.
> Example, for cf9 warm reset in case of panic: reboot_panic=p,w 
> currently it only support cold/warm reset in case of panic.

Why should we do this?  What are the benefits, what are the usecases, etc?  

Some user-facing documentation should clear that up.  `grep -r reboot= Documentation' will direct you to the appropriate places.

