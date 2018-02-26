Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeBZKT6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:19:58 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:45628 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeBZKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:19:55 -0500
X-Google-Smtp-Source: AG47ELtx7p6blFU6c/eKwPs3z04NHWUOvEueQSYVwUyGkZTFdK5ynIc1qyQlbplgu19nx0sWrz8KLPo3yis6E74/moA=
MIME-Version: 1.0
In-Reply-To: <20180219133038.21995-2-ckeepax@opensource.cirrus.com>
References: <20180219133038.21995-1-ckeepax@opensource.cirrus.com> <20180219133038.21995-2-ckeepax@opensource.cirrus.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Feb 2018 11:19:54 +0100
Message-ID: <CACRpkdY_Z-sNRf=D8zn1V3G5C6cnfwVaTmQzH7OyEaF4yNuDoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mfd: arizona: Update DT doc to support more
 standard reset binding
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 2:30 PM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>
> Changes since v1:
>  - Drop vendor prefix from new binding since it is a standard property.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
