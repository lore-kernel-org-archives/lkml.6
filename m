Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BEAC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE3E20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE3E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeGSKYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:24:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726956AbeGSKYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:24:25 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 798C6B958CB5A;
        Thu, 19 Jul 2018 17:42:02 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.382.0; Thu, 19 Jul 2018 17:41:53 +0800
From:   x00249684 <xuwei5@huawei.com>
To:     <liwei213@huawei.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <khilman@baylibre.com>,
        <arnd@arndb.de>, <gregory.clement@free-electrons.com>,
        <thomas.petazzoni@free-electrons.com>,
        <yamada.masahiro@socionext.com>, <riku.voipio@linaro.org>,
        <treding@nvidia.com>, <krzk@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <zangleigang@hisilicon.com>,
        <gengjianfeng@hisilicon.com>, <sunzhaosheng@hisilicon.com>,
        <ian.rickards@arm.com>, <guodong.xu@linaro.org>,
        <puck.chen@hisilicon.com>, <john.stultz@linaro.org>,
        <fengbaopeng@hisilicon.com>
Subject: Re: [PATCH v11 3/4] [RESEND] arm64: dts: add ufs dts node
Date:   Thu, 19 Jul 2018 17:40:41 +0800
Message-ID: <1531993241-173790-1-git-send-email-xuwei5@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20180717093659.103263-4-liwei213@huawei.com>
References: <20180717093659.103263-4-liwei213@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Li Wei <liwei213@huawei.com>
>
>arm64: dts: add ufs node for Hisilicon.
>
>Signed-off-by: Li Wei <liwei213@huawei.com>
>Reviewed-by: Rob Herring <robh@kernel.org>
>Tested-by: John Stultz <john.stultz@linaro.org>

Fine to me. Thanks!
Acked-by: Wei Xu <xuwei5@hisilicon.com>

But it will not be so staightforward when applying the patch
since in the recent pull request the hi3660.dtsi has been tidied up.
If it makes inconvenient, I can apply it once the binding is merged.
Thanks!

Best Regards,
Wei
