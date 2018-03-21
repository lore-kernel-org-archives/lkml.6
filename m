Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AG47ELtU5wTbtunszXm4gbsGmUtsQbio0kgzTMXdyATV5JjNyowOsMlrhK+GqERLRFQYdwkkNvWm
ARC-Seal: i=1; a=rsa-sha256; t=1521646109; cv=none;
        d=google.com; s=arc-20160816;
        b=T59ZnEqu7+RFU3DyoBuwboSN8N+897KIH7bNMzZ0X2wFWtJHnIqhDM/bPEkCpD4ork
         QMtudCQSUXmRY/341hwng278OeZ5LJDH9/8rkyFnItxBCKX5pQUSXwT/llRH+qcrHcDy
         nzNgcnnc5xd/3eyyh6Nr/TSH6pTeASH+tlZM5ArwLoGxxtfL6OpDvzXuSIwUA6HBxm/R
         Nci2WuG96Xv7ZJvnQSGvpOKr8E8AziDXWoxCb123IO2vw2N6MNmjy9K+BLFVrmc0HxhE
         ruNF8Q2z7EvgbpuzgdC2wn15/dASraabn+c07mgZPyXHcD8PiFUwQv0n5yHNCjnApRne
         vf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=ChTsNfLERBQFGHMHcXcbAst3Kirvyg4ZL+ZqlCcIM3Q=;
        b=EpfxrJmWWrA27Tz1W0kES64d4xFdsIx/eXt2aKUE3No+4DmQGpQzrB0m2ll7I8EX+I
         IOvoOZS/GPfzNUtNDX8LwB7RF/xchb05Ky/MhS37kxwcTMReEDjwpYVfZbT+FiO29RX7
         vHBVk6SsjLut9Ik7Acudz1DKRmJwvQoTd0lfaDo8YCn9a1L07hh2STS532fcTWMgziAV
         5eMSHRV8ESl+4svWRgv5i1wlfcvZH6m8mCsuo7TE+kTs8BapUhvYG548jPi+m6hBcM8M
         rTwVUhC/2Xdo0sQYecxVl55nVtFZfZWXvHHUuWsWQ1wdEt8mQEivQepC/ce+wAlPg989
         zehA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Wed, 21 Mar 2018 09:28:27 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Julia
 Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: document sysfs interface
Message-ID: <20180321092827.70d42bf6@lwn.net>
In-Reply-To: <20180302131653.GA24934@mordor.localdomain>
References: <20180302131653.GA24934@mordor.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593831975590179411?=
X-GMAIL-MSGID: =?utf-8?q?1595561590565566956?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Mar 2018 18:46:53 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> Descriptions have been collected from git commit logs.

Applied to the docs tree, thanks.

jon
