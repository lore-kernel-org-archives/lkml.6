Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755494AbeDWPKA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:10:00 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35352 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755385AbeDWPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:09:58 -0400
X-Google-Smtp-Source: AIpwx48m10u6p8JiLOVFSzhJKcd/X7NEJ8L+RzP8RPJfAcE91ytpmdaYeO+br43kxLSg6KE8hsMBzA==
References: <20180419110056.10342-1-rui.silva@linaro.org> <20180419110056.10342-2-rui.silva@linaro.org> <CAOMZO5A3+WMu+U5STP-z3qdXnUQN2yTJne2OV9-SrEs70JJyDA@mail.gmail.com>
User-agent: mu4e 1.0; emacs 25.3.1
From: Rui Miguel Silva <rui.silva@linaro.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rui Miguel Silva <rui.silva@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ryan Harkin <ryan.harkin@linaro.org>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] media: ov2680: dt: Add bindings for OV2680
In-reply-to: <CAOMZO5A3+WMu+U5STP-z3qdXnUQN2yTJne2OV9-SrEs70JJyDA@mail.gmail.com>
Date: Mon, 23 Apr 2018 16:09:55 +0100
Message-ID: <m3wowydkn0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,
Thanks for the review.

On Mon 23 Apr 2018 at 14:11, Fabio Estevam wrote:
> Hi Rui,
>
> On Thu, Apr 19, 2018 at 8:00 AM, Rui Miguel Silva 
> <rui.silva@linaro.org> wrote:
>
>> +Optional Properties:
>> +- powerdown-gpios: reference to the GPIO connected to the 
>> powerdown pin,
>> +                    if any. This is an active high signal to 
>> the OV2680.
>
> I looked at the OV2680 datasheet and I see a pin called XSHUTDN, 
> which has
> the following description:
>
> XSHUTDN: reset and power down (active low with internal pull 
> down resistor)
>
> So it should be active low, not active high.

Yes, you are correct, I will fix this, and the dts entry.

Thanks.

---
Cheers,
	Rui
