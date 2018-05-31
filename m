Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754740AbeEaLga (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:36:30 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:39422 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbeEaLgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:36:25 -0400
X-Google-Smtp-Source: ADUXVKLVBkjJy1SzpDLBwR6vZ7QLN4kvl2OuuVzpc6kaHH8N0Lt1t8HVUvS6QCMWi67K4klzbwtbIQ==
Subject: Re: [PATCH -next] nvmet: fix error return code in
 nvmet_file_ns_enable()
To: Wei Yongjun <weiyongjun1@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1527766890-72455-1-git-send-email-weiyongjun1@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2e278301-9e7d-2c0e-d968-e77256ce82c3@grimberg.me>
Date: Thu, 31 May 2018 14:36:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527766890-72455-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
