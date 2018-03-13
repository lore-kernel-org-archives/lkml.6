Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932312AbeCMJkc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:40:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43211 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbeCMJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:40:29 -0400
X-Google-Smtp-Source: AG47ELt+bmC0oaREPFrhj6aTuSJOf5bGV5P4xdj8kvrcqWSDQwjAUW3DS/BF28lNyN1hK5v8fLzwKg==
Subject: Re: [PATCH 0/3] Fix some error handling paths in
 'meson_drv_bind_master()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, airlied@linux.ie,
        carlo@caione.org, khilman@baylibre.com
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <d0bc2518-ec6d-d919-f358-579211c50d9a@baylibre.com>
Date: Tue, 13 Mar 2018 10:40:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2018 21:15, Christophe JAILLET wrote:
> Patch 1 and 3 are fixes.
> Patch 2 is just a kind of clean-up noticed while patching this driver.
> 
> If patch 2 is considered as useless, patch 3 can be applied on top of 
> patch 1, it does nor depend on the 2nd patch.
> 
> Christophe JAILLET (3):
>   drm/meson: Fix an un-handled error path in 'meson_drv_bind_master()'
>   drm/meson: Use drm_dev_put() instead of drm_dev_unref()
>   drm/meson: Fix some error handling paths in 'meson_drv_bind_master()'
> 
>  drivers/gpu/drm/meson/meson_drv.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 

Hi,

Thanks for the fixes, since they are not critical, I pushed them on drm-misc-next, they will be backported onto stable tree by the stable team later on using the Fixes tag.

Neil
