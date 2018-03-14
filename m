Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeCNNIs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751289AbeCNNIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:08:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C5820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: align memory boundary for bitops
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180310020348.69129-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <b370fdca-e460-7f62-3538-e43373d7274e@kernel.org>
Date: Wed, 14 Mar 2018 21:08:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310020348.69129-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/10 10:03, Jaegeuk Kim wrote:
> For example, in arm64, free_nid_bitmap should be aligned to word size in order
> to use bit operations.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
