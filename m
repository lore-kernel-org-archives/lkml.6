Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932609AbeE3XGQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 19:06:16 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:54778 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932416AbeE3XGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 19:06:14 -0400
X-Google-Smtp-Source: ADUXVKJjnC7/rdJ0toFZFrGHx8//0xJjwREIPZZLsTsyhBi5ajmfpuqmloDs8RBP9gPBlEj4r4GKDw==
Subject: Re: [PATCH] nvme: trace: add disk name to tracepoints
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>
References: <20180530132049.5890-1-jthumshirn@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8659d1e0-ac96-5f45-61a8-247d81376516@grimberg.me>
Date: Thu, 31 May 2018 02:06:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180530132049.5890-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add disk name to tracepoints so we can better destinguish between
> individual disks in the trace output.

Looks useful,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
