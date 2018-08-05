Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DEEC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 13:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D201217CC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 13:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D201217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeHEPeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 11:34:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40309 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbeHEPeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 11:34:36 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4132248B1DB47;
        Sun,  5 Aug 2018 21:29:50 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Sun, 5 Aug 2018
 21:29:47 +0800
Message-ID: <5B66FBCA.60706@huawei.com>
Date:   Sun, 5 Aug 2018 21:29:46 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     <davem@davemloft.net>, <wensong@linux-vs.org>,
        <horms@verge.net.au>, <ja@ssi.bg>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: Remove some unneeded semicolon
References: <1533382901-17922-1-git-send-email-zhongjiang@huawei.com> <a274184c-c8e8-37de-492c-596f038337d0@cogentembedded.com>
In-Reply-To: <a274184c-c8e8-37de-492c-596f038337d0@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/5 2:08, Sergei Shtylyov wrote:
> On 08/04/2018 02:41 PM, zhong jiang wrote:
>
>> That semicolon is not unneeded , Just remove them.
>    s/un//, right? ;-)
>    That and you suddenly switch from singular to plural.
 :-[ I guess that David has corrected this.

 Thanks
 zhong jiang
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> MBR, Sergei
>
>


