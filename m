Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5BEC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412542087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412542087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeILU7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:59:14 -0400
Received: from ale.deltatee.com ([207.54.116.67]:35136 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbeILU7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:59:14 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g07Sh-0000hl-2f; Wed, 12 Sep 2018 09:53:58 -0600
To:     Wesley.Sheng@microchip.com, kurt.schwemmer@microsemi.com,
        bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
References: <DM2PR11MB0105BF7DD2EFB7F3874EB457951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
 <DM2PR11MB0105A882E34348BC85F8EE79951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9a810527-1e71-cc6c-410c-da78faefee7d@deltatee.com>
Date:   Wed, 12 Sep 2018 09:53:43 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DM2PR11MB0105A882E34348BC85F8EE79951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, corbet@lwn.net, bhelgaas@google.com, kurt.schwemmer@microsemi.com, Wesley.Sheng@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] NTB: ntb_hw_switchtec: add pre-requisites for NTB driver
 and misc updates
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Wesley,

On 9/12/2018 2:55 AM, Wesley.Sheng@microchip.com wrote:
> From: Wesley Sheng <Wesley.Sheng@microchip.com>
> 
> 1.add pre-requisites for NTB driver
> 2.misc updates
>   change ntb hardware driver name to ntb_hw_switchtec
>   update the description of 2 partitions limit
>   add reference to Linux Documentation/ntb.txt
>   add use of term 'Command ID'
>   add use of term 'Command Return Value'
>   add a missing ')'

The commit message and patch title could use a bit of cleanup. It should
at least say you're updating the documentation, it reads as though you
are changing the driver.

Also, especially given the NTB tag in the patch title, you probably
should have CC'd the NTB List. (linux-ntb@googlegroups.com
<linux-ntb@googlegroups.com>)

> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Signed-off-by: Wesley Yung <Wesley.Yung@microchip.com>

Acked-by: Logan Gunthorpe <logang@deltatee.com>


Logan
