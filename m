Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbeCICfr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:35:47 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:43493 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeCICfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:35:45 -0500
X-Google-Smtp-Source: AG47ELtSC71cm9KIu/+CmWEJOCXYWh5ZEyMtxadDpMUUIzy/ObbEtcs0GIME06AQr3hjziaNBsTVDA==
Subject: Re: [PATCH] Documentation/cdrom: update cdrom-standard.tex for kernel
 changes
To: Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <9f8a150a-2942-6392-0d83-7dac40b82e92@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <50959db2-609c-bdd5-e80e-66736f10bfd8@kernel.dk>
Date: Thu, 8 Mar 2018 19:35:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <9f8a150a-2942-6392-0d83-7dac40b82e92@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/18 8:58 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Documentation updates for Documentation/cdrom/cdrom-standard.tex:
> 
> cdrom_device_ops:
> - add check_events() and generic_packet()
> 
> cdrom_device_info:
> - add one 'const' modifier
> - correct some field descriptions
> - add some missing fields
> - drop 'kdev_t dev;' field
> 
> Also drop <n_discs> sentence from documentation because it is not
> referenced anywhere in the kernel header or C files.

Applied, thanks.

-- 
Jens Axboe
