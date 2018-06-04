Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeFDPj7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:39:59 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:39106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750985AbeFDPj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:39:57 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: David Miller <davem@davemloft.net>
CC: "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, "wangxi (M)" <wangxi11@huawei.com>
Subject: RE: [PATCH net] net: hns: Fix the process of adding broadcast
 addresses to tcam
Thread-Topic: [PATCH net] net: hns: Fix the process of adding broadcast
 addresses to tcam
Thread-Index: AQHT+comTi5wB8y1Wku/ALUok/Pdz6RQHlUAgAAiT6A=
Date: Mon, 4 Jun 2018 15:39:45 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93BD9C174@FRAEML521-MBX.china.huawei.com>
References: <20180601170011.22700-1-salil.mehta@huawei.com>
 <20180604.113552.1136710379930167373.davem@davemloft.net>
In-Reply-To: <20180604.113552.1136710379930167373.davem@davemloft.net>
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
Thanks for pointing out. Will fix them.

Best regards
Salil

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Monday, June 04, 2018 4:36 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>; lipeng (Y)
> <lipeng321@huawei.com>; mehta.salil@opnsrc.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; wangxi
> (M) <wangxi11@huawei.com>
> Subject: Re: [PATCH net] net: hns: Fix the process of adding broadcast
> addresses to tcam
> 
> From: Salil Mehta <salil.mehta@huawei.com>
> Date: Fri, 1 Jun 2018 18:00:11 +0100
> 
> > +		hns_dsaf_setup_mc_mask(dsaf_dev, mac_entry->in_port_num,
> > +			mc_mask, mac_entry->addr);
> 
> Please indent things properly when arguments span multiple lines.
> 
> The second line here should be precisely after the opennning
> parenthesis
> of the previous line.
> 
> > +		hns_dsaf_setup_mc_mask(dsaf_dev, mac_entry->in_port_num,
> > +			mc_mask, mac_entry->addr);
> 
> Likewise.
