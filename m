Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78D8F60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeFFNKu convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Wed, 6 Jun 2018 09:10:50 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:39109 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751851AbeFFNKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:10:48 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: David Miller <davem@davemloft.net>
CC: "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "wangxi (M)" <wangxi11@huawei.com>
Subject: RE: [PATCH net-next 2/3] net: hns3: Fix for VF mailbox receiving
 unknown message
Thread-Topic: [PATCH net-next 2/3] net: hns3: Fix for VF mailbox receiving
 unknown message
Thread-Index: AQHT/MJZ4PdDqt2qP0CPlGQvunxniaRR3mIAgAFXM0A=
Date: Wed, 6 Jun 2018 13:10:38 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BDA1302@FRAEML521-MBX.china.huawei.com>
References: <20180605114201.29900-1-salil.mehta@huawei.com>
        <20180605114201.29900-3-salil.mehta@huawei.com>
 <20180605.144046.766561700879427040.davem@davemloft.net>
In-Reply-To: <20180605.144046.766561700879427040.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
Sorry about this. I have fixed this in the V2 patch floated just now.

Best regards
Salil.
> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Tuesday, June 05, 2018 7:41 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>; lipeng (Y)
> <lipeng321@huawei.com>; mehta.salil@opnsrc.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; wangxi
> (M) <wangxi11@huawei.com>
> Subject: Re: [PATCH net-next 2/3] net: hns3: Fix for VF mailbox
> receiving unknown message
> 
> From: Salil Mehta <salil.mehta@huawei.com>
> Date: Tue, 5 Jun 2018 12:42:00 +0100
> 
> > +		if (unlikely(!hnae3_get_bit(flag,
> HCLGEVF_CMDQ_RX_OUTVLD_B))) {
> 
> This breaks the build, there is no such symbol named hnae3_get_bit().
