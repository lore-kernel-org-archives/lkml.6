Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754249AbeEaJW4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:22:56 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:37575 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754103AbeEaJWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:22:54 -0400
X-Google-Smtp-Source: ADUXVKJ7VdcaVloSq4WMXXepc+rmWZOrK5UY+vAbibMZDEh2v918krExXUuBfJ+9ScALCjyqz/pBrQ==
Subject: Re: [PATCHv2 1/5] nvme: fix lockdep warning in
 nvme_mpath_clear_current_path
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-2-jthumshirn@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5bfb1525-7911-a0df-0567-468b5cd98166@grimberg.me>
Date: Thu, 31 May 2018 12:22:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515074043.22843-2-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grmberg.e>
