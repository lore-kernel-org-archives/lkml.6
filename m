Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeBUXj5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:39:57 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:54729 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeBUXjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:39:55 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Rob Herring <robh@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
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
Subject: Re: [PATCH v4 05/16] of: changeset: Add of_changeset_node_move method
Date: Thu, 22 Feb 2018 01:40:37 +0200
Message-ID: <3673151.DffhUaZ7xV@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAL_JsqKv6YvXbpkGbNezTb=C7_kgd8R8NBOSc15PuDrLuMxK1Q@mail.gmail.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com> <20180220231046.32638-6-laurent.pinchart+renesas@ideasonboard.com> <CAL_JsqKv6YvXbpkGbNezTb=C7_kgd8R8NBOSc15PuDrLuMxK1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thursday, 22 February 2018 01:20:36 EET Rob Herring wrote:
> On Tue, Feb 20, 2018 at 5:10 PM, Laurent Pinchart wrote:
> > From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> > 
> > Adds a changeset helper for moving a subtree to a different place
> > in the running tree. This is useful in advances cases of dynamic
> > device tree construction.
> 
> This one I'm not real clear on when we'd use this and we don't have
> any user, so lets drop it for now.

OK, no problem.

-- 
Regards,

Laurent Pinchart
