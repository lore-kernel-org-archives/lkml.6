Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeERLSG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 07:18:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:54291 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752514AbeERLSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 07:18:04 -0400
Subject: Re: [PATCH v4 1/2] xen/kbdif: Sync up with the canonical definition
 in Xen
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, lyan@suse.com,
        boris.ostrovsky@oracle.com
Cc: konrad.wilk@oracle.com, andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180518095935.26740-1-andr2000@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <0fa7b3d6-10fc-9b13-959e-fa83a016ceec@suse.com>
Date: Fri, 18 May 2018 13:17:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518095935.26740-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/18 11:59, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> This is the sync up with the canonical definition of the keyboard
> protocol in Xen:
> 1. Add missing string constants for {feature|request}-raw-pointer
>    to align with the rest of the interface file.
> 
> 2. Add new XenStore feature fields, so it is possible to individually
>    control set of exposed virtual devices for each guest OS:
>      - set feature-disable-keyboard to 1 if no keyboard device needs
>        to be created
>      - set feature-disable-pointer to 1 if no pointer device needs
>        to be created
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
