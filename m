Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9306CC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6353D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6353D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeLGKLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:11:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:47947 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeLGKLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:11:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 02:11:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,326,1539673200"; 
   d="scan'208";a="98838669"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2018 02:11:32 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Maynard CABIENTE <maynard.cabiente@raritan.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] usb: dwc2: Revert "usb: dwc2: Disable all EP's on disconnect"
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A7B48EC@am04wembxa.internal.synopsys.com>
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com> <20181121154504.13052-1-m.szyprowski@samsung.com> <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com> <20181123144307.GC2970@unbuntlaptop> <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com> <2b48a7b5-f806-d761-97f6-885ae6c69a7e@samsung.com> <410670D7E743164D87FA6160E7907A56013A7B47A2@am04wembxa.internal.synopsys.com> <410670D7E743164D87FA6160E7907A56013A7B48EC@am04wembxa.internal.synopsys.com>
Date:   Fri, 07 Dec 2018 12:11:31 +0200
Message-ID: <87bm5xmyss.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Minas Harutyunyan <minas.harutyunyan@synopsys.com> writes:

> Hi Filipe,
>
> My patch dccf1bad4be7eaa096c1f3697bd37883f9a08ecb "usb: dwc2: Disable 
> all EP's on disconnect" applied to 4.20-rc1.
>
> I need to update this patch. What I should do. There are 2 options:
>
> 1. Ack Marek Szyprowski <m.szyprowski@samsung.com> [PATCH] usb: dwc2: 
> Revert "usb: dwc2: Disable all EP's on disconnect" then submit final 
> fixed version of patch?
>
> 2. Or submit new patch to fix existing "usb: dwc2: Disable all EP's on 
> disconnect".

I would say it's best to go with option 2. Just send a fix on top :-)

-- 
balbi
