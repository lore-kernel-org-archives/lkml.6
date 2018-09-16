Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3CFECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 21:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA87A2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 21:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA87A2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeIQCfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 22:35:32 -0400
Received: from mleia.com ([178.79.152.223]:43670 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbeIQCfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 22:35:32 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 81604417702;
        Sun, 16 Sep 2018 22:11:15 +0100 (BST)
Subject: Re: [PATCH] net: ethernet: remove redundant null pointer check before
 of_node_put
To:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net
Cc:     fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1537103622-63482-1-git-send-email-zhongjiang@huawei.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <d7d33c5e-f4b6-cfaa-cca7-c4ffe521bae4@mleia.com>
Date:   Mon, 17 Sep 2018 00:11:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1537103622-63482-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180916_221115_549087_62D06D38 
X-CRM114-Status: UNSURE (   5.78  )
X-CRM114-Notice: Please train this message. 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/16/2018 04:13 PM, zhong jiang wrote:
> of_node_put has taken the null pinter check into account. So it is
> safe to remove the duplicated check before of_node_put.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

typo in the commit message, s/pinter/pointer/

Other than that please feel free to add my

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
