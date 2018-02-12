Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753884AbeBLSkk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:40:40 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:40566 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753828AbeBLSki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:40:38 -0500
X-Google-Smtp-Source: AH8x225fynq8BwHdvVGKeBSaXE3owKUGCaSq4MKAGu6H7yM2r7rNLBxKvQz3QL87Vp7PT4Xd+bVeDw==
Subject: Re: [PATCH] nvme-pci: quiesce IO queues prior to disabling device HMB
 accesses
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518440244-696-1-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <22af82dd-0f20-f68b-2725-59b0da259e69@grimberg.me>
Date: Mon, 12 Feb 2018 20:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518440244-696-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I picked this up for 4.17 (unless someone thinks
this is 4.16-rc material?)
