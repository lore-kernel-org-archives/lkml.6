Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754063AbeDTHeN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:34:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42328 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbeDTHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:34:08 -0400
X-Google-Smtp-Source: AIpwx4+wDfyhWlvLvERzGq5B8WE9WZfgtKrUqhHaicYbZpIk1sRuDCgcif5kpRIotWRzH/W+eHCsdw==
Date: Fri, 20 Apr 2018 09:34:04 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 4/4] drm/tegra: plane: Add custom CSC BLOB property
Message-ID: <20180420073404.GK31310@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <cover.1523880381.git.digetx@gmail.com>
 <dac33c4b27107fee37d187d97187431353fe6afc.1523880381.git.digetx@gmail.com>
 <20180417090144.GZ31310@phenom.ffwll.local>
 <3b1c45ee-a48e-0cae-c7bc-b87e792f2b97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b1c45ee-a48e-0cae-c7bc-b87e792f2b97@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 08:31:11PM +0300, Dmitry Osipenko wrote:
> On 17.04.2018 12:01, Daniel Vetter wrote:
> > On Mon, Apr 16, 2018 at 03:16:28PM +0300, Dmitry Osipenko wrote:
> >> This new property allows userspace to apply custom color conversion
> >> coefficients per plane, making possible to utilize display controller
> >> for color adjustments of a video overlay.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > 
> > Same here, this needs corresponding userspace:
> > 
> > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> > 
> > And again there's even more people who discussed extending the existing
> > color management support for crtcs to planes. I think we definitely want a
> > standard interface for this, not each driver doing their own thing.
> 
> Could you please point me to where that discussion is happening?

https://patchwork.freedesktop.org/patch/209469/

is one I've found, but I think there's other efforts.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
