Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B97C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68973214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68973214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbeKLOCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:02:04 -0500
Received: from foss.arm.com ([217.140.101.70]:58360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbeKLOCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:02:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2888CA78;
        Sun, 11 Nov 2018 20:10:44 -0800 (PST)
Received: from [10.162.0.72] (p8cg001049571a15.blr.arm.com [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A11043F5BD;
        Sun, 11 Nov 2018 20:10:39 -0800 (PST)
Subject: Re: [RFC] mm: Replace all open encodings for NUMA_NO_NODE
To:     Joseph Qi <jiangqi903@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     ocfs2-devel@oss.oracle.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-media@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-block@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-alpha@vger.kernel.org
References: <1541990515-11670-1-git-send-email-anshuman.khandual@arm.com>
 <1e9393c5-ff43-8ec7-dd6c-a662f09ef7c1@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b92e3275-7a04-a148-bb5b-38658c270583@arm.com>
Date:   Mon, 12 Nov 2018 09:40:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1e9393c5-ff43-8ec7-dd6c-a662f09ef7c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/2018 09:27 AM, Joseph Qi wrote:
> For ocfs2 part, node means host in the cluster, not NUMA node.
> 

Does not -1 indicate an invalid node which can never be present ?
