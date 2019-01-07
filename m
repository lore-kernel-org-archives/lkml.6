Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2B7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782282085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfAGHcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:32:45 -0500
Received: from foss.arm.com ([217.140.101.70]:53904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfAGHco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:32:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF10780D;
        Sun,  6 Jan 2019 23:32:43 -0800 (PST)
Received: from [10.163.1.156] (unknown [10.163.1.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3D7F3F5AF;
        Sun,  6 Jan 2019 23:32:37 -0800 (PST)
Subject: Re: mmotm 2018-12-21-15-28 uploaded
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20181221232853.WLvEi%akpm@linux-foundation.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <99ab6512-9fce-9cb9-76e7-7f83d87d5f86@arm.com>
Date:   Mon, 7 Jan 2019 13:02:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181221232853.WLvEi%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/2018 04:58 AM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-12-21-15-28 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (4.x
> or 4.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.
> 
> A git tree which contains the memory management portion of this tree is
> maintained at git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.gi

Hello Michal,

I dont see the newer tags on this tree. Tried fetching all the tags from the tree
but only see these right now for 2018. This release should have an equivalent tag
(mmotm-2018-12-21-15-28) right ? 

mmotm-2018-01-04-16-19
mmotm-2018-01-12-16-53
mmotm-2018-01-18-16-31
mmotm-2018-01-25-16-20
mmotm-2018-01-31-16-51
mmotm-2018-02-06-16-41
mmotm-2018-02-21-14-48
mmotm-2018-03-13-15-15
mmotm-2018-03-14-16-24
mmotm-2018-03-22-16-18
mmotm-2018-03-28-16-05
mmotm-2018-04-05-16-59
mmotm-2018-04-10-17-02
mmotm-2018-04-13-17-28
mmotm-2018-05-03-15-54
mmotm-2018-05-10-16-34
mmotm-2018-05-18-16-44
mmotm-2018-05-25-14-52

- Anshuman
