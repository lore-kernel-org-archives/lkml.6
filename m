Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeEOXHE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:07:04 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35635 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeEOXHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:07:03 -0400
X-Google-Smtp-Source: AB8JxZpuB/I+pw0RYuu9NLk4ISDBkOVRZ+4W3SVeJW4ndxGI5i9ymMrR8bVb4endub7jZk5Ek6MdsyH4G08e8wTCnKM=
MIME-Version: 1.0
In-Reply-To: <20180515230149.6547-1-grygorii.strashko@ti.com>
References: <20180515230149.6547-1-grygorii.strashko@ti.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 May 2018 02:07:01 +0300
Message-ID: <CAHp75VdXjiis9R6a1EZO9q3fawB_nSmJhqRSvv_7yggTr-EBOA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw-phy-sel: check
 bus_find_device() ret value
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 2:01 AM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> This fixes klockworks warnings: Pointer 'dev' returned from call to
> function 'bus_find_device' at line 179 may be NULL and will be dereferenced
> at line 181.

> +               dev_err(dev, "unable to find platform device for %s\n",
> +                       of_node_full_name(node));

Sorry, isn't %pOF works for this?

-- 
With Best Regards,
Andy Shevchenko
