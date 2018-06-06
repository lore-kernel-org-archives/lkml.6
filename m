Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6DWJPtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 550B260263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbeFFJ6n (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:58:43 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:41574 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932260AbeFFJ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:58:41 -0400
X-Google-Smtp-Source: ADUXVKLYlK/tbqbEjq5U8MJ9a6TQT0575wueWDySQPM8ph8kkTZZQCgPBro6kLRdnileoGd0zLYnLOaHBUVJPz0I+1o=
MIME-Version: 1.0
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-19-ricardo.ribalda@gmail.com> <CAHp75VfFTtysSBvYfmCMoKZz8BpHb73qh=Zy-gpn6RKO2DE-5Q@mail.gmail.com>
 <CAPybu_0zByhDeVf6_Tv_PwU0WL_y6bkVPn0ha+VBvPcxWV4rLA@mail.gmail.com>
 <CAPybu_2dqG1HX39e+oG8rYvzMG_vGDBQjiLewNjwUvkh+AiF=w@mail.gmail.com> <CAHp75VfZBKTu5XHt5_0eQp6m0Tdyi0H3vNz00c3ok+jgx2By7A@mail.gmail.com>
In-Reply-To: <CAHp75VfZBKTu5XHt5_0eQp6m0Tdyi0H3vNz00c3ok+jgx2By7A@mail.gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Wed, 6 Jun 2018 11:58:22 +0200
Message-ID: <CAPybu_2z-BCgzd00qyMP3aYofKkR6UV8RJC2rPzqzpq4xvbpgA@mail.gmail.com>
Subject: Re: [PATCH 18/19] serdev: ttydev: Serdev driver that creates an
 standard TTY port
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 11:55 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> >
> > https://github.com/ribalda/linux/tree/serdev2
>
> n _is_ default. So, just remove a line.
>

Done. Thanks!

> --
> With Best Regards,
> Andy Shevchenko



-- 
Ricardo Ribalda
