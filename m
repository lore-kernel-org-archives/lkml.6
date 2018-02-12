Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeBLTho (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:37:44 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:52353 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeBLThn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:37:43 -0500
X-Google-Smtp-Source: AH8x227XAQWqQoMjrUSdvz95oNK5LSIO5l2XAjtRh5G7HG4nja9080Iht4+pShXZrK4HfcRMWc/rKw==
Subject: Re: [PATCH 1/3] nvme: fix the dangerous reference of namespaces list
To: Keith Busch <keith.busch@intel.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180212192914.GF16255@localhost.localdomain>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e74e3697-f8d5-7e4c-39d9-eb41196d0c03@grimberg.me>
Date: Mon, 12 Feb 2018 21:37:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212192914.GF16255@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Looks good.
> 
> Reviewed-by: Keith Busch <keith.busch@intel.com>
> 

Thanks Keith, appiled to nvme-4.17
