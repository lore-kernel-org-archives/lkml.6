Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8A2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93790214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93790214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeIQVew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:34:52 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43010 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbeIQVew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:34:52 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g1w2r-0000Bj-7y; Mon, 17 Sep 2018 10:06:41 -0600
To:     Alexander Fomichev <fomichev.ru@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>, Doug Meyer <dmeyer@gigaio.com>,
        linux@yadro.com
References: <20180720180034.3964-1-logang@deltatee.com>
 <20180917151622.lnlckvkiyqqxlt4c@alfbook-pro.local>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cdf8ac35-75d3-afd2-1bcb-f9d5ac256459@deltatee.com>
Date:   Mon, 17 Sep 2018 10:06:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917151622.lnlckvkiyqqxlt4c@alfbook-pro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux@yadro.com, dmeyer@gigaio.com, shuah@kernel.org, Shyam-sundar.S-k@amd.com, fancer.lancer@gmail.com, allenbh@gmail.com, jdmason@kudzu.us, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, fomichev.ru@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 0/8] Fix breakage caused by the NTB multi-port patchset
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/09/18 09:16 AM, Alexander Fomichev wrote:
>> Logan Gunthorpe (8):
>>   NTB: ntb_tool: reading the link file should not end in a NULL byte
>>   NTB: Setup the DMA mask globally for all drivers
>>   NTB: Fix the default port and peer numbers for legacy drivers
>>   NTB: ntb_pingpong: Choose doorbells based on port number
>>   NTB: perf: Don't require one more memory window than number of peers
>>   NTB: perf: Fix support for hardware that doesn't have port numbers
>>   NTB: perf: Fix race condition when run with ntb_test
>>   NTB: ntb_test: Fix bug when counting remote files
> 
> Tested successfully on i5-based desktop PC, NTB on PM8535 chip, both
> ends are on the local system.
> 
> Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>

Thanks Alexander!

Logan
