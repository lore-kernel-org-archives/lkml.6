Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4/sFeTZNsRap6A5h8vWpKavJYIk2ni9sP7AaK0fAlkPNJRUv36JXEf0h+OqHZN4icLaczCT
ARC-Seal: i=1; a=rsa-sha256; t=1524424476; cv=none;
        d=google.com; s=arc-20160816;
        b=u3exMd0k/krPyLMyc7GiFdYuGU2hZ37fisBgY7jewGakm1PbDp8/swFK8GkV+aKKhC
         Dc2Mfji0KoLjP3sUbf7gn599V0yTjXfm5DIud8uHszxeQZM467MaAPMBapJ7uDXQA/zH
         dHVUPyZgrBQpKUOKQRjZ95Iiryckr4o59Y39Q5oX6XE7ByCR4/Dyp6g7EPK5pppz6VSY
         goqtFevygszaFD44IU+yrSZs4WKiAuNaHyHc/6VcdmnBJBnHw2DPDpZO4OT2UpoqUgCZ
         llNIoUm5JCzYvXH1BKIyouEN69EXLHXzNEldYmDPO+Lr9sNBCzHPkAC/iJTeLsuY9BKr
         JNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=1GoWtE4eBN5u77gM00o+jNcCRTxAlTOA/AMU8FxbN84=;
        b=TRl5QKb1Pb0wSoVvbd7OZnyrMsKWvQgRqo9UqE+NxGL7IQfNdYyg398vyok94vQ1zT
         PPh7uRGdAOkrpSnQDt2vN87NjsQNUIyG+9K3LjXS4HS8/8aXmn1BepBvc5+qB4FYF+ky
         zW4zdt81gZHeDvm2YD8ZFYNk5B447uDzPqpKHfAVCs/a7bbs9OL9CmGAJQuyKT9q3nkc
         mJgC6bUHp86FavvwwGOJ73VIeSpR+WVbQRtA2jTnROYwRcWfSLo9M7sVwnUmntAGFD4N
         dNtI5NFi5f2kdVr+EvjcD9RkaxOy3M5wWqsOPurDeD/9u/vBwV1haD5JyMeO2zi8l3s+
         oN6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Sun, 22 Apr 2018 21:14:32 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
cc: Yixun Lan <yixun.lan@amlogic.com>,
    Neil Armstrong <narmstrong@baylibre.com>,
    Philipp Zabel <p.zabel@pengutronix.de>,
    Kate Stewart <kstewart@linuxfoundation.org>,
    Greg KH <gregkh@linuxfoundation.org>
Subject: dt-bindings: Invalid SPDX License Identifier
Message-ID: <alpine.DEB.2.21.1804222108120.6136@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598474920059002037?=
X-GMAIL-MSGID: =?utf-8?q?1598474920059002037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Yixun,

commit c16292578ffa437c77e17d5d3da20330a10b8a86
Author: Yixun Lan <yixun.lan@amlogic.com>
Date:   Fri Nov 10 16:46:49 2017 +0800

    dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller
    
    Add DT bindings for the Meson-AXG SoC Reset Controller include file,
    and also slightly update documentation.
    
    Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
    Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Added the following SPDX-License-Identifier: (GPL-2.0+ OR BSD) in the
middle of the top of file comment.

There are two problems with that:

1) BSD is not a valid SPDX identifier. See https://spdx.org/licenses/

   You need to say which BSD variant you mean.

2) Please put the License identifier to the place which is defined in
   Documentation/process/licenses.rst, i.e. the first line of the dts file
   and not to some random place.

Thanks,

	tglx
