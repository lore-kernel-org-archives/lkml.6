Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965082AbeEIPnY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:43:24 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33340 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935362AbeEIPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:43:22 -0400
X-Google-Smtp-Source: AB8JxZoRzjzf6MD5Z9V2xeszJgPG0IxtFIb4fzIHYnKNxfHPZfKXZ3ge5R0eOuOBQCkuoy9E0R3Y0hZNFX/a0fqUmM4=
MIME-Version: 1.0
In-Reply-To: <20180509153933.2233-1-lukma@denx.de>
References: <20180410102927.17787-1-lukma@denx.de> <20180509153933.2233-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 9 May 2018 12:43:20 -0300
Message-ID: <CAOMZO5CEojwRGYqDNjXhbLcRrmd5VXyKTdxbdMfLw2bb8vgfnQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] display: panel: Add AUO g070vvn01 display
 support (800x480)
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Wed, May 9, 2018 at 12:39 PM, Lukasz Majewski <lukma@denx.de> wrote:

> +Example device-tree definition when connected to iMX6Q based board
> +
> +       lcd_panel: lcd-panel {
> +               compatible = "auo,g070vvn01";
> +               backlight = <&backlight_lcd>;
> +               bus-format-override = "rgb565";

Please remove this property as it is not documented nor used anywhere.
