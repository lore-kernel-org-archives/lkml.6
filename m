Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeCVJhG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:37:06 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35138 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbeCVJhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:37:00 -0400
X-Google-Smtp-Source: AG47ELumnDWPfzPq0q9uJMvrNqEnfUq0/jKj12PM9joRKrWECqal17+yQpD09vz3AYch9hmTH629dg==
Subject: Re: [PATCH v3] drm/xen-front: Add support for Xen PV display frontend
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1521644293-14612-1-git-send-email-andr2000@gmail.com>
 <1521644293-14612-2-git-send-email-andr2000@gmail.com>
 <d7cd6147-da9f-0f18-cb05-4dccbf212255@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <4f28320b-701b-187d-1768-c41b52462ef9@gmail.com>
Date: Thu, 22 Mar 2018 11:36:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d7cd6147-da9f-0f18-cb05-4dccbf212255@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/2018 03:14 AM, Boris Ostrovsky wrote:
>
>
> On 03/21/2018 10:58 AM, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Add support for Xen para-virtualized frontend display driver.
>> Accompanying backend [1] is implemented as a user-space application
>> and its helper library [2], capable of running as a Weston client
>> or DRM master.
>> Configuration of both backend and frontend is done via
>> Xen guest domain configuration options [3].
>
>
> I won't claim that I really understand what's going on here as far as 
> DRM stuff is concerned but I didn't see any obvious issues with Xen bits.
>
> So for that you can tack on my
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>
Thank you
