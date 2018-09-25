Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC86EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0C720867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0C720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeIYPDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:03:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726392AbeIYPDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:03:05 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E7026242A0694;
        Tue, 25 Sep 2018 16:56:31 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Tue, 25 Sep 2018
 16:56:32 +0800
Message-ID: <5BA9F83F.1090005@huawei.com>
Date:   Tue, 25 Sep 2018 16:56:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Mark Brown <broonie@kernel.org>
CC:     <perex@perex.cz>, <bgoswami@codeaurora.org>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: qdsp6: remove duplicated include from q6adm.c
References: <1537525498-38843-1-git-send-email-zhongjiang@huawei.com> <20180921162206.GC20825@sirena.org.uk>
In-Reply-To: <20180921162206.GC20825@sirena.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/22 0:22, Mark Brown wrote:
> On Fri, Sep 21, 2018 at 06:24:58PM +0800, zhong jiang wrote:
>> We include wait.h twice in q6adm.c. it is unnecessary. hence remove
>> it.  Further, order the include files as alphabet.
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.
Get it . Will notice .  thanks

Sincerely,
zhong jiang

