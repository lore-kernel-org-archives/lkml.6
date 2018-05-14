Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeENHz0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:55:26 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35115 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbeENHzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:55:24 -0400
X-Google-Smtp-Source: AB8JxZpWuyvwZTO/7VCAOhe8xC3rOIqxk8va/V6MAkD3xdPKBm3LE/MNBkyaviDPsxZA9f8rpRR5ESj1wM469mZ0xlo=
MIME-Version: 1.0
In-Reply-To: <20180423152835.GG19834@sirena.org.uk>
References: <20180422230742.3729-1-linus.walleij@linaro.org>
 <20180422230742.3729-13-linus.walleij@linaro.org> <20180423152835.GG19834@sirena.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 May 2018 09:55:22 +0200
Message-ID: <CACRpkdbwuZivVA-vi8vW-a0sSc7HbK3o6xbit0=wCNxVRhjvLg@mail.gmail.com>
Subject: Re: [PATCH 13/18 v2] regulator: wm8994: Pass descriptor instead of
 GPIO number
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 5:28 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 23, 2018 at 01:07:37AM +0200, Linus Walleij wrote:
>> Instead of passing a global GPIO number for the enable GPIO, pass
>> a descriptor looked up from the device tree node or the board file
>> decriptor table for the regulator.
>
> This doesn't apply against current code, please check and resend.

Hm I tried to pull in the series on top of for-4.18 from the regulator
tree, it applied just fine.

No idea what may be wrong, anyways, I will send the v3 now.

I'll create a git branch tested with for-4.18 as well.

Yours,
Linus Walleij
