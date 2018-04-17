Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDQTSK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 15:18:10 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:43156 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeDQTSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 15:18:07 -0400
X-Google-Smtp-Source: AIpwx4/Zrn6eNdZl/DnFOwwBK44LUgfb7CUeDNJejQfQxVuI4Y3vugg3J+htHRoL0fY6FOC2yRgBwHK8VQnwelz3avY=
MIME-Version: 1.0
In-Reply-To: <20180414062718.3tbsdb6jhjurpfta@katana>
References: <20180412213342.138010-1-hansens@google.com> <20180412222457.x4jdwt27ylgi74o3@katana>
 <20180413141359.793919fb@endymion> <CAP9bUy7rONNHYeRkYtaWHcfqoZcGKXJz-JocED26zBj9n+-ZbQ@mail.gmail.com>
 <20180413204937.440437e9@endymion> <CAP9bUy6Hf+cQzAAckou3QPTk0mJM4xJ4xq-hf+RwyVmD3Le+qg@mail.gmail.com>
 <20180414062718.3tbsdb6jhjurpfta@katana>
From: Sam Hansen <hansens@google.com>
Date: Tue, 17 Apr 2018 12:17:46 -0700
Message-ID: <CAP9bUy6jiGpTGkRnUVM9mJO-pf=n=6AkSYLH_SiqOON4bG=WoQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/i2c: sync docs with current state of i2c-tools.
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 11:27 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> (also, did I send the v3 patch series threaded correctly?)
>
> Yes, that worked. Thanks!
>
> Things to improve there: I was both in To: and CC: field, so I got mails
> twice. Jean was missing completely.

Ah, thanks.  I had been using scripts/get_maintainer.pl to determine
the CC list, I'll make sure the right people are on the cc line in the
future.


>
