Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeDEXvb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 19:51:31 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:43795 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEXv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 19:51:29 -0400
X-Google-Smtp-Source: AIpwx48gdKU3p23mrEBDkEJy6lRp8EZe/avsehNwRk+rvajem0zBBvcQWXuB4RDCg2oEmrMIFtVsRQ==
Date: Thu, 5 Apr 2018 16:51:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, kt.liao@emc.com.tw
Cc: Oliver Haessler <oliver@redhat.com>, Benjamin Berg <bberg@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Input: support for latest Lenovo thinkpads (series
 80)
Message-ID: <20180405235126.GB57189@dtor-ws>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Thu, Apr 05, 2018 at 03:25:29PM +0200, Benjamin Tissoires wrote:
> Hi Dmitry,
> 
> well, this year, Lenovo gave us a surprise and decided to not use
> the same touchpad/trackstick in all its model. And by default, the
> support under Linux is less than ideal.
> 
> Please find a series that should fix those issues. Compared to the 60
> series, there do not seem to e BIOS table issues this time, and suspend/resume
> works fine thanks to your latest trackstick fixes.
> 
> The T480s is a different beast, as it uses an Elan touchpad.
> I have been carrying the patches 3-6 for a while and tested previous
> versions on various Elan PS/2 hardware without an issue as far as I
> could tell. I was lacking tests from users with SMBus as all the laptops
> I tried where puer PS/2.
> 
> Anyway, it would be cool if you could have a look at the series.

I am mostly happy with the series, but I would love to hear KT's take on
it.

Thanks.

-- 
Dmitry
