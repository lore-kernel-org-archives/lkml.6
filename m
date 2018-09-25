Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07441C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97C720842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97C720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeIZEAT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:00:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:18043 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeIZEAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:00:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 14:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="76169094"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga008.jf.intel.com with ESMTP; 25 Sep 2018 14:50:30 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 25 Sep 2018 14:50:30 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.186]) with mapi id 14.03.0319.002;
 Tue, 25 Sep 2018 14:50:29 -0700
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 2/2] nvdimm: Set device node in nd_device_register
Thread-Topic: [PATCH 2/2] nvdimm: Set device node in nd_device_register
Thread-Index: AQHUVRHEthTt+AlHHU6zxZ+PBigxj6UB8yUAgAAApQCAAAYSAIAAALmAgAAEKwA=
Date:   Tue, 25 Sep 2018 21:50:29 +0000
Message-ID: <1537912228.7585.93.camel@intel.com>
References: <20180925204801.6182.73167.stgit@localhost.localdomain>
         <20180925205307.6182.26453.stgit@localhost.localdomain>
         <CAPcyv4jpUNP4mySPr5jYogpf5ZMPgpTu9oOjC89ZYHa=vL1JwQ@mail.gmail.com>
         <bcd44872-1961-79ff-f1a5-8ab2c2a99c20@linux.intel.com>
         <CAPcyv4jhxGubqLiHC=jqy2Bn7XQALUUoFcfEVKCUSeqGWCstLA@mail.gmail.com>
         <c6a5b7b0-954a-d84f-4927-03e51a016394@linux.intel.com>
In-Reply-To: <c6a5b7b0-954a-d84f-4927-03e51a016394@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.140.17]
Content-Type: text/plain; charset="utf-7"
Content-ID: <2B2A0EDE7DC21647BB4FD603D30878FC@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 14:35 -0700, Alexander Duyck wrote:
+AFs-..+AF0-
+AD4- Yeah, I kind of gathered that. If you want to move it feel free to.

Thanks for the flexibility, applied.

