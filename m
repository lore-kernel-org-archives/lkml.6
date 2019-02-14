Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680DEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF5B21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395210AbfBNRin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:38:43 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:45602 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfBNRin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:38:43 -0500
X-Greylist: delayed 1689 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Feb 2019 12:38:41 EST
Received: from [81.153.42.125] (helo=[192.168.1.82])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1guKWt-0006cL-3j; Thu, 14 Feb 2019 17:10:31 +0000
Subject: Re: [LSF/MM TOPIC] (again) THP for file systems
To:     Song Liu <songliubraving@fb.com>,
        Matthew Wilcox <willy@infradead.org>
References: <77A00946-D70D-469D-963D-4C4EA20AE4FA@fb.com>
 <20190213235959.GX12668@bombadil.infradead.org>
 <843818E0-C7E8-451E-A5B1-DAF0F120BD5A@fb.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
From:   Wols Lists <antlists@youngman.org.uk>
X-Enigmail-Draft-Status: N1110
Message-ID: <5C65A101.4010909@youngman.org.uk>
Date:   Thu, 14 Feb 2019 17:10:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <843818E0-C7E8-451E-A5B1-DAF0F120BD5A@fb.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/19 01:59, Song Liu wrote:
>> I believe the direction is clear.  It needs people to do the work.
>> > We're critically short of reviewers.  I got precious little review of
>> > the original XArray work, which made Andrew nervous and delayed its
>> > integration.  Now I'm getting little review of the followup patches
>> > to lay the groundwork for filesystems to support larger page sizes.
>> > I have very little patience for this situation.

> I don't feel I am a qualified reviewer for MM patches, yet. But I will 
> try my best to catch up. 

Then just dive in!

Ask questions - "what does this do?", "please explain this, I don't
understand", "I'm new here, please teach me".

Okay, some people are too busy to help much, but I've found looking
after the raid wiki that people are happy to help, *especially* if they
know that their time is going to be rewarded. If I ask for help it
usually results in an update to the wiki.

If they know you are reading through the patch asking them to explain it
helps two ways - you are another set of eyes to spot something wrong,
and your questions will make them look at their code in a new light.
Even if you don't understand what you're looking at, you can still spot
stuff that looks weird, and if you ask them to explain then it will mean
that code gets an extra check. Anything that slips through that is
probably fine.

Cheers,
Wol
