Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5465DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B5C21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B5C21529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbeITSUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:20:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387663AbeITSUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:20:32 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 455E15CD25B56;
        Thu, 20 Sep 2018 20:37:12 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 20:37:12 +0800
Message-ID: <5BA39477.7050908@huawei.com>
Date:   Thu, 20 Sep 2018 20:37:11 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     <davem@davemloft.net>, <hante.meuleman@broadcom.com>,
        <franky.lin@broadcom.com>, <arend.vanspriel@broadcom.com>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] brcm80211: remove redundant condition check before debugfs_remove_recursive
References: <1536761412-24932-1-git-send-email-zhongjiang@huawei.com> <20180920120709.5FE6960BF7@smtp.codeaurora.org> <5BA391D4.20205@huawei.com> <877ejg1hcd.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <877ejg1hcd.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/20 20:30, Kalle Valo wrote:
> zhong jiang <zhongjiang@huawei.com> writes:
>
>> On 2018/9/20 20:07, Kalle Valo wrote:
>>> zhong jiang <zhongjiang@huawei.com> wrote:
>>>
>>>> debugfs_remove_recursive has taken IS_ERR_OR_NULL into account. So just
>>>> remove the condition check before debugfs_remove_recursive.
>>>>
>>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> It seems you already submitted an identical patch four days earlier:
>>>
>>> https://patchwork.kernel.org/patch/10593061/
>>>
>>> Why the duplicate? Please ALWAYS add a changelog and increase the version number:
>> I am sorry for that. Maybe I send the patch earlier, but I remeber I
>> should forget to cc to
>> netdev@vger.kernel.org and LMLK. So I repost it.  Plese ingore the current patch.
> Even then please increase the version number and mention in the change
> log why you sent a new version. Otherwise you will make maintainers
> confused and wasting time with asking what has changed.
>
Get it  and will keep it in mind . Thanks

Sincerely,
zhong jiang

