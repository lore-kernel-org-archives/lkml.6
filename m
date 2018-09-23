Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3BCC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75037214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75037214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeIWLqm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 07:46:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:28301 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeIWLqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 07:46:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Sep 2018 22:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,291,1534834800"; 
   d="scan'208";a="94072220"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2018 22:49:06 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 22 Sep 2018 22:49:06 -0700
Received: from lcsmsx153.ger.corp.intel.com (10.186.165.228) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 22 Sep 2018 22:49:05 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.242]) by
 LCSMSX153.ger.corp.intel.com ([169.254.8.230]) with mapi id 14.03.0319.002;
 Sun, 23 Sep 2018 08:49:03 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [char-misc v4.4.y 2/2] mei: bus: type promotion bug in
 mei_nfc_if_version()
Thread-Topic: [char-misc v4.4.y 2/2] mei: bus: type promotion bug in
 mei_nfc_if_version()
Thread-Index: AQHUS15efZUfsgX14EOznlt0owXT76T9ZoOg
Date:   Sun, 23 Sep 2018 05:49:02 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9B4CF9@hasmsx108.ger.corp.intel.com>
References: <20180903224304.15989-1-tomas.winkler@intel.com>
 <20180903224304.15989-2-tomas.winkler@intel.com>
 <20180913123553.GJ2268@kroah.com>
In-Reply-To: <20180913123553.GJ2268@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTg0YTUxZGYtYTFlOC00MzllLTk0ZmItNWFjNWUyNTlkOGQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZWxVZDc4ZG4wZ09qdWdcL09VS2FIeDVoZkNIUkhSejNKeWd2bThoV2Z2a09GU0hLbXQrZHZrVmo0R3RuckdFM28ifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.18]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, Sep 04, 2018 at 01:43:04AM +0300, Tomas Winkler wrote:
> > From: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > commit b40b3e9358fbafff6a4ba0f4b9658f6617146f9c upstream
> >
> > We accidentally removed the check for negative returns without
> > considering the issue of type promotion.
> > The "if_version_length" variable is type size_t so if __mei_cl_recv()
> > returns a negative then "bytes_recv" is type promoted to a high
> > positive value and treated as success.
> >
> > Cc: <stable@vger.kernel.org> # 4.4
> 
> I also need a version of this patch for 4.18.y, 4.14.y, and 4.9.y before I will
> consider adding it to 4.4.y, as we do not want anyone to ever get a
> regression moving to a new kernel.

Right, I've started from the wrong end. 
Now I've posted the patches for the rest of the required long running versions.

Thanks
Tomas

