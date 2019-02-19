Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D9FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C042206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfBSLbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:31:25 -0500
Received: from foss.arm.com ([217.140.101.70]:43968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfBSLbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:31:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB941A78;
        Tue, 19 Feb 2019 03:31:24 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B9AB3F720;
        Tue, 19 Feb 2019 03:31:06 -0800 (PST)
Subject: Re: [PATCH v2 00/10] Add support for usb on Hikey960
To:     Chen Yu <chenyu56@huawei.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     liuyu712@hisilicon.com, john.stultz@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com
References: <20190218112310.17860-1-chenyu56@huawei.com>
 <b1aca3d0-547a-51bd-5bff-69652484b6cc@arm.com>
 <5e884818-7afe-e76c-a181-81d3b78f40bf@huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ad5c5f33-612b-8580-b816-8e9304b10b9d@arm.com>
Date:   Tue, 19 Feb 2019 11:31:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5e884818-7afe-e76c-a181-81d3b78f40bf@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2019 01:34, Chen Yu wrote:
[...]
> This patch set based on Heikki Krogerus's patches.
> Have you applied https://do-db2.lkml.org/lkml/2019/2/13/106 first?
> And these configs should be set to y:
> 	CONFIG_TYPEC
> 	CONFIG_TYPEC_TCPM
> 	CONFIG_TYPEC_TCPCI
> 	CONFIG_TYPEC_RT1711H
> 

I was based on the right stack but didn't have those configs. It seems to
be working fine now, thanks!

Tested-by: Valentin Schneider <valentin.schneider@arm.com>
