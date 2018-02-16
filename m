Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758732AbeBPRmh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:42:37 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:32855 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756035AbeBPRmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:42:35 -0500
X-Google-Smtp-Source: AH8x226wXpC2ybPVh886U9YDlUku5gG1lOUQ7VNfl1BR2vXCwV2XH08IUqn/5TmNX9DgV6Mhsv7Hgg==
Subject: Re: [PATCH] nvme-pci: quiesce IO queues prior to disabling device HMB
 accesses
To: Sagi Grimberg <sagi@grimberg.me>,
        Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <1518440244-696-1-git-send-email-jianchao.w.wang@oracle.com>
 <22af82dd-0f20-f68b-2725-59b0da259e69@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <60dcb8f0-7139-3c3e-1838-2347ce67dbcc@broadcom.com>
Date: Fri, 16 Feb 2018 09:42:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <22af82dd-0f20-f68b-2725-59b0da259e69@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/2018 10:40 AM, Sagi Grimberg wrote:
> Thanks, I picked this up for 4.17 (unless someone thinks
> this is 4.16-rc material?)
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Note: I really hope that we can eventually commonize all the 
quiesce/unquiesce logic and points relative to controller state.  We 
have just enough differences to be interesting.

-- james
