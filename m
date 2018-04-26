Return-Path: <kstewart@linuxfoundation.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524752696; cv=none;
        d=google.com; s=arc-20160816;
        b=lI8Expg2et+xp9zGbW6vYNkoRoDfVcXNLdnznIZ6gphQlICbtBflgJJXaDwYVxxkCP
         DlQwHx++1vGZXOMXVQ4d+NAosMcd9VxP7odLfo7tT7woXGdBdEDjZWY+8KDgvF4YXEUI
         Vnif+EYUKfTHesZROz92lP44CghdeRCqnKgiH/eE5wq00+hU1Y+v/uJ6kmDoLin2Hnx+
         Ca8w9nnFoehSnws+q0p4/cYKz9LFtnKq82ztETsVuHXeIhG/xEAJ0bo67YELjG+wOY1C
         TvgFWfSORj1iIWsOGU7cW5FDcMc1NCtPK11tm+q5vdlBonVmIrNn7Y3Vk7S096RuubwG
         XbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=h1NR3xlWDp5MFqsHgxACIuioR9C70lWXyokTiBqiBDQ=;
        b=aV1VAmkM5o6e/GaTnd+5A4NeAgBeWhHtAG2lwEfi2cBL5yZuexLPEgZxRbUrxpmDBw
         6S4w9AAiIFKe4X+hcJlBKes0+Hgajb71B5tPJwVBQoTSfydZIKpYoKMaSQ/PDLN3Hmi4
         npg12yCP8LclUnXzDKew689y/9I3VV4UTcId54BArLHS0/thjuYGwFs8K+Vxy0C1T6+K
         xR/s5I+6SvH36gbxAMjsmKIrmBEoQAP/dHFi6hNazQB6S1HmTFqNfV+Ved1RXnludPQC
         ub5S8ImamLu1hHM9qslU8sAaZeXk90x11ViwLgeNjKGJuXqUEObFnLfemXbnR6K0BE2s
         fucA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dkCJ46gQ;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dkCJ46gQ;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
X-Google-Smtp-Source: AB8JxZoE7okWdc2+0MX1mPCRTAR9Vd6QqOn8l+RnKXmH4prki61mFOdThYmYk23gkixekRxevzkllMf2C21SPQaQcao=
MIME-Version: 1.0
In-Reply-To: <20180425203703.568152337@linutronix.de>
References: <20180425203020.594959448@linutronix.de> <20180425203703.568152337@linutronix.de>
From: Kate Stewart <kstewart@linuxfoundation.org>
Date: Thu, 26 Apr 2018 09:24:55 -0500
Message-ID: <CAG_66ZQLpyWscr1A9JM_mOWHmuqRcF27yE7BfAusLVFuiY5HcQ@mail.gmail.com>
Subject: Re: [patch V2 6/7] LICENSES: Add Linux-OpenIB license text
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598752951603652171?=
X-GMAIL-MSGID: =?utf-8?q?1598819083485428124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 3:30 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> The infiniband code uses a variant of the OpenIB license. This license is
> BSD-2-Clause with the MIT disclaimer. The linux kernel uses this license
> extensively throughout the driver subsystem since 2005. Note that the
> OpenIB.org license is a true match to BSD-2-Clause.
>
> The license text was copied from:
>
>     https://spdx.org/licenses/Linux-OpenIB.html#licenseText
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>
