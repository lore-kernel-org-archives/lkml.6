Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeBUXVA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:21:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbeBUXU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:20:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888782179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x227TElNHbv0WoT/pCtJ4OCh/ZyiopvWI43bSfEvOdFNZD8wZKJp+RYVo3L29nD2r0Bjgdsz6TlMxxVSi/J1DrNw=
MIME-Version: 1.0
In-Reply-To: <20180220231046.32638-6-laurent.pinchart+renesas@ideasonboard.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com> <20180220231046.32638-6-laurent.pinchart+renesas@ideasonboard.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 21 Feb 2018 17:20:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKv6YvXbpkGbNezTb=C7_kgd8R8NBOSc15PuDrLuMxK1Q@mail.gmail.com>
Message-ID: <CAL_JsqKv6YvXbpkGbNezTb=C7_kgd8R8NBOSc15PuDrLuMxK1Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/16] of: changeset: Add of_changeset_node_move method
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP"
        <linux-renesas-soc@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 5:10 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>
> Adds a changeset helper for moving a subtree to a different place
> in the running tree. This is useful in advances cases of dynamic
> device tree construction.

This one I'm not real clear on when we'd use this and we don't have
any user, so lets drop it for now.

Rob
