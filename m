Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbeCEUJ3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:09:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeCEUJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:09:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E166521777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELuP/pWMrJcN8fQ5WqDmZMUTtu0t3HjA9rbgjQoDT5HVadyx8KZ1qUffFMln/uu22spO5rwknR6QqfzcyUPBZiU=
MIME-Version: 1.0
In-Reply-To: <617f14dc-63f7-e59c-4fa8-813b4ebd3c34@gmail.com>
References: <617f14dc-63f7-e59c-4fa8-813b4ebd3c34@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 5 Mar 2018 14:09:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKiV=-r-sf-_TwP4UBcUEj69Y+YZrwFBLZwxH7KUE7k2g@mail.gmail.com>
Message-ID: <CAL_JsqKiV=-r-sf-_TwP4UBcUEj69Y+YZrwFBLZwxH7KUE7k2g@mail.gmail.com>
Subject: Re: [GIT PULL] of_overlay_fdt_apply() v7 for 4.17
To: Frank Rowand <frowand.list@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ivan Gorinov <ivan.gorinov@intel.com>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 4, 2018 at 2:48 AM, Frank Rowand <frowand.list@gmail.com> wrote:
> Hi Rob,
>
> Please pull the changes to create the overlay FDT apply API.
>
> This is the v7 changes.

Pulled. Thanks Frank.

Rob
