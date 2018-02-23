Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeBWOvH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:51:07 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41064 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:51:06 -0500
X-Google-Smtp-Source: AG47ELvYBa/q1IsxmghHh6m0zxyCHIPtbbmBhgX8S6mJkfACaIlYd7/5lYhTQ/LUneSVIkTXz64H5g==
Subject: Re: [PATCH 1/9] drm/xen-front: Introduce Xen para-virtualized
 frontend driver
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-2-git-send-email-andr2000@gmail.com>
 <e4501c0b-0504-e306-19ab-2c6023ad2ccf@oracle.com>
 <1c569896-e60c-bed3-fda8-c72b8d0a349d@gmail.com>
 <3740a458-35d7-b51d-5cd0-be3bebd87574@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <e910c309-9711-99f9-4d21-5bd77ffe70b8@gmail.com>
Date: Fri, 23 Feb 2018 16:51:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3740a458-35d7-b51d-5cd0-be3bebd87574@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 04:39 PM, Boris Ostrovsky wrote:
> On 02/23/2018 01:37 AM, Oleksandr Andrushchenko wrote:
>> On 02/23/2018 12:23 AM, Boris Ostrovsky wrote:
>>> On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
>>>> +static struct xenbus_driver xen_driver = {
>>>> +    .ids = xen_drv_ids,
>>>> +    .probe = xen_drv_probe,
>>>> +    .remove = xen_drv_remove,
>>>> +    .otherend_changed = backend_on_changed,
>>> What does "_on_" stand for?
>> Well, it is somewhat like a hint that this is called "on" event,
>> e.g. event when the other end state has changed, backend in this
>> case. It could be something like "backend_on_state_changed"
> If you look at other xenbus_drivers none of the uses this so I think we
> should stick to conventional naming. (and the same applies to other
> backend_on_* routines).
ok, no problem. will rename to be aligned with other frontends
>
> -boris
