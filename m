Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E24C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337EE20989
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfAGJQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:16:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55076 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfAGJQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:16:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD53580D;
        Mon,  7 Jan 2019 01:16:56 -0800 (PST)
Received: from [10.163.1.156] (unknown [10.163.1.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA0783F5D4;
        Mon,  7 Jan 2019 01:16:49 -0800 (PST)
Subject: Re: mmotm 2018-12-21-15-28 uploaded
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20181221232853.WLvEi%akpm@linux-foundation.org>
 <99ab6512-9fce-9cb9-76e7-7f83d87d5f86@arm.com>
 <20190107084338.GW31793@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <451ec03f-d669-fcd0-11c7-f7fef9f85a56@arm.com>
Date:   Mon, 7 Jan 2019 14:46:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190107084338.GW31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/07/2019 02:13 PM, Michal Hocko wrote:
> Hi,
> 
> On Mon 07-01-19 13:02:31, Anshuman Khandual wrote:
>> On 12/22/2018 04:58 AM, akpm@linux-foundation.org wrote:
> [...]
>>> A git tree which contains the memory management portion of this tree is
>>> maintained at git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.gi
>>
>> Hello Michal,
>>
>> I dont see the newer tags on this tree. Tried fetching all the tags from the tree
>> but only see these right now for 2018. This release should have an equivalent tag
>> (mmotm-2018-12-21-15-28) right ? 
> 
> I have stopped tracking mmotm trees in this tree quite some time ago. I
> would much rather turn mmotm into a proper git tree which I was
> discussing with Andrew but we didn't land in anything so far. I hope to
> use LSFMM this year to resurrect the idea. 
>

Even this tree http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/ does not clone. So
right now the only way to construct the latest mmotm tree is through applying all
the patches mentioned here at http://www.ozlabs.org/~akpm/mmotm/ on linux-next ?
