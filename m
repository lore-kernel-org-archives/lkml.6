Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423454AbeE1MWP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:22:15 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:43767 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938694AbeE1MWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:22:04 -0400
X-Google-Smtp-Source: AB8JxZopL/Dw1LWRE4n+oEG66pMX4jNtCYkbcWZuuNgSvASVmZzdjgXpzET9sBWs2jXNeWmeVI2MRg==
MIME-Version: 1.0
References: <20180517095349.203865-1-keiichiw@chromium.org> <a618b1b5-48ac-f725-39a6-50ba81b167f0@xs4all.nl>
In-Reply-To: <a618b1b5-48ac-f725-39a6-50ba81b167f0@xs4all.nl>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 28 May 2018 21:21:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AR=At5n=_ZyB_LM8cV6Mw5H5cqBqAH7-b6JUeE0b8Q9g@mail.gmail.com>
Message-ID: <CAAFQd5AR=At5n=_ZyB_LM8cV6Mw5H5cqBqAH7-b6JUeE0b8Q9g@mail.gmail.com>
Subject: Re: [PATCH] media: v4l2-ctrl: Add control for VP9 profile
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Keiichi Watanabe <keiichiw@google.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>, keiichiw@chromium.org,
        smitha.t@samsung.com, viro@zeniv.linux.org.uk,
        andriy.shevchenko@linux.intel.com, ricardo.ribalda@gmail.com,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Fri, May 25, 2018 at 6:09 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:

> On 17/05/18 11:53, Keiichi Watanabe wrote:
> > Add a new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for selecting desired
> > profile for VP9 encoder and querying for supported profiles by VP9
encoder
> > or decoder.
> >
> > An existing control V4L2_CID_MPEG_VIDEO_VPX_PROFILE cannot be
> > used for querying since it is not a menu control but an integer
> > control, which cannot return an arbitrary set of supported profiles.
> >
> > The new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE is a menu control as
> > with controls for other codec profiles. (e.g. H264)

> I don't mind adding this control (although I would like to have an Ack
from
> Sylwester), but we also need this to be used in an actual kernel driver.

> Otherwise we're adding a control that nobody uses.

Indeed. We were supposed to also include a patch for mtk-vcodec driver, but
somehow it went MIA. Keiichi will add it in next revision. Thanks for
giving this a look.

Best regards,
Tomasz
