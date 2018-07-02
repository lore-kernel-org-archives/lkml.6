Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0684FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18DB256DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18DB256DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752925AbeGBFz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 01:55:59 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13720 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbeGBFz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 01:55:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b39be4a0000>; Sun, 01 Jul 2018 22:55:23 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 01 Jul 2018 22:55:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 01 Jul 2018 22:55:57 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Jul
 2018 05:55:56 +0000
Subject: Re: [PATCH v2 0/6] mm/fs: gup: don't unmap or drop filesystem buffers
To:     <john.hubbard@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
CC:     <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20180702005654.20369-1-jhubbard@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <011e8d10-1851-a4e2-991c-1f428317a963@nvidia.com>
Date:   Sun, 1 Jul 2018 22:54:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702005654.20369-1-jhubbard@nvidia.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2018 05:56 PM, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 

There were some typos in patches #4 and #5, which I've fixed locally.
Let me know if anyone would like me to repost with those right away, otherwise
I'll wait for other review besides the kbuild test robot.

Meanwhile, for convenience, you can pull down the latest version of the
patchset from:

    git@github.com:johnhubbard/linux (branch: gup_dma_next)


thanks,
-- 
John Hubbard
NVIDIA
