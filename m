Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3813C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873842084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873842084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeJEV01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:26:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:8737 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbeJEV01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:26:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 07:27:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; 
   d="scan'208";a="89475080"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.252.137.177]) ([10.252.137.177])
  by orsmga003.jf.intel.com with ESMTP; 05 Oct 2018 07:27:30 -0700
Subject: Re: linux-next: Tree for Oct 4
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus PPC <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>
References: <20181004183449.36bcc93b@canb.auug.org.au>
 <20181004134644.GA9130@roeck-us.net>
 <CAMuHMdXfhbFi8HYtqd6BeACyG64_eQvoiSQ7DMpyOmdXEXPymg@mail.gmail.com>
 <20181005094445.4d0b68bc@canb.auug.org.au>
 <01c4a73c-7901-2fbb-8f87-95ff21dc5126@roeck-us.net>
 <20181005153905.126a005e@canb.auug.org.au>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <72f64b32-20f0-0e9a-a8f6-3e0845abb586@linux.intel.com>
Date:   Fri, 5 Oct 2018 07:27:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005153905.126a005e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2018 10:39 PM, Stephen Rothwell wrote:
> Hi Guenter,
> 
> On Thu, 4 Oct 2018 18:33:02 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Most of the boot failures are hopefully fixed with
>> https://lore.kernel.org/patchwork/patch/995254/
> 
> I have added that commit to linux-next today.
> 

After getting over that I ended up running into an issues with a NULL 
pointer dereference updating static keys/jump labels that was fixed by:
https://lore.kernel.org/patchwork/patch/993864/

Thanks.

- Alex
