Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE29DC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DA82082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DA82082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profihost.ag
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJ3QO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:14:26 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:28813 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbeJ3QOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:14:25 -0400
Received: (qmail 3081 invoked from network); 30 Oct 2018 08:22:06 +0100
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.11.11.62]) (185.39.223.5)
  (smtp-auth username d.aberger@profihost.ag, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Tue, 30 Oct 2018 08:22:06 +0100
Reply-To: d.aberger@profihost.ag
Subject: Re: MCE reports errors that can't be verified
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.priebe@profihost.ag" <s.priebe@profihost.ag>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>
References: <6ccf5413-ce2a-bbb9-0203-b0cc9fe2e641@profihost.ag>
 <20181029161525.GI32150@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7D43AA76@ORSMSX110.amr.corp.intel.com>
 <20181029175129.GL32150@zn.tnic> <20181029182557.GA13320@agluck-desk>
From:   Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
Organization: Profihost AG
Message-ID: <d47099f3-a8b2-b0bc-fe1b-1e0904f105b3@profihost.ag>
Date:   Tue, 30 Oct 2018 08:22:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181029182557.GA13320@agluck-desk>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by d.aberger@profihost.ag through 185.39.223.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 29.10.18 um 19:25 schrieb Luck, Tony:
> On Mon, Oct 29, 2018 at 06:51:29PM +0100, Borislav Petkov wrote:
>> On Mon, Oct 29, 2018 at 04:59:44PM +0000, Luck, Tony wrote:
>>> The EDAC driver printed out those messages,
>>
>> I don't think so - that's __print_mce() in mce.c which dumps the three
>> lines under "... events logged". Which means, that's the lowest prio,
>> fallback notifier which runs when nothing else before it has done any
>> logging.
> 
> Ah yes. In which case the EDAC driver wasn't loaded (or gave up
> silently) to let us arrive at the end of the decode chain.
> 
> Another question. Does /proc/interrupts show a lot of CMCI (for
> historical reasons this is the THR: line).
> 
> -Tony
> 

I mailed you and Boris the requested information privately. Thanks!

- Daniel
