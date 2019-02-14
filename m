Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43CAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0572222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406637AbfBNKgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:36:18 -0500
Received: from relay.sw.ru ([185.231.240.75]:43070 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbfBNKgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:36:12 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1guENH-00054N-32; Thu, 14 Feb 2019 13:36:11 +0300
Subject: Re: [PATCH 3/4] mm: Remove pages_to_free argument of
 move_active_pages_to_lru()
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <154998432043.18704.10326447825287153712.stgit@localhost.localdomain>
 <154998445148.18704.11244772245027520877.stgit@localhost.localdomain>
 <20190213191446.r3pop7kv6kp6b2qv@ca-dmjordan1.us.oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <14693e22-ebe6-56cd-928b-4d68f6f52909@virtuozzo.com>
Date:   Thu, 14 Feb 2019 13:36:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213191446.r3pop7kv6kp6b2qv@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2019 22:14, Daniel Jordan wrote:
> On Tue, Feb 12, 2019 at 06:14:11PM +0300, Kirill Tkhai wrote:
>> +	/* Keep all free pages are in l_active list */
> 
> s/are//

Yeah, thanks.
