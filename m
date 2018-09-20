Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC56ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144A721523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144A721523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbeITWbH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:31:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:7657 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbeITWbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:31:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 09:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="74884950"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2018 09:44:37 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 20 Sep 2018 09:44:37 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.41]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.164]) with mapi id 14.03.0319.002;
 Thu, 20 Sep 2018 09:44:36 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: misc ia64 cleanups (resend)
Thread-Topic: misc ia64 cleanups (resend)
Thread-Index: AQHUULNr8S//wV760EmucaPhs/fL1qT5YMqg
Date:   Thu, 20 Sep 2018 16:44:35 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D3E4D80@ORSMSX110.amr.corp.intel.com>
References: <20180920072700.22396-1-hch@lst.de>
In-Reply-To: <20180920072700.22396-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZThlYTUwNGEtMjQ1OC00ZDcxLWE1ODAtYjhiNjc3ZjkyMmYxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUG1NXC9lcHNlaWlIa1JBNHltK2NmV01IMTIxMEd6cGl3UTBOVWhqcFIyUFhLUHJyTStRSjRlQk9GcFpQSmJ5QXgifQ==
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

> A couple random cleanups I stumbled upon when doing dma related work.

Christoph,

Thanks.  Applied. Will send pull request for next merge window.

-Tony
