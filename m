Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeFEPV3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:21:29 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39857 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeFEPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:21:19 -0400
X-Google-Smtp-Source: ADUXVKJbb+Zx0l6oFPt8hW6dW50qOlf6frtFiFy9FiJJdEZXCmQ/0FIjjPUQ+BrxaQQcg9t3nhHUVA==
Subject: Re: [PATCH v5] block: add verifier for cmdline partition
To: Wang YanQing <udknight@gmail.com>, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, tglx@linutronix.de, caizhiyong@hisilicon.com,
        rdunlap@infradead.org, jiangheng@hisilicon.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180510030637.GA25734@udknight>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b23c64e5-6768-9387-517c-59deded8a331@kernel.dk>
Date: Tue, 5 Jun 2018 09:21:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180510030637.GA25734@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/18 9:06 PM, Wang YanQing wrote:
> I meet strange filesystem corruption issue recently, the reason
> is there are overlaps partitions in cmdline partition argument.
> 
> This patch add verifier for cmdline partition, then if there are
> overlaps partitions, cmdline_partition will log a warning. We don't
> treat overlaps partition as a error:
> "
> Caizhiyong <caizhiyong@hisilicon.com> said:
> Partition overlap was intentionally designed in this cmdline partition.
> reference http://lists.infradead.org/pipermail/linux-mtd/2013-August/048092.html
> "

Applied, thanks.

-- 
Jens Axboe
