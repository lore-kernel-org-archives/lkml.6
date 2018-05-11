Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeEKH2K (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 03:28:10 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33987 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbeEKH1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 03:27:36 -0400
X-Google-Smtp-Source: AB8JxZqK1aMbs/tQXLGzyNHoN4E9I4cIkTc8B0fZjFdlNSo7Eo8pr6nDXL3JiL+6Byg7x36Xc2w0RQ==
Date: Fri, 11 May 2018 09:27:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 0/4] backlight: fix device-tree node lookups
Message-ID: <20180511072731.GA17870@localhost>
References: <20171120104547.2639-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120104547.2639-1-johan@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Mon, Nov 20, 2017 at 11:45:43AM +0100, Johan Hovold wrote:
> A number of drivers have been using the wrong OF helper when doing child-node
> lookups during probe. This meant that they were doing tree-wide searches rather
> than matching on child nodes and that the parent node could end up being
> prematurely freed.

> Johan Hovold (4):
>   backlight: as3711_bl: fix device-tree node lookup
>   backlight: max8925_bl: fix device-tree node lookup
>   backlight: tps65217_bl: fix device-tree node lookup
>   backlight: as3711_bl: fix device-tree node leaks

It appears these four have been sitting in your for-backlight-fixes 
branch for half a year now without being forwarded to Linus.

Don't get many backlight fixes these days, huh? ;)

Thanks,
Johan
