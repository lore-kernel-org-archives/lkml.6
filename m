Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BF5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E128720851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E128720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbeLCJaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:30:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbeLCJaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:30:24 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AB17A60574A8D;
        Mon,  3 Dec 2018 17:30:08 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Mon, 3 Dec 2018
 17:30:03 +0800
CC:     <wangbinghui@hisilicon.com>, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 09/12] usb: dwc3: Registering a role switch in the DRD
 code.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-10-chenyu56@huawei.com>
 <CAHp75VcU_vP_GEhn2-wvE_LRL2xtsY45kzjCRYU+BAnTcYDA4A@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <e0b03fee-9d32-d119-80a7-4329c34093c8@huawei.com>
Date:   Mon, 3 Dec 2018 17:30:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VcU_vP_GEhn2-wvE_LRL2xtsY45kzjCRYU+BAnTcYDA4A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/3 17:15, Andy Shevchenko wrote:
> On Mon, Dec 3, 2018 at 5:47 AM Yu Chen <chenyu56@huawei.com> wrote:
>>
>> The Type-C drivers use USB role switch API to inform the
>> system about the negotiated data role, so registering a role
>> switch in the DRD code in order to support platforms with
>> USB Type-C connectors.
> 
>> +       pr_info("%s:set role %d\n", __func__, role);
> 
> Noise!
> 
>> +       return role;
>> +
> 
> Redundant blank line.
> 
>> +}
> 
OK. Thanks!

Chen Yu

