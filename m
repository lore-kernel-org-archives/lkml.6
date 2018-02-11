Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeBKLSA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:18:00 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34214 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbeBKLR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:17:59 -0500
X-Google-Smtp-Source: AH8x226NaCE5J+AwUQV3wloPm/AGobSfcyNmZxO4wQ8ziMzNMrNozKz87bEW09v4IUn6vbfvlajEnw==
Subject: Re: [PATCH 3/9] nvme: change namespaces_mutext to namespaces_rwsem
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-4-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4170b29e-693c-9c61-1b3b-716af09e44d0@grimberg.me>
Date: Sun, 11 Feb 2018 13:17:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518341920-1060-4-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> namespaces_mutext is used to synchronize the operations on ctrl
> namespaces list. Most of the time, it is a read operation. It is
> better to change it from mutex to rwsem.
> 
> On the other hand, the namespaces mutex could introduce circular
> dependency easily.

On the other hand of what?

Also, can you give an example of such?
