Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeFENgL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:36:11 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45223 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbeFENgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:36:09 -0400
X-Google-Smtp-Source: ADUXVKLvLF4J+BacHaUIDTohf9xrkOmCjwjhK6g9NxiOIksDnYVqwM5i3KTf0APylua3CRvA8ZHP8fQzXeV6hYsWmTg=
MIME-Version: 1.0
In-Reply-To: <20180529131014.18641-5-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com> <20180529131014.18641-5-ricardo.ribalda@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 16:36:08 +0300
Message-ID: <CAHp75VfTkRiwioxg-65wgX9q9cpFQPWj3GqUZc-VobNwPUs2tA@mail.gmail.com>
Subject: Re: [PATCH 04/19] Bluetooth: hci_nokia: Add serdev_id_table
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 4:09 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Describe which hardware is supported by the current driver.

> +static struct serdev_device_id nokia_bluetooth_serdev_id[] = {
> +       { "hp4-bluetooth", },

> +       {},

Terminator line better w/o comma.

> +};



-- 
With Best Regards,
Andy Shevchenko
