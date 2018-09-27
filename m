Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA6BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A3F2156E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A3F2156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeI0I5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 04:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeI0I5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 04:57:03 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2DC230001E5;
        Thu, 27 Sep 2018 02:41:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67F2B308BE75;
        Thu, 27 Sep 2018 02:40:54 +0000 (UTC)
Subject: Re: [PATCH 3/4 v7] amd_iommu: remap the device table of IOMMU with
 the memory encryption mask for kdump
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, thomas.lendacky@amd.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhe@redhat.com
References: <20180907081805.368-1-lijiang@redhat.com>
 <20180907081805.368-4-lijiang@redhat.com>
 <20180925120442.wmh6fjpdghxjyvio@8bytes.org>
From:   lijiang <lijiang@redhat.com>
Message-ID: <bc9973a2-d3d3-19c2-11ab-3299ad2105c9@redhat.com>
Date:   Thu, 27 Sep 2018 10:40:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925120442.wmh6fjpdghxjyvio@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 27 Sep 2018 02:41:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年09月25日 20:04, Joerg Roedel 写道:
> On Fri, Sep 07, 2018 at 04:18:04PM +0800, Lianbo Jiang wrote:
>> In kdump kernel, it will copy the device table of IOMMU from the old device
>> table, which is encrypted when SME is enabled in the first kernel. So we
>> have to remap the old device table with the memory encryption mask.
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> 
> Please change the subject to:
> 
> 	iommu/amd: Remap the device table of IOMMU with the memory encryption mask for kdump
> 
> With that you can add my:
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>
> 

Thank you, Joerg.
Sorry for my late reply. I will change the subject and resend this patch.

Thanks.
Lianbo
