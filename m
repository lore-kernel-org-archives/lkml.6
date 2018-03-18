Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754907AbeCRWrO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:47:14 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44394 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754258AbeCRWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:47:12 -0400
X-Google-Smtp-Source: AG47ELtTMEanarC61CiH1klLKH0AO5jBtkmU5YkuLgbRH0syKn0eeQ6dx1z8JGbfDj5utdJOzO9yLQ==
Date: Sun, 18 Mar 2018 15:47:14 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: ohad@wizery.com, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 0/2] rpmsg: use put_device() if device_register fail
Message-ID: <20180318224714.GI5626@tuxbook-pro>
References: <cover.1520501519.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520501519.git.arvind.yadav.cs@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08 Mar 01:36 PST 2018, Arvind Yadav wrote:

> if device_register() returned an error! Always use put_device()
> to give up the reference initialized. unregister device for
> other return error.
> 

Patches applied.

Thanks,
Bjorn

> 
> Arvind Yadav (2):
>   [PATCH 1/2] rpmsg: glink: use put_device() if device_register fail
>   [PATCH 2/2] rpmsg: smd: use put_device() if device_register fail
> 
>  drivers/rpmsg/qcom_glink_smem.c | 3 ++-
>  drivers/rpmsg/qcom_smd.c        | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> -- 
> 1.9.1
> 
