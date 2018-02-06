Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeBFJtI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:49:08 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39749 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbeBFJtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:49:00 -0500
X-Google-Smtp-Source: AH8x227/w0eh4qzFzB7pGM0GQ/jPi6MJxLLUhkOHQiC47RCrjNQbyLB9vhgJ4nT9XkZKpnsMposJMQ==
Subject: Re: [PATCH] nvme-pci: Fix incorrect use of CMB size to calculate
 q_depth
To: sbates@raithlin.com, keith.busch@intel.com, axboe@fb.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1517869943-3655-1-git-send-email-sbates@raithlin.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <98265620-4f3e-4606-1000-070e717e0624@grimberg.me>
Date: Tue, 6 Feb 2018 11:48:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517869943-3655-1-git-send-email-sbates@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

I'll pick this one up unless someone thinks I shouldn't..
