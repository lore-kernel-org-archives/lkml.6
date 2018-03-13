Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeCMQZJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:25:09 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36495 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932951AbeCMQZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:25:06 -0400
X-Google-Smtp-Source: AG47ELvlA7jeavXm3wVBW5YFIBoNUkkKnqguwN30KMsnlJfbpisw4wqZbzW1Xn0VbkKRUudhBNnNyQ==
Date: Tue, 13 Mar 2018 21:54:54 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: ds1803: remove VLA usage
Message-ID: <20180313162454.GA8769@himanshu-Vostro-3559>
References: <20180313152343.GA31789@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313152343.GA31789@embeddedgus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Tue, Mar 13, 2018 at 10:23:43AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA. In this particular
> case use macro ARRAY_SIZE so the length of array _result_ can be
> computed at preprocessing time.
> 
> The use of stack Variable Length Arrays needs to be avoided, as they
> can be a vector for stack exhaustion, which can be both a runtime bug
> or a security flaw. Also, in general, as code evolves it is easy to
> lose track of how big a VLA can get. Thus, we can end up having runtime
> failures that are hard to debug.
> 
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

It is already applied as I had sent the patch few days ago.
https://lkml.org/lkml/2018/3/10/164

I specifically CC'ed you and Kees to avoid the patch collisions.

-- 
Thanks
Himanshu Jha
