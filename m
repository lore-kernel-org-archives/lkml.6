Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932956AbeCMKvZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:51:25 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33563 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932639AbeCMKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:51:24 -0400
X-Google-Smtp-Source: AG47ELvxAm+VWAy7T7EDwl7grj+t9/1KxdRqtOzIJfuD8OFEeR9sWtQ97NuSGI3McgO1m9mYuCUqzg==
Subject: Re: [PATCH] drm/meson: Add support for DMT modes on HDMI
To: Jerome Brunet <jbrunet@baylibre.com>, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1520935670-14187-1-git-send-email-narmstrong@baylibre.com>
 <1520937363.4264.47.camel@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <2db1d871-2cbf-a2f7-0bea-45e7841ff338@baylibre.com>
Date: Tue, 13 Mar 2018 11:51:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520937363.4264.47.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2018 11:36, Jerome Brunet wrote:
> On Tue, 2018-03-13 at 11:07 +0100, Neil Armstrong wrote:
>> This patch adds support for DMT display modes over HDMI.
>> The modes timings configurations are from the Amlogic Vendor linux tree
>> and tested over multiples monitors.
>> Previously only a selected number of CEA modes were supported.
>>
>> Only these following modes are supported with these changes:
>> - 640x480@60Hz
>> - 800x600@60Hz
>> - 1024x768@60Hz
>> - 1152x864@75Hz
>> - 1280x1024@60Hz
>> - 1600x1200@60Hz
>> - 1920x1080@60Hz
>>
>> The associated code to handle the clock rates is also added.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Looks good to me
> 
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> 

Pushed to drm-misc-next,

Neil
