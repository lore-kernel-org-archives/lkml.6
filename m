Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeBAHUA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 02:20:00 -0500
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:42572 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751119AbeBAHT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 02:19:58 -0500
Subject: Re: [PATCH v6 4/6] media: i2c: Add TDA1997x HDMI receiver driver
To: Tim Harvey <tharvey@gateworks.com>
Cc: linux-media <linux-media@vger.kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
References: <1514491789-8697-1-git-send-email-tharvey@gateworks.com>
 <1514491789-8697-5-git-send-email-tharvey@gateworks.com>
 <1e65ee61-f282-4b53-dd03-68a89a91da8e@xs4all.nl>
 <CAJ+vNU1ysHuzqOnL4sf3hFZrU5kyGnQ0dFkRObVjCa=NyLsJug@mail.gmail.com>
 <517f8b12-e10e-1e8d-6d98-26f5fefe62b8@xs4all.nl>
 <CAJ+vNU1xnnmNZW5zmT8+0HfT3Xfg6zfdrbC8vFNH4wuah5AVTA@mail.gmail.com>
 <fa8cc2d1-b7ea-343e-5b5a-ba5f60b9c5d9@xs4all.nl>
 <83695d60-5052-14ba-4f7b-23f153a05a85@xs4all.nl>
 <CAJ+vNU3DJ2xNEKoi1-div80hKkzsm+pFYtzJDUn+seXAVq8jCQ@mail.gmail.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <a2e873da-adf2-e4aa-71d6-d1c9c2671d41@xs4all.nl>
Date: Thu, 1 Feb 2018 08:19:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU3DJ2xNEKoi1-div80hKkzsm+pFYtzJDUn+seXAVq8jCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPBu4Iqfa0QnAbzVBNONqkWBDLlVtZk/XBEO76pbundQUxcUQeUiCtLfxzpl4eHqwN5kb4YkrypnwYZugnjvB4vdKpsCbqNA2Q+BzKjocJXJ3ittqG7k
 +gTmQGataazYTkD09nL/q2T0M3VenFzvxv8uhY7eft83GBDzQmljx1H8c1vsjem1t/4m7MSGn3BL1/MUncEPamcXrq8qEWd/OBTnYGWNodnGAN4krKJfFd+h
 qMzn6mytjrY61m4yEnHfmV9y5bOqZyz9oFXXxsEB1iPZBSr3yFvU+qfSSyIlm8GAExptzP3RV54UT87vjqNhFMTe2JV8h5C4Nyt828NxtBZniWwsPOhSdd28
 nY2swF2Uj2CPxzM0XAFR4bpu9wyJLPWczfORsv17YZAunlKEWRFv1Ohc4FIoPE2H53VDte34leMS8fxlIdRZnRowGWK+zdinKqBCW22n5PLHrQvqCo4KXeGD
 sr0HQff1mTr6Av0r
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2018 05:47 AM, Tim Harvey wrote:
> Hans,
> 
> You forgot to include v4l2-ctl-selection.cpp in your patch.

You mean v4l2-ctl-subdev.cpp :-)

Anyway, I plan on committing this to v4l2-ctl soon. I'll let you know
when that's done.

I added support for almost all subdev ioctls to v4l2-ctl.

Regards,

	Hans
