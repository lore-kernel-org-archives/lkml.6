Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B1AC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB40920868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB40920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeJMEUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 00:20:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:11166 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbeJMEUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 00:20:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 13:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,374,1534834800"; 
   d="scan'208";a="240905977"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.132]) ([10.122.105.132])
  by orsmga004.jf.intel.com with ESMTP; 12 Oct 2018 13:46:35 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] MAINTAINERS: Replace Vince Bridgers as Altera TSE
 maintainer
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     geert+renesas@glider.be, jhogan@kernel.org, atull@kernel.org,
        bhelgaas@google.com, james.hartley@sondrel.com,
        linux-kernel@vger.kernel.org, vince.bridgers@intel.com
References: <1539363052-6143-1-git-send-email-thor.thayer@linux.intel.com>
 <20181012165741.GA12446@kroah.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <295a966d-5f48-9313-7dc6-47ea49d05a27@linux.intel.com>
Date:   Fri, 12 Oct 2018 15:49:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012165741.GA12446@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 11:57 AM, Greg KH wrote:
> On Fri, Oct 12, 2018 at 11:50:52AM -0500, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Vince has moved to a different role. Replace him as Altera
>> TSE maintainer.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Would be nice if Vince can ack this...
> 
+ Vince (at a new email address)
