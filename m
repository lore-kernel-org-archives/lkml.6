Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeCNPHX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:07:23 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45745 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeCNPHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:07:22 -0400
X-Google-Smtp-Source: AG47ELtWA8IaI3gJmTTmUI0alrLcgTeHP8oY9keW+pl1aypkWMp6INR9UahJHw9BGW8ZJ9WvSgTE1w==
Date: Thu, 15 Mar 2018 00:07:13 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCHv3 0/2] zsmalloc/zram: drop zram's max_zpage_size
Message-ID: <20180314150713.GA144952@rodete-laptop-imager.corp.google.com>
References: <20180314081833.1096-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314081833.1096-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 05:18:31PM +0900, Sergey Senozhatsky wrote:
> Hello,
> 
> 	ZRAM's max_zpage_size is a bad thing. It forces zsmalloc to
> store normal objects as huge ones, which results in bigger zsmalloc
> memory usage. Drop it and use actual zsmalloc huge-class value when
> decide if the object is huge or not.
> 
> v3:
> - add pool param to zs_huge_class_size() [Minchan]
> 
> Sergey Senozhatsky (2):
>   zsmalloc: introduce zs_huge_class_size() function
>   zram: drop max_zpage_size and use zs_huge_class_size()
 
Both looks good to me.

Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.
