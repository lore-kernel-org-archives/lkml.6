Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755217AbeDDCic (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:38:32 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:35843 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755098AbeDDCi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:38:28 -0400
X-Google-Smtp-Source: AIpwx4/uuygUEDfsZmwwP6DBDINh3wyiKJmhmNGvIL/XBmTKK5QxDNjyYn0jlwhRohaY0p1tdnk9gGuZlTMwW0XCVEE=
MIME-Version: 1.0
In-Reply-To: <afdf0498-c0a9-936c-0c9b-1b6da6eb5957@lwfinger.net>
References: <CA+A7VXX+z8FrDhzW2BQ6AGMJ=_j_53wkUL_YNgkreEbWSh+jCw@mail.gmail.com>
 <afdf0498-c0a9-936c-0c9b-1b6da6eb5957@lwfinger.net>
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Tue, 3 Apr 2018 19:37:47 -0700
Message-ID: <CA+A7VXWjWaSSUiX3h_rpFXrSwtUkynKR9tpvnsSe=DZrC+mF-Q@mail.gmail.com>
Subject: Re: RTL8723BE performance regression
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Birming Chiu <birming@realtek.com>,
        Shaofu <shaofu@realtek.com>, Steven Ting <steventing@realtek.com>,
        Chaoming Li <chaoming_li@realsil.com.cn>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Daniel Drake <drake@endlessm.com>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        linux@endlessm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w342caTJ008800

On Tue, Apr 3, 2018 at 7:28 PM, Larry Finger <Larry.Finger@lwfinger.net> wrote:

(...)

> As the antenna selection code changes affected your first bisection, do you
> have one of those HP laptops with only one antenna and the incorrect coding
> in the FUSE?

Yes, that is why I've been passing ant_sel=1 during my tests -- this
was needed to achieve a good performance in the past, before this
regression. I've also opened the laptop chassis and confirmed the
antenna cable is plugged to the connector labeled with "1" on the
card.

> If so, please make sure that you still have the same signal
> strength for good and bad cases. I have tried to keep the driver and the
> btcoex code in sync, but there may be some combinations of antenna
> configuration and FUSE contents that cause the code to fail.
>

What is the recommended way to monitor the signal strength?

Thanks for such a quick reply,

--
João Paulo Rechi Vita
http://about.me/jprvita
