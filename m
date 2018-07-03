Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1E2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7D324A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7D324A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeGCPjQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:39:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:29105 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932261AbeGCPjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:39:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 08:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,304,1526367600"; 
   d="scan'208";a="51715392"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2018 08:39:13 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 3 Jul 2018 08:39:13 -0700
Received: from fmsmsx104.amr.corp.intel.com ([169.254.3.207]) by
 fmsmsx123.amr.corp.intel.com ([169.254.7.207]) with mapi id 14.03.0319.002;
 Tue, 3 Jul 2018 08:39:13 -0700
From:   "Calciano, Jess" <jess.calciano@intel.com>
To:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC:     "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: iscsi_trx oops in 4.18.0-rc2 and potential patch for
 percpu_ida.c
Thread-Topic: iscsi_trx oops in 4.18.0-rc2 and potential patch for
 percpu_ida.c
Thread-Index: AdQPGB2tMgbfWvM7SUeHUKhtR3eNhwAoEHCAAMrOjeA=
Date:   Tue, 3 Jul 2018 15:39:13 +0000
Message-ID: <E079A211AAA8AD48953B67A89DB71C856E7DD2A7@fmsmsx104.amr.corp.intel.com>
References: <E079A211AAA8AD48953B67A89DB71C856E7DBC38@fmsmsx104.amr.corp.intel.com>
 <20180629074924.pomscnvmi3l42lbm@linutronix.de>
In-Reply-To: <20180629074924.pomscnvmi3l42lbm@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gU2ViYXN0aWFuLA0KDQo+IEluIExpbnVzJyB0cmVlOg0KPiA0YmI2ZTk2YWI4MDggKCJs
aWIvcGVyY3B1X2lkYS5jOiBkb24ndCBkbyBhbGxvYyBmcm9tIHBlci1DUFUgbGlzdCBpZiB0aGVy
ZSBpcyBub25lIikNCg0KV2UndmUgdGVzdGVkIHdpdGggNC4xOC4wLXJjMyBhbmQgd2UncmUgbm8g
bG9uZ2VyIHNlZWluZyB0aGUga2VybmVsIG9vcHMuIFRoYW5rIHlvdSENCg0KLS0gSmVzcw0K
