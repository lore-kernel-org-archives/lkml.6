Return-Path: <stern+5b0af0d8@rowland.harvard.edu>
X-Google-Smtp-Source: AB8JxZoAqp5cETnuGz2vF+YuAoWbdr7oc23kLuXgdLVLo+38xbEJoK0VqF9+gBe3dut6OXr/JB32
ARC-Seal: i=1; a=rsa-sha256; t=1526924854; cv=none;
        d=google.com; s=arc-20160816;
        b=rPh1kkmIiubrpuk2nw9ogwAHmr034GxUkextONJzWCx8LloY1N+cy9Dw3rfmiz6DbY
         ymyAMFV9zuVjBIN3I9Gm+3ggKrSsdH3bj6ZI/dyqA7w+4e3ue+1viungRoWnkTbWujwP
         fNNvRU4eTD8H1Y4owxlJs536uyT+B/K/yTHoye/XO21cWHaK4eR02TJKQQ5S/YoQAMxW
         42Zou9Ys9Lq0s1lZQvgUkxp14f3qXv4xMYiSLg7AKDKG8NNkY/c2eppnR5IAtuFmx+LC
         DNJlO3yu0IEtOFDSE7qhKHb3cQF5PrF89Lpc49ysFS7+ibYAKLGNC5Us9b0pFEDyx/yR
         8SSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=uWz8ILXI/JqHoytCdzh00hFWHyjGwRfaHiltkq1xBbs=;
        b=XLbXjh9Youc3BVp8sO1P4nPkDFV55HfmcxsOg83/ee/lkMJtmxLkONjipxFxLeOZN7
         DSF9RcGPA9/Ua1Vk5sFtPOlO+BktaazuGI+DWvdQUWw1HkdI/a6UvfJGSc3zV3aQLRah
         BAV5Sxn4KIhlZh8DHAyFblWL8gyZi9C5mZxzt1cVoTJjuZQ4GJbSVQujipLclJrBgHFa
         ngs+GhZ2uPVoXwHCqndcqIfIDw3/hNr0hSTihrPQj/jPZvr7nBzZe+CiLwX736VKbWVY
         k4Ztq+Z2IGNbIrZnkbqDsrYR4TPiffmp6do4VvJXYTSM8siqvqFSax0roEy6pXd1gaC0
         R1FQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5b0af0d8@rowland.harvard.edu) smtp.mailfrom=stern+5b0af0d8@rowland.harvard.edu
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5b0af0d8@rowland.harvard.edu) smtp.mailfrom=stern+5b0af0d8@rowland.harvard.edu
Date: Mon, 21 May 2018 13:47:33 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Alexander Kappner <agk@godking.net>
cc: oneukum@suse.com,  <linux-kernel@vger.kernel.org>,
     <linux-usb@vger.kernel.org>,  <usb-storage@lists.one-eyed-alien.net>,
     <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] Re: usb-storage: Add quirks to make G-Technology
 "G-Drive" work
In-Reply-To: <1526705416-12573-1-git-send-email-agk@godking.net>
Message-ID: <Pine.LNX.4.44L0.1805211346090.1940-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600652190805149775?=
X-GMAIL-MSGID: =?utf-8?q?1601096756363319241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 18 May 2018, Alexander Kappner wrote:

> v2 of this patch implements the FL_ALWAYS_SYNC flag in the UAS driver, and then
> adds the flag as quirks for the device at issue. This allows the G-Drive to work
> under both UAS and usb-storage.
> 
> Alexander Kappner (2):
>   [usb-storage] Add support for FL_ALWAYS_SYNC flag in the UAS driver
>   [usb-storage] Add compatibility quirk flags for G-Technologies G-Drive
> 
>  drivers/usb/storage/uas.c          | 6 ++++++
>  drivers/usb/storage/unusual_devs.h | 9 +++++++++
>  drivers/usb/storage/unusual_uas.h  | 9 +++++++++
>  3 files changed, 24 insertions(+)

Acked-by: Alan Stern <stern@rowland.harvard.edu>

This is okay with me.  Oliver, what do you think?

Alan Stern
