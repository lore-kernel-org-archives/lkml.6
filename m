Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66006FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B29E20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B29E20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeINLgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 07:36:08 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:54354 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeINLgI (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 14 Sep 2018 07:36:08 -0400
Received: from linux-9avr.suse (prg-ext-pat.suse.com [213.151.95.130])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 14 Sep 2018 08:23:08 +0200
Subject: Re: [REGRESSION] Errors at reboot after 722e5f2b1eec
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     tiwai@suse.de, bpetkov@suse.de, linux-kernel@vger.kernel.org
References: <s5hk1ns1m8n.wl-tiwai@suse.de> <20180911093324.GB10436@kroah.com>
 <CAFgQCTtA0zFti3-X6r2E+60mWTWxzKoRehzE18Lg0M5D-MeM9w@mail.gmail.com>
 <14f8bb1c-ef13-1329-b144-d487949615e5@suse.com>
 <19d8cdd3-7f22-4066-e77f-8d17bf50bee7@intel.com>
 <90446c6c-e6ef-e55d-07f7-01f661fa2cd6@suse.com>
 <f08dda15-1b2c-a564-4f2b-90736cc4b340@intel.com>
From:   James Wang <jnwang@suse.com>
Openpgp: preference=signencrypt
Organization: QA-SLE
Message-ID: <6c135d43-a99e-b18b-a0cb-43df6671b413@suse.com>
Date:   Fri, 14 Sep 2018 08:23:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f08dda15-1b2c-a564-4f2b-90736cc4b340@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Bug has been filed:

Bug 201125 - ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0006 address=0x0000000000000080 flags=0x0020]


James
On 09/13/2018 10:50 PM, Rafael J. Wysocki wrote:
> On 9/13/2018 5:21 PM, James Wang wrote:
>>
>> On 09/12/2018 11:56 AM, Rafael J. Wysocki wrote:
>>> On 9/12/2018 11:10 AM, James Wang wrote:
>>>> On 09/12/2018 02:41 PM, Pingfan Liu wrote:
>>>>> Cc James, could you try to enable initcall_debug, and paste the

>>>>> shutdown seq with 722e5f2b1eec ("driver core: Partially revert
>>>>> "driver
>>>>> core: correct device's shutdown order"") and without it?
>>>> OK. And I will scheudule some testing orders, ahah, I'm in a business
>>>> trip.
>>>> All operations will be a little bit delay, but I will make it done.
>>>>
>>>> James
>>>>
>>> Can you please open a Bugzilla entry at bugzilla.kernel.org for the
>>> tracking of this issue and attach the results to that one for future
>>> reference?
>>>
>> Hi sir,
>> File a bug is no problem. but which product category should be used.
>
> Please file it under "Drivers/Other" and let me know the number. Thanks!
>
>
>

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

