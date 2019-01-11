Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3B6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017EA20878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbfAKSpA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:45:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:43799 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730785AbfAKSo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:44:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 10:44:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="105915136"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga007.jf.intel.com with ESMTP; 11 Jan 2019 10:44:58 -0800
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 11 Jan 2019 10:44:58 -0800
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.11]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.104]) with mapi id 14.03.0415.000;
 Fri, 11 Jan 2019 10:44:58 -0800
From:   "Bowers, AndrewX" <andrewx.bowers@intel.com>
To:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH 3/8] i40e: increase indentation
Thread-Topic: [Intel-wired-lan] [PATCH 3/8] i40e: increase indentation
Thread-Index: AQHUoF5YmlTy2fdjkkayqQJihnXz06Wqeqgw
Date:   Fri, 11 Jan 2019 18:44:57 +0000
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3510B4@ORSMSX104.amr.corp.intel.com>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
 <1546185195-25676-4-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1546185195-25676-4-git-send-email-Julia.Lawall@lip6.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmZkMjMxNjItODA0MC00YjM5LTkyNjYtYzlkZDlmNWE1ZDY1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSTI5aHBUSnl1K3FNN1VsNllEY2JpSUtITXF2ZXhYM1JVQWdJd2kra1R5XC9jdzdNWHp4SkxCcUcxOGhBZ1dVQzMifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Julia Lawall
> Sent: Sunday, December 30, 2018 7:53 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; kernel-janitors@vger.kernel.org; David
> S. Miller <davem@davemloft.net>; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH 3/8] i40e: increase indentation
> 
> Convert spaces to tabs to get correct alignment.
> 
> Found with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


