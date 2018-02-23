Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeBWGhX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:37:23 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46160 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeBWGhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:37:22 -0500
X-Google-Smtp-Source: AH8x22788heQlqRavoi4gYxqmvPyPcCh8XrBtQsOZE8P7xP1MjdHmh0/I6VRMw/0l7l3uhdivmX7NA==
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
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <1c569896-e60c-bed3-fda8-c72b8d0a349d@gmail.com>
Date: Fri, 23 Feb 2018 08:37:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e4501c0b-0504-e306-19ab-2c6023ad2ccf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 12:23 AM, Boris Ostrovsky wrote:
> On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
>> +static struct xenbus_driver xen_driver = {
>> +	.ids = xen_drv_ids,
>> +	.probe = xen_drv_probe,
>> +	.remove = xen_drv_remove,
>> +	.otherend_changed = backend_on_changed,
> What does "_on_" stand for?
Well, it is somewhat like a hint that this is called "on" event,
e.g. event when the other end state has changed, backend in this
case. It could be something like "backend_on_state_changed"
> -boris
