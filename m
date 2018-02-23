Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBWQZR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:25:17 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:43075 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeBWQZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:25:14 -0500
X-Google-Smtp-Source: AG47ELv6CVkK1FbzR8gmhIoIwfgk5tnKno274dLGTiXQQjrSnierc3+lNNpqlLmabfOBRt4cp6xVJUWSp6b2qr17Bd0=
MIME-Version: 1.0
In-Reply-To: <20180223155935.GJ223881@art_vandelay>
References: <20180223131758.18362-1-robdclark@gmail.com> <20180223131758.18362-2-robdclark@gmail.com>
 <20180223155935.GJ223881@art_vandelay>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 23 Feb 2018 11:25:11 -0500
Message-ID: <CAF6AEGs3EHxzwW4MaYc+LXmKL3amD8pUysamrprPy-F-W8=6AQ@mail.gmail.com>
Subject: Re: [RFC 1/4] drm: Add writeback connector type
To: Sean Paul <seanpaul@chromium.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 10:59 AM, Sean Paul <seanpaul@chromium.org> wrote:
>
> Have we considered hiding writeback behind a client cap instead?

It is kinda *almost* unneeded, since the connector reports itself as
disconnected.

I'm not sure what the reason was to drop the cap, but I think it would
be better to have a cap so WB connectors don't show up in, for ex,
xrandr

BR,
-R
