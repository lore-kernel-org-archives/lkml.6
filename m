Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDE8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C21206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfBLAfN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:35:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:20975 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfBLAfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:35:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 16:35:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="318189983"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga006.fm.intel.com with ESMTP; 11 Feb 2019 16:35:11 -0800
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Feb 2019 16:35:11 -0800
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Feb 2019 16:35:11 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.57]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.180]) with mapi id 14.03.0415.000;
 Mon, 11 Feb 2019 18:35:09 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@mellanox.com" <jgg@mellanox.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/6] Documentation/infiniband: update from locked to
 pinned_vm
Thread-Topic: [PATCH 7/6] Documentation/infiniband: update from locked to
 pinned_vm
Thread-Index: AQHUvoT55Uy7G877J0q1705BUMR+vKXbWG0A
Date:   Tue, 12 Feb 2019 00:35:08 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E79BCF60F@CRSMSX101.amr.corp.intel.com>
References: <20190206175920.31082-1-dave@stgolabs.net>
 <20190207013155.lq5diwqc2svyt3t3@linux-r8p5>
In-Reply-To: <20190207013155.lq5diwqc2svyt3t3@linux-r8p5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzcxNjc5YjktMWQzNC00MTc0LTgwNTAtNzBhOGM3YWZiZTIyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoienppekg3cjdhNlpkTGlmOVF1c1JWXC9QamsrbjlLQ1ZTWStKcnhXSTR1WE5Jc2FvZ2lHNDUrWkRCTEtcLytQUERcLyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Davidlohr Bueso [mailto:dave@stgolabs.net]
> Sent: Wednesday, February 06, 2019 5:32 PM
> To: jgg@ziepe.ca; akpm@linux-foundation.org
> Cc: dledford@redhat.com; jgg@mellanox.com; jack@suse.cz;
> willy@infradead.org; Weiny, Ira <ira.weiny@intel.com>; linux-
> rdma@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 7/6] Documentation/infiniband: update from locked to
> pinned_vm
> 
> We are really talking about pinned_vm here.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  Documentation/infiniband/user_verbs.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/infiniband/user_verbs.txt
> b/Documentation/infiniband/user_verbs.txt
> index df049b9f5b6e..47ebf2f80b2b 100644
> --- a/Documentation/infiniband/user_verbs.txt
> +++ b/Documentation/infiniband/user_verbs.txt
> @@ -46,11 +46,11 @@ Memory pinning
>    I/O targets be kept resident at the same physical address.  The
>    ib_uverbs module manages pinning and unpinning memory regions via
>    get_user_pages() and put_page() calls.  It also accounts for the
> -  amount of memory pinned in the process's locked_vm, and checks that
> +  amount of memory pinned in the process's pinned_vm, and checks that
>    unprivileged processes do not exceed their RLIMIT_MEMLOCK limit.
> 
>    Pages that are pinned multiple times are counted each time they are
> -  pinned, so the value of locked_vm may be an overestimate of the
> +  pinned, so the value of pinned_vm may be an overestimate of the
>    number of pages pinned by a process.
> 
>  /dev files
> --
> 2.16.4
