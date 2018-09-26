Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80043C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEB2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEB2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeIZOJN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:09:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:23729 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbeIZOJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:09:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 00:57:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,305,1534834800"; 
   d="scan'208";a="93348355"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga001.fm.intel.com with ESMTP; 26 Sep 2018 00:55:42 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 26 Sep 2018 00:55:42 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 26 Sep 2018 00:55:41 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.220]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.183]) with mapi id 14.03.0319.002;
 Wed, 26 Sep 2018 15:55:40 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Justin Ernst <justin.ernst@hpe.com>, Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "russ.anderson@hpe.com" <russ.anderson@hpe.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Raise maximum number of memory controllers
Thread-Topic: [PATCH] Raise maximum number of memory controllers
Thread-Index: AQHUVOOl0b0Pfp6TDESxlQMynIK4rKUCMAbA
Date:   Wed, 26 Sep 2018 07:55:39 +0000
Message-ID: <E6AF1AFDEA62A94A97508F458CBDD47F6F70517B@SHSMSX101.ccr.corp.intel.com>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
In-Reply-To: <20180925143449.284634-1-justin.ernst@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTc5NWUxNjQtNjE2ZC00NzI0LWIyZTgtZGE5M2Q5MDQzZjU4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC8yTlNyUE9HOEFjM01KcTdaQWJDbUg5SDVUbU9zMUhVN0Z4bTd6Zjhoa2lpYkhhZGVienNEbkpCRGRpZ1hHZ1cifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

> [ 3401.987556] EDAC MC15: Giving out device to module skx_edac controller Skylake Socket#1 IMC#1
    Just curious, has the system(two memory controllers per socket) got more than 8 sockets?
    Normally, the number "1" in the above string "Skylake Socekt#1 IMC#1" should be 7 (that was 15/2), but it was 1 here.

Thanks!
-Qiuxu
