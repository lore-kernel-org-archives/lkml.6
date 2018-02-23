Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AH8x226PHupDp7JJNWOgE8NUu4vOBSCJOadaww6VkX7OsM7eWurquT/hMg6oLFRN9ON3e/iorWRZ
ARC-Seal: i=1; a=rsa-sha256; t=1519399576; cv=none;
        d=google.com; s=arc-20160816;
        b=gJLXGtNJmCTZoMmarjledfL/Rkw5ha1U9xVn/8v6zCKkDj32IW2i9HIDLeh9PYRLGv
         yJGDWgIxGuM0b6GATYhdxbosyOGxTuVhohuS/s+ZjYbTO+87DAUQbPQK6eYZyvDCWddI
         Rqp/+RD4LltpF3TZmImuruvICnN3q7/sETyuCYZ6OEQxqpFi0zmfZ9UjYk4HvAdwYdmv
         VMoBxSqrMAttjU+P0zD4qy1XRtKDoy6ykApbP3siDqGa+L36xcC99X4jkWPHzWquCBxV
         og+0+D6W/P2hjGxdCVGTtZxCuEwi24lkVerbJVQjEeB2xiawYYLo0D96sQKptbfMBmwy
         LcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=BEC6cowP0tbrSAIKWMbx8BOtzvh/QipaKU/D5L3Ad4c=;
        b=Npo9LUO0Zd1iIAmT9/JQYcOw7I9WYjM9WVRekVjTSuFblVU46WZr83fDzOp1dVOzfq
         4XLa+yRsYnsc+u6Fhrh6aETAnNQLG205aqhIjsAI7amBVzSqjz+ItSTK3IFIMaF+JapG
         l/tKjum6o7I2eY/uFnBoFaj5Cu/HeYzf8QXo53tsOLFYUOM0Qf9ZseeKzSkJEZEThuzA
         ArqpHtjfVub2B6ymfAg0YR5nCAafN19e2Q9LxEN0KeK2Sr7wNZZMsKEhDVLgKeaQKTmu
         Ncfh+Z6n5odWMsuOP17Ae0T8TZX0cKtxQr3rrHEoq+l64SVY8ARvPfu7TY2agew9Dq5n
         2SqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Fri, 23 Feb 2018 08:26:14 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine
 <alexandre.bounine@idt.com>, Greg KH <gregkh@linuxfoundation.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall
 <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2] Documentation: rapidio: move sysfs interface to ABI
Message-ID: <20180223082614.2d09694b@lwn.net>
In-Reply-To: <20180119123147.GA17446@mordor.localdomain>
References: <20180119123147.GA17446@mordor.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590024066368713946?=
X-GMAIL-MSGID: =?utf-8?q?1593205930551972079?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 19 Jan 2018 18:01:47 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> Right now, the description of the rapidio sysfs interfaces is in
> Documentation/rapidio/sysfs.txt. Since these are a part of the ABI, they
> should be in Documentation/ABI along with the rest.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Applied to the docs tree, thanks.

jon
