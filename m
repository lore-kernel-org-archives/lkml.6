Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AB8JxZrH6w+7knov/96GjfepH5YdAO5ANaKLpMjU7HMvxAqyCpFOq6KBV1fFMtqp0iY97AYhLXIm
ARC-Seal: i=1; a=rsa-sha256; t=1525375271; cv=none;
        d=google.com; s=arc-20160816;
        b=gKPs3532h3Dq2JLq4hndmw8lsMV0H0etIkqQ+CBeN6eP1qF4v+wrHjdgnnamifXlD4
         Qc3/pOfSEUuAVgawLxXNc74i4uzANjfyZBJaNyw+7He7OgGLBEkz0XqeqNjEAQEdXSjL
         tohVivQyO+qiWzEdzMWDBRe49Fe6Dx0Ee75fpvJPzeWz2T3ki8UgW5CcnIomiwh+kvGo
         jL0k7ra1qrr5ZvAaZ0ATq9Ft2GuNZ1xIwYN2BRRgCAq35KMJccHnpR/72TL6IU3yZ4Jk
         oZLxpPtfrGWaIDlb2RqV6j/JadHLbP9HaekSz55VJBCpaWg4Wle1YXPzD3ZYOc2lqDe8
         y0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2e4Ccfi+Yqhm6xPJk6B4ZXad66imChch6kK4sNZJeJQ=;
        b=UzKUTIxWAXYzqz9wfXPSVcznXC1fgS8Dmd9D2JSaBAPJAacI/qC0wBz9KlZgMOmYs6
         AT+AF3lk3ubqPvsaxEgRLn+n0WmHgVjGxL8KEX00zHQx9E3er4bcJCDfodniOH6Iwe7W
         YFLB7Uwv/qP7mPLrg4tyKDsdDpWn9GcsBhQYsDxG+H7+vk9cmW20cqGFL98zI+TqWElc
         8U9Lpp5ZJIfG5ekIhGSmfMibCPl9WfObe2dR0/1vAUJKkT23VaMIokp+4by/KFXPKXQh
         rrlpAplK9xzTNTOGT2CofI+Ix6XEykaf6oAZYT9ZeovZlwDqzjGO5qd3jODpEbYFLvs9
         gnAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Thu, 3 May 2018 21:21:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sujeev Dias <sdias@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Tony Truong <truong@codeaurora.org>
Subject: Re: [PATCH v1 1/4] mhi_bus: core: Add support for MHI host interface
Message-ID: <20180503192110.bjd46afhe2ein3qm@devuan>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864306474861315?=
X-GMAIL-MSGID: =?utf-8?q?1599471900768346893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi!

> MHI Host Interface is a communication protocol to be used by the host
> to control and communcate with modem over a high speed peripheral bus.
> This module will allow host to communicate with external devices that
> support MHI protocol.

I have Motorola Droid 4 cellphone here, with Qualcomm GSM modem. But
it talks over serial line and USB. I guess MHI is not applicable to my
hardware?

> +MHI Devices
> +-----------
> +Logical device that bind to maximum of two physical MHI channels. Once MHI is in
> +powered on state, each supported channel by controller will be allocated as a
> +mhi_device.

What kind of protocol is running over MHI? I guess its not AT
commands. QMI? Or something entirely different?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
