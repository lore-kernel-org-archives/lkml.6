Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeFESpu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:45:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51042 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeFESpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:45:49 -0400
Subject: Re: [PATCH v2 5/8] Input: cros_ec_keyb - Switch to SPDX identifier.
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-input@vger.kernel.org
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-6-enric.balletbo@collabora.com>
 <CAOMZO5ByhMV9_gRHLmGiSNJtCvKEOk==ZMz2O2=tokZh2ps4xg@mail.gmail.com>
 <7085d0bb-557c-0796-d3ae-756e000a7950@collabora.com>
 <CAOMZO5Cod=jo5gC1ibQx5ZHU5xtUZDvfZt899=nPLgH4bhy+_g@mail.gmail.com>
 <20180605182919.GF202428@dtor-ws>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <776dc8b6-aa98-aeb0-320a-04294894ad2e@collabora.com>
Date: Tue, 5 Jun 2018 20:45:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605182919.GF202428@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 05/06/18 20:29, Dmitry Torokhov wrote:
> On Tue, Jun 05, 2018 at 03:16:40PM -0300, Fabio Estevam wrote:
>> Hi Enric,
>>
>> On Tue, Jun 5, 2018 at 3:14 PM, Enric Balletbo i Serra
>> <enric.balletbo@collabora.com> wrote:
>>
>>> Right, but the module license is set to GPL which means GNU Public License v2 or
>>> later, see [1]. So, there is a mismatch. In such cases I assumed GPL-2.0+ as the
>>> default. These mismatches are common so I think that should be fine for the
>>> authors, if someone is disagree just let me know and I will change.
>>
>> Ok, but I think you should add this explanation in the commit log to
>> make it clearer.
> 
> If there is a conflict between the license notice and MODULE_LICENSE()
> we should go by the license notice. The license note is usually approved
> by companies, whereas MIODULE_LICENSE()s get moved, adjusted, etc.
> 
> For ChromeOS kernel changes license notice is GPL v2 as documented at:
> 
> https://www.chromium.org/chromium-os/how-tos-and-troubleshooting/kernel-faq
> 
> section "Which copyright header should I use?"
> 

Many thanks to share and clarify this.

There is lots of mismatches so I'll send another version fixing this and
changing all to GPL v2. I assume I should also modify the MODULE_LICENSE when
it's wrong.

Thanks.
 Enric

> Thanks.
> 
