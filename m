Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753137AbeBKLOd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:14:33 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34708 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753024AbeBKLOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:14:32 -0500
X-Google-Smtp-Source: AH8x225GbVRRMCm3o+4XvLTw+SO8pKcCwQqCOIt5SHa8BhCBpatXej5K7l/E8TrfAiYt3pvzEg+fZg==
Subject: Re: [PATCH 1/9] nvme: fix the dangerous reference of namespaces list
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-2-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <994088a8-616a-8eea-49f1-4a8f64932351@grimberg.me>
Date: Sun, 11 Feb 2018 13:14:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518341920-1060-2-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
