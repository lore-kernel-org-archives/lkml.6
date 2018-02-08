Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBHP4y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:56:54 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:37134 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:56:52 -0500
X-Google-Smtp-Source: AH8x226wU9mihgOWbYDxTQPBiEDJ1vBXjVKsyMvcg1q+nDzqgjdB5FuBRtM6SCmXhDbNJR89v2rd0w==
Subject: Re: [PATCH V2 0/6]nvme-pci: fixes on nvme_timeout and
 nvme_dev_disable
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <073ce416-fd26-b41a-187d-1db9210c48b0@grimberg.me>
Date: Thu, 8 Feb 2018 17:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianchao,

Given the discussion on this set, you plan to respin again
for 4.16?
