Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167343AbeBOVTW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:19:22 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38048 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162707AbeBOVTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:19:19 -0500
X-Google-Smtp-Source: AH8x227HC+ZlHu6TB8wKMBxgZ3YGZT63UxsEr4ocVr+cBvs4sjXSXr2t/6KVE2Hfo9I0s+xCtgwBSz+eAqoh2bkcFbQ=
MIME-Version: 1.0
In-Reply-To: <7732637c-93bf-fac2-5553-695782890254@xs4all.nl>
References: <1518717336-6271-1-git-send-email-tharvey@gateworks.com>
 <1518717336-6271-8-git-send-email-tharvey@gateworks.com> <7732637c-93bf-fac2-5553-695782890254@xs4all.nl>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 15 Feb 2018 13:19:17 -0800
Message-ID: <CAJ+vNU3G9bJ16npp22O=7k72Pf3xSuQxW-CA2p5cbDq-nSZ4ew@mail.gmail.com>
Subject: Re: [PATCH v13 7/8] ARM: dts: imx: Add TDA19971 HDMI Receiver to GW54xx
To: Hans Verkuil <hverkuil@xs4all.nl>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-media <linux-media@vger.kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 10:36 AM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> On 15/02/18 18:55, Tim Harvey wrote:
>> The GW54xx has a front-panel microHDMI connector routed to a TDA19971
>> which is connected the the IPU CSI when using IMX6Q.
>
> I assume that this and the next patch go through another subsystem for arm
> and/or imx?
>
> Regards,
>
>         Hans
>

Hans,

Yes - Shawn should pick up the two dts patches:
0007-ARM-dts-imx-Add-TDA19971-HDMI-Receiver-to-GW54xx.patch
0008-ARM-dts-imx-Add-TDA19971-HDMI-Receiver-to-GW551x.patch

Shawn you've seen these before but haven't ack'd them - are they good
to merge to your imx tree?

Regards,

Tim
