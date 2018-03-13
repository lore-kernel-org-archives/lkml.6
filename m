Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeCMOfZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:35:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34612 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbeCMOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:35:23 -0400
X-Google-Smtp-Source: AG47ELvawNYrhmYQpFkFgO6yu1zXKCY8keoed45sexiKFCW5+s8eGRXI9LlJHTiAcNjQsy936Fc2qQ==
Date: Tue, 13 Mar 2018 23:35:20 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCHv2 2/2] zram: drop max_zpage_size and use
 zs_huge_class_size()
Message-ID: <20180313143520.GB741@tigerII.localdomain>
References: <20180306070639.7389-1-sergey.senozhatsky@gmail.com>
 <20180306070639.7389-3-sergey.senozhatsky@gmail.com>
 <20180313090249.GA240650@rodete-desktop-imager.corp.google.com>
 <20180313102437.GA5114@jagdpanzerIV>
 <20180313135815.GA96381@rodete-laptop-imager.corp.google.com>
 <20180313141813.GA741@tigerII.localdomain>
 <20180313142920.GA100978@rodete-laptop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313142920.GA100978@rodete-laptop-imager.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/13/18 23:29), Minchan Kim wrote:
[..]
> > Can do, but the param will be unused. May be we can do something
> 
> Yub, param wouldn't be unused but it's the way of creating dependency
> intentionally. It could make code more robust/readable.
> 
> Please, let's pass zs_pool and returns always right huge size.

OK, no prob. Will send an updated version tomorrow.

	-ss
