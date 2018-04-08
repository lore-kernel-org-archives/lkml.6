Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx49JlZzDh7O7OVn3mTE70mhaGU5Cv4FHAdUpd9vHreLYsOozHWlaw57+dqolknQOjehCNtab
ARC-Seal: i=1; a=rsa-sha256; t=1523195468; cv=none;
        d=google.com; s=arc-20160816;
        b=S3U51KgGkLgIJrg9kJ9vL1b4OYA5tZeoqvd0JN71LRxLPXeJKpQzP054BJ7uPVWBFp
         lYWBI6AwVDAd+mz/efNV2OqPlzgqVDhlQ2eOJLtJSKkcIAFGHbKcY5RCvCszwwK4LBzz
         TAN+jhUnyXwD9SMecssca1kkTtGUh2yI0hQUG7LRPY3lFloWmqwvUIMptnnnEzelt0Um
         3hvxsnaN+ynVvS2iK7b22Sw3Pk8Iyf9/9t1Z8Npedk8PIj3nIzscoTHDleSLjul4CDzQ
         JuQ8I/lI3mg9K3fDozoZl1+TmGbZeXYAxjsn+WlGbkZS9DdGHBk6RY9eYG9gb8y0pCjt
         3bDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=qWneuZWJta6gSj/v0xKl2kwQKmYR7j/hoWBP/sxEX1I=;
        b=gxTg9erdPya+xUqKQKHKbLRFjxFI2rW3DQkuADZV9xgtmgt110xtc4rYi1GGJXBxwf
         KBvR49sa7CFzbuPHEOSZp/EASJneHH74/VbPC5Nmg2eYToEYNVg9sL+3EhQFRSHKfhFG
         51na/Ef5B3JPl6r3poHmaaFk8rQpux5s3rC0RkbQHetU4xqN3TH6fOXeP++/iT5A26Ah
         jL1xbBp3IS8V365txJk1WgGrsW6Iqd8UTmf/HFEX9oIIHxrZcmVZki+sDE+NrwOu1WFI
         9IWCXZYlWO/SgeWsV+lnzcn8UzaXQuhBXV4i120Bc+dHIE3MHc/JAAZ7CZR755js8u+R
         okfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Sun, 8 Apr 2018 13:51:04 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: Fix firmware documentation for recent file
 renames
Message-ID: <20180408135104.GG30543@wotan.suse.de>
References: <20180408134749.16871-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408134749.16871-1-hdegoede@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597186005083902615?=
X-GMAIL-MSGID: =?utf-8?q?1597186211648339916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 03:47:49PM +0200, Hans de Goede wrote:
> firmware_class.c was split into several files under
> drivers/base/firmware_loader. The new main.c has the functions which
> /request_firmware.rst references.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis
