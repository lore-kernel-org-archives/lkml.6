Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeCCUkw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 15:40:52 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35656 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbeCCUkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 15:40:49 -0500
X-Google-Smtp-Source: AG47ELt+muZkiGKj6hs4WgZ9TfkDw+RoohUUKgvxOlWshlyhMecgTzgYgTf5qeuMhRAoCpxku+7pomDIv61ROWHFHYU=
MIME-Version: 1.0
References: <20180228001525.96044-1-delroth@google.com> <CAHp75VfEaaJfREj5jBk7uwr2aRL96JN4Co=tir9Foy6L9=_o8A@mail.gmail.com>
 <20180303153723.40773aae@archlinux> <CAHp75VeEXdUMw2Skr=jDjUL+Rz=Xu-0S3Mw-X6MvjAXet974hw@mail.gmail.com>
 <20180303161507.2f60345f@archlinux>
In-Reply-To: <20180303161507.2f60345f@archlinux>
From: "Pierre Bourdon (delroth)" <delroth@google.com>
Date: Sat, 03 Mar 2018 20:40:37 +0000
Message-ID: <CANEr7oXzWGc0qOTNrFkP8vY4CAFG=Q4WNNpsBcQyU8CxUd9=MA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: light: add driver for bh1730fvc chips
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 3, 2018 at 8:15 AM Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 3 Mar 2018 17:44:44 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> > On Sat, Mar 3, 2018 at 5:37 PM, Jonathan Cameron <jic23@kernel.org>
wrote:
> > > On Wed, 28 Feb 2018 17:06:09 +0200
> > >> On Wed, Feb 28, 2018 at 2:15 AM, Pierre Bourdon <delroth@google.com>
wrote:
> >
> > Better to address even minors before submission.

> Absolutely.

Agreed. I'll be sending a hopefully final v4 addressing these next week.
I'm giving v3 just a bit more settle time in case anyone else has comments.

Best,

-- 
Pierre Bourdon (delroth@)
