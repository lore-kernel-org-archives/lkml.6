Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="F2a8g9Jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D8F060555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeFFJxZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:53:25 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33519 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbeFFJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:53:23 -0400
X-Google-Smtp-Source: ADUXVKLR1uSTOdcqf8wXCFcasb1LMDR3/15coeLdgB27KoqGo/QN0Y1UrBu8Y7UWARcTFLyNwkWHTQ==
Subject: Re: [PATCH net-next 1/6] net: hippi: use pci_zalloc_consistent
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jcliburn@gmail.com, chris.snook@gmail.com, benve@cisco.com,
        jdmason@kudzu.us, chessman@tux.org, jes@trained-monkey.org,
        rahul.verma@cavium.com
References: <20180605122851.23912-1-yuehaibing@huawei.com>
 <20180605122851.23912-2-yuehaibing@huawei.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <bc3109e2-857a-a26d-8e09-39157968f770@cogentembedded.com>
Date: Wed, 6 Jun 2018 12:53:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605122851.23912-2-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 6/5/2018 3:28 PM, YueHaibing wrote:

> use pci_zalloc_consistent to remove unnecessary memset.
> Also remove a local intermediate pointer 'tmpptr'.

    Don't do 2 things with 1 patch.

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
[...]

MBR, Sergei
