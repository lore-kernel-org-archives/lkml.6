Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gN3JFLljGluOFgAAmS7hNA
	; Fri, 08 Jun 2018 11:08:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 45949608C1; Fri,  8 Jun 2018 11:08:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D027460590;
	Fri,  8 Jun 2018 11:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D027460590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeFHLIi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:08:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60908 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeFHLIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:08:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED09F1529;
        Fri,  8 Jun 2018 04:08:36 -0700 (PDT)
Received: from [10.37.13.33] (unknown [10.37.13.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBD803F59D;
        Fri,  8 Jun 2018 04:08:34 -0700 (PDT)
Subject: Re: [PATCH v2] mm/ksm: ignore STABLE_FLAG of rmap_item->address in
 rmap_walk_ksm
To: Andrew Morton <akpm@linux-foundation.org>,
        Jia He <hejianet@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jia.he@hxt-semitech.com,
        Hugh Dickins <hughd@google.com>
References: <20180503124415.3f9d38aa@p-imbrenda.boeblingen.de.ibm.com>
 <1525403506-6750-1-git-send-email-hejianet@gmail.com>
 <20180509163101.02f23de1842a822c61fc68ff@linux-foundation.org>
 <2cd6b39b-1496-bbd5-9e31-5e3dcb31feda@arm.com>
 <6c417ab1-a808-72ea-9618-3d76ec203684@arm.com>
 <20180524133805.6e9bfd4bf48de065ce1d7611@linux-foundation.org>
 <20180607151344.a22a1e7182a2142e6d24e4de@linux-foundation.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ab427520-7e1c-097d-3a37-09c1ff05bcac@arm.com>
Date: Fri, 8 Jun 2018 12:08:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180607151344.a22a1e7182a2142e6d24e4de@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 11:13 PM, Andrew Morton wrote:
> On Thu, 24 May 2018 13:38:05 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>> Jia, Andrew,
>>>
>>> What is the status of this patch ?
>>>
>>
>> I have it scheduled for 4.18-rc1, with a cc:stable for backporting.
>>
>> I'd normally put such a fix into 4.17-rcX but I'd like to give Hugh
>> time to review it and to generally give it a bit more time for review
>> and test.
>>
>> Have you tested it yourself?
> 
> I'll take your silence as a no.
> 

Hi Andrew,

Sorry, I missed this one. I can see give a try to reproduce the problem
and verify the fix.

Cheers
Suzuki
