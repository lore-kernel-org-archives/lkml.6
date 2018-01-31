Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753425AbeAaPx3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:53:29 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:43447 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeAaPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:53:28 -0500
X-Google-Smtp-Source: AH8x224c4FiqWhxU+y/1pIbMuIz512+Q2NS8XXTvgp/uE6oKBCDKM80d93ObV0p8AXh6jiiM374VEkt84ShFD3BGOO4=
MIME-Version: 1.0
In-Reply-To: <20180119163033.Horde.mgSL8gNIZesX57JfE-3CXgu@gator4166.hostgator.com>
References: <20180119003955.GA28885@embeddedor.com> <1fea2528-11a5-0210-6350-e916ebfebbdf@amd.com>
 <20180119163033.Horde.mgSL8gNIZesX57JfE-3CXgu@gator4166.hostgator.com>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Wed, 31 Jan 2018 17:52:57 +0200
Message-ID: <CAFCwf11xcp=51b-SZWoooJnBPthRngOLFWxGHCp0CZLQKjwJ3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Use ARRAY_SIZE macro in kfd_build_sysfs_node_entry
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2018 at 12:30 AM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
>
> Quoting Felix Kuehling <felix.kuehling@amd.com>:
>
>> Looks good. This change is Reviewed-by: Felix Kuehling
>> <Felix.Kuehling@amd.com>
>>
>
> Thanks Felix.
> --
> Gustavo
>
Applied to -next
Oded

>
>
>
>
