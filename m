Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeFCIFa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 04:05:30 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41899 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeFCIF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 04:05:27 -0400
X-Google-Smtp-Source: ADUXVKKq3LcXmOJr9Tw11bV5FO5JEgfinNpf+8GYB9zttIk7OrZapYHTya4rcqtWX4YpI4N9X/9qNNAZw6G83XqnwUM=
MIME-Version: 1.0
In-Reply-To: <20180602023215.176521-1-ravisadineni@chromium.org>
References: <20180602023215.176521-1-ravisadineni@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 3 Jun 2018 10:05:26 +0200
X-Google-Sender-Auth: WrxGVoJO4eIflNu_8Spzjfv8Pks
Message-ID: <CAJZ5v0gWeq034sObmHsbJoiBri4a=Av8xroeuW+eqyv_W=cHjQ@mail.gmail.com>
Subject: Re: [PATCH] power: Print wakeup_count instead of event_count in the
 sysfs attribute.
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, chenhong3@huawei.com,
        Pavel Machek <pavel@ucw.cz>, ravisadineni@google.com,
        Dmitry Torokhov <dtor@google.com>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tbroch@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Rajat Jain <rajatja@google.com>,
        bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 2, 2018 at 4:32 AM, Ravi Chandra Sadineni
<ravisadineni@chromium.org> wrote:
> Currently we show event_count instead of wakeup_count as part of per
> device wakeup_count sysfs attribute. Change it to wakeup_count to make
> it more meaningful.

More information, please.

In particular, why it is more meaningful.

Thanks,
Rafael
