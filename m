Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="thRoY6E1"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBB0D60263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeFFJ5A (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:57:00 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39227 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbeFFJ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:56:58 -0400
X-Google-Smtp-Source: ADUXVKIbZm7EIv3JBUbM/LJLYXWkQzXPlxqIJa9vz8Z6/qug9rTFAQ2kQcDwn3qnyyQ+MIWgW3oMCQ==
Subject: Re: [PATCH net-next 4/6] netxen_nic: use pci_zalloc_consistent
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jcliburn@gmail.com, chris.snook@gmail.com, benve@cisco.com,
        jdmason@kudzu.us, chessman@tux.org, jes@trained-monkey.org,
        rahul.verma@cavium.com
References: <20180605122851.23912-1-yuehaibing@huawei.com>
 <20180605122851.23912-5-yuehaibing@huawei.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <9a40ee2d-cb01-d469-602e-c4b79e6d41cf@cogentembedded.com>
Date: Wed, 6 Jun 2018 12:56:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605122851.23912-5-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/2018 3:28 PM, YueHaibing wrote:

> use pci_zalloc_consistent to remove unnecessary memset.
> Also remove a local intermediate pointer 'void *addr'.

    AAgain, don't do 2 things with 1 patch.

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
[...]

MBR, Sergei
