Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6372FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EBA2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g787H4E0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EBA2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbeITTCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:02:07 -0400
Received: from m50-138.163.com ([123.125.50.138]:46174 "EHLO m50-138.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387616AbeITTCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:02:07 -0400
X-Greylist: delayed 1829 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Sep 2018 15:02:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=KkhB6
        OrIx8OmN/jNwfGz/KcRRauwGHQsgupddJFODsY=; b=g787H4E04NUTGmJ2b6s7W
        wMJuCK5n4+ycvu+kZAr0MZmM8gsKClExiSGKQTE+95e/WYQ5Yw5475EcuXnQ1JnQ
        3lu8mJ1w2GovRnt7c8CdciSQKnCxoLx/6HajmQEVk/c6NQd4gzSJZwEheWxKtp2g
        4R8WDHf2B0/DiFqx0GZ7tY=
Received: from [192.168.43.190] (unknown [112.86.218.14])
        by smtp1 (Coremail) with SMTP id C9GowADnJOnVkqNbhZmPAA--.6S2;
        Thu, 20 Sep 2018 20:30:18 +0800 (CST)
Subject: Re: [RFC PATCH] irq/affinity: Mark the pre/post vectors as regular
 interrupts
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>, ming.lei@redhat.com,
        Christoph Hellwig <hch@lst.de>, douly.fnst@cn.fujitsu.com,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20180913031011.17376-1-dou_liyang@163.com>
 <alpine.DEB.2.21.1809131135540.1473@nanos.tec.linutronix.de>
 <e725ccd00a98bb4b4541315017a16584@mail.gmail.com>
From:   Dou Liyang <dou_liyang@163.com>
Message-ID: <8f5b0455-7f43-851b-849b-10cbba5e0fab@163.com>
Date:   Thu, 20 Sep 2018 20:30:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e725ccd00a98bb4b4541315017a16584@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C9GowADnJOnVkqNbhZmPAA--.6S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq7UUUUUUU
X-Originating-IP: [112.86.218.14]
X-CM-SenderInfo: pgrxszxl1d0wi6rwjhhfrp/1tbiLg-HolSIcad5PwAAsI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kashyap,

On 2018/9/20 16:39, Kashyap Desai worte:
> Dou -  Do you want me to test your patch or shall I wait for next version
> ?

I'm sorry, please wait for the next version.

Thanks,
	dou

