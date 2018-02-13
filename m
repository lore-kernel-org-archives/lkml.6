Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933328AbeBMBw3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:52:29 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33735 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933099AbeBMBw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:52:27 -0500
X-Google-Smtp-Source: AH8x227M7q+dnHBnCCp9q9irLDJKvq2iFaVnGd5+h3U6W6TREuZ6v6i/tPTy0BWlPOtyXS0XpVZzQA==
Subject: Re: [PATCH] ia64: Remove pci-swiotlb.o from kernel Makefile
To: Christoph Hellwig <hch@lst.de>
Cc: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <1518474733-2972-1-git-send-email-linux@roeck-us.net>
 <20180213014412.GA3303@lst.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <fc758ce8-f7ba-f5a0-bf0f-4919954f21d0@roeck-us.net>
Date: Mon, 12 Feb 2018 17:52:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213014412.GA3303@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 05:44 PM, Christoph Hellwig wrote:
> Thanks Guenter,
> 
> I actually got a similar report a few days ago and prepared the same
> patch as part of the dma-mapping fixup series I'm about to send out:
> 
> 	http://git.infradead.org/users/hch/misc.git/commitdiff/f9f787e3fe227329d27768566e925e4d94c5f517
> 
Excellent.

Guenter
