Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753265AbeBKLYV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:24:21 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:50480 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753024AbeBKLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:24:20 -0500
X-Google-Smtp-Source: AH8x227vHbWujeNCIvpQkhaJv+o8cdh8a8d50m8XwgMNnKbXb5N8VE4rjTwdpWbkbufKnUPLsaRjiw==
Subject: Re: [PATCH 9/9] nvme-pci: discard wait timeout when delete cq/sq
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-10-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <01948734-c1a3-ca94-5dff-b2f950af5b45@grimberg.me>
Date: Sun, 11 Feb 2018 13:24:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518341920-1060-10-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks ok to me, unless we have some quirks that need it?

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
