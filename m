Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeE3Oab (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753373AbeE3Oaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:30:30 -0400
Subject: Re: [f2fs-dev] [PATCH] f2fs: issue discard commands proactively in
 high fs utilization
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180529205048.39694-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <c179f3d9-1742-8f98-2c68-6c7d19c3cda4@kernel.org>
Date: Wed, 30 May 2018 22:29:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529205048.39694-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/30 4:50, Jaegeuk Kim wrote:
> In the high utilization like over 80%, we don't expect huge # of large discard
> commands, but do many small pending discards which affects FTL GCs a lot.
> Let's issue them in that case.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
