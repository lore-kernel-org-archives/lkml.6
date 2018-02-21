Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBUIKE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:10:04 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34261 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeBUIKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:10:01 -0500
X-Google-Smtp-Source: AH8x226BaVKzl6+3X/5Otd+o3qGuK9PRMKFmeb+8vnlQxPZ87C0gL/Ew6E4JnNTjzaCmUooQ/MmJOQ==
Subject: Re: [PATCH 0/3] pblk bugfixes
To: hans.ml.holmberg@owltronix.com
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <1519200181-10886-1-git-send-email-hans.ml.holmberg@owltronix.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <40fb8893-3c8a-d471-e78a-4a2eea079884@lightnvm.io>
Date: Wed, 21 Feb 2018 09:09:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1519200181-10886-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 09:02 AM, hans.ml.holmberg@owltronix.com wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> This is a slew of generic bugfixes to pblk
> 
> The patches apply on top of:
> https://github.com/OpenChannelSSD/linux branch for-4.17/core
> 
> Hans Holmberg (3):
>    lightnvm: pblk: delete writer kick timer before stopping thread
>    lightnvm: pblk: allow allocation of new lines during shutdown
>    lightnvm: pblk: prevent race in pblk_rb_flush_point_set
> 
>   drivers/lightnvm/pblk-core.c | 7 -------
>   drivers/lightnvm/pblk-init.c | 2 +-
>   drivers/lightnvm/pblk-rb.c   | 7 ++++---
>   3 files changed, 5 insertions(+), 11 deletions(-)
> 

Thanks Hans. Applied.
