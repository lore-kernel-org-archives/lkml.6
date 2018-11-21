Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A7FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8964721479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8964721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbeKVElv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:41:51 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731380AbeKVElv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:41:51 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id AD7DE17CE5B3;
        Wed, 21 Nov 2018 18:06:24 +0000 (GMT)
Received: from FRAEMA705-CHM.china.huawei.com (10.206.14.54) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 21 Nov 2018 18:06:25 +0000
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.76]) by
 FRAEMA705-CHM.china.huawei.com ([169.254.5.199]) with mapi id 14.03.0415.000;
 Wed, 21 Nov 2018 19:06:20 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH net-next 0/8] net: hns3: Adds support of debugfs to HNS3
 driver
Thread-Topic: [PATCH net-next 0/8] net: hns3: Adds support of debugfs to
 HNS3 driver
Thread-Index: AQHUgE2unp3acfxczkCerWVRgnQp5KVXnWuAgALkOFA=
Date:   Wed, 21 Nov 2018 18:06:19 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BFC8A64@FRAEML521-MBX.china.huawei.com>
References: <20181119211845.23168-1-salil.mehta@huawei.com>
 <20181119142955.56b6baa6@cakuba.netronome.com>
In-Reply-To: <20181119142955.56b6baa6@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.54]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jakub Kicinski [mailto:jakub.kicinski@netronome.com]
> Sent: Monday, November 19, 2018 10:30 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: davem@davemloft.net; Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>;
> lipeng (Y) <lipeng321@huawei.com>; mehta.salil@opnsrc.net;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH net-next 0/8] net: hns3: Adds support of debugfs to
> HNS3 driver
> 
> On Mon, 19 Nov 2018 21:18:37 +0000, Salil Mehta wrote:
> > This patchset adds support of debugfs to the HNS3 driver.
> >
> > Support has been added to query info related to below items:
> > 1. Queue related
> > 2. Flow Director
> > 3. TC config
> > 4. Transmit Module/Scheduler
> > 5. QoS pause
> > 6. QoS buffer
> > 7. QoS prio map
> 
> Please provide a more informative cover letter.
> 
> From a short glance it looks like you add a single debugfs file, which
> can be written to, and upon that write the driver will dump stuff into
> kernel logs.

That is correct. Do you foresee any problem with it or are we doing something
which is objectionable?

Salil.
