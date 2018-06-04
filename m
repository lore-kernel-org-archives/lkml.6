Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeFDLtK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:49:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33415 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbeFDLtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:49:00 -0400
X-Google-Smtp-Source: ADUXVKKqyLFq99nfZxYrWcSd11VjxPtgaUXE3vD8MNszj2aOvjTuhdsDYOxynZ6ObDUtg8bpqRxBGQ==
Subject: Re: [PATCH v2] nvme: trace: add disk name to tracepoints
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>
References: <20180604075612.7277-1-jthumshirn@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5af6f3ad-0932-ae45-a6f2-90e8e45726c5@grimberg.me>
Date: Mon, 4 Jun 2018 14:48:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180604075612.7277-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Add disk name to tracepoints so we can better destinguish between
> individual disks in the trace output.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Nit: s/destinguish/distinguish/g

Christoph, can you fix it up when applying or you want me
to do it?
