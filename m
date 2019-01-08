Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257C4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2722087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfAHDa4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:30:56 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:48868 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbfAHDa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:30:56 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 6BE3C26030CB993E0DD5;
        Tue,  8 Jan 2019 11:30:54 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 8 Jan 2019 11:30:54 +0800
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.187]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0415.000;
 Tue, 8 Jan 2019 11:30:51 +0800
From:   "liujian (CE)" <liujian56@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] driver: uio: fix possible memory leak in uio_open
Thread-Topic: [PATCH v3] driver: uio: fix possible memory leak in uio_open
Thread-Index: AQHUoxymr3VFIhLMKEaZWX4Af9N1qKWje6cAgAE/SNA=
Date:   Tue, 8 Jan 2019 03:30:50 +0000
Message-ID: <4F88C5DDA1E80143B232E89585ACE27D0258ED8D@DGGEMM528-MBX.china.huawei.com>
References: <1546525702-11264-1-git-send-email-liujian56@huawei.com>
 <20190107161358.GB25694@kroah.com>
In-Reply-To: <20190107161358.GB25694@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.97.126]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Tuesday, January 08, 2019 12:14 AM
> To: liujian (CE) <liujian56@huawei.com>
> Cc: xiubli@redhat.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] driver: uio: fix possible memory leak in uio_open
> 
> On Thu, Jan 03, 2019 at 10:28:22PM +0800, liujian wrote:
> > Fixes: 57c5f4df0a5a ("uio: fix crash after the device is
> > unregistered")
> > Signed-off-by: liujian <liujian56@huawei.com>
> 
> 
> I can not take patches without any changelog text at all :(
I am sorry, I will resend the patch~
> 
> Also, is "liujian" your full name?  We need a real and full name for a
> signed-off-by line.

Yes, but as someone do, I may need change 'liujian' to 'Liu Jian'
Thanks

> thanks,
> 
> greg k-h
