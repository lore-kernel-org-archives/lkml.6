Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCFBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558A02175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558A02175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbeHCPah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:30:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:17368 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729849AbeHCPah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:30:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 06:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,438,1526367600"; 
   d="scan'208";a="60206564"
Received: from tzanussi-mobl2.amr.corp.intel.com (HELO [10.252.194.154]) ([10.252.194.154])
  by fmsmga008.fm.intel.com with ESMTP; 03 Aug 2018 06:34:12 -0700
Subject: Re: [PATCH 00/15][ANNOUNCE] 3.18.117-rt105-rc1
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, daniel.wagner@siemens.com, julia@ni.com
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
 <20180803073217.4szbepnmngoctvn6@linutronix.de>
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
Message-ID: <67dc4732-4690-5a3f-8176-1f451f0ea4d2@linux.intel.com>
Date:   Fri, 3 Aug 2018 08:34:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803073217.4szbepnmngoctvn6@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 8/3/2018 2:32 AM, Sebastian Andrzej Siewior wrote:
> On 2018-08-02 17:25:15 [-0500], Tom Zanussi wrote:
>> Please scream at me if I messed something up. Please test the patches
>> too.
> 
> The series claims to have 15 patches and I see only the first 10 (in my
> inbox, rt-users and linux-kernel).
> 

Yeah, my script was broken and didn't send the last third - resent. 
Thanks for letting me know,

Tom

>> Enjoy!
>>     
>>     Tom
> 
> Sebastian
> 
