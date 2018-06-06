Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLiWoNgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 605AB60263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932367AbeFFJzq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:55:46 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38907 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbeFFJzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:55:44 -0400
X-Google-Smtp-Source: ADUXVKJklC6wNIBl0j+A4Z2D5jiyPXK+T52S7CzU5t4dJIFncgREKC0gUXDoC8/t4SaAlqTWC4nxIRVwNKIAbP/Y01A=
MIME-Version: 1.0
In-Reply-To: <CAPybu_2dqG1HX39e+oG8rYvzMG_vGDBQjiLewNjwUvkh+AiF=w@mail.gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-19-ricardo.ribalda@gmail.com> <CAHp75VfFTtysSBvYfmCMoKZz8BpHb73qh=Zy-gpn6RKO2DE-5Q@mail.gmail.com>
 <CAPybu_0zByhDeVf6_Tv_PwU0WL_y6bkVPn0ha+VBvPcxWV4rLA@mail.gmail.com> <CAPybu_2dqG1HX39e+oG8rYvzMG_vGDBQjiLewNjwUvkh+AiF=w@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 6 Jun 2018 12:55:42 +0300
Message-ID: <CAHp75VfZBKTu5XHt5_0eQp6m0Tdyi0H3vNz00c3ok+jgx2By7A@mail.gmail.com>
Subject: Re: [PATCH 18/19] serdev: ttydev: Serdev driver that creates an
 standard TTY port
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 10:47 AM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Hi Andy,
> On Wed, Jun 6, 2018 at 8:58 AM Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:

> I have defaulted the module to n as you suggested. You can take a look
> to the patches that I plan to submit tomorrow at:
>
> https://github.com/ribalda/linux/tree/serdev2

n _is_ default. So, just remove a line.

-- 
With Best Regards,
Andy Shevchenko
