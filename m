Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3083ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B400214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B400214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeIQNi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:38:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbeIQNi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:38:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 18B65F3DF03CE;
        Mon, 17 Sep 2018 16:12:06 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 16:11:58 +0800
Subject: Re: [PATCH 2/5] scsi: libsas: check the lldd callback correctly
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20180912082946.34814-1-yanaijie@huawei.com>
 <20180912082946.34814-3-yanaijie@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhaohongjiang@huawei.com>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>, <hch@lst.de>,
        <huangdaode@hisilicon.com>, <chenxiang66@hisilicon.com>,
        <miaoxie@huawei.com>, Ewan Milne <emilne@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>, Linuxarm <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ac858677-0606-665a-44fb-4042e81e83aa@huawei.com>
Date:   Mon, 17 Sep 2018 09:11:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180912082946.34814-3-yanaijie@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2018 09:29, Jason Yan wrote:
> We are using lldd_port_deformed so we'd better check if lldd_port_deformed
> is NULL.
>
> After this, we can remove hisi_sas_port_deformed() because it is just a
> stub to avoid a NULL dereference caused by the wrong check.
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Acked-by: John Garry <john.garry@huawei.com>

> CC: John Garry <john.garry@huawei.com>
> CC: Johannes Thumshirn <jthumshirn@suse.de>
> CC: Ewan Milne <emilne@redhat.com>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Tomas Henzl <thenzl@redhat.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Hannes Reinecke <hare@suse.com>
> ---


