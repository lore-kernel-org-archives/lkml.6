Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AB8JxZry5H8apEgAHyTpsr/PLTeuMKaiShNuZgPclGBDMYG2Cg7bg9vFih/WjY5FUX2JM3G+GFUp
ARC-Seal: i=1; a=rsa-sha256; t=1524828636; cv=none;
        d=google.com; s=arc-20160816;
        b=rXUIH+wcjQ5TOBKvojYsUKqbkAhqX7J7kjGbQr0BpKcnlby0rIAvN0CHQgiX1THfrP
         1Y1aklIbv4XQEQ65Ife3cybD7nm95OBXmt/rz7/2jlJQbOg13x2Or0UFVzvUifNS7a2G
         nKTRQnPDkjA22Cg0evlF1Gr8gRWAAan8zNFMquhjuV18lkR4jtFOZ1yqM7oHGDO8//U/
         3mrr6dPPaUZJq0HHK5OaygYeGaQ9GqL2KxKjCuW1e2FeHRa9r+w0XCeyIGwdadc21pWz
         apAPfW4NbS8nG7LpRyWIUazhoeYVsb/XIJueolfvlNkMpEaD2gQlFHre7eFQ691+x4H7
         OIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=so6Y1dmXEE927ciqz+rT5NQ4GLB19xNk5sZv588cw3M=;
        b=WnoOOv1AKuLsLSlzaa4o2AewwgfgEsbk6M+keRWSXGjhhQq2LlV8YRU4bJ6MzPOXan
         cOTG+PYX7IvyteJu7TmmObcDJkB6gJ/JRi+z/GO5qLPVSROzllKjN6SvPhEnh5ZUNFXZ
         rQUfJtFrDiJAIsH/QoKzNs2zDNLefaQoLGUzxjpo9sLPEdPv41FQ0iqVk4mxO5G058u5
         xX5P8UmjEdsw2atxZLIi6+to5F5cWpCUz224QqRaxVZc2KTRKS+yV9+vd5+ebadHHwmZ
         4usBLvROiX4iuKEVeZ1G0UYvTQvJckmO+2C1QjV4HKTCTLQ55kew3mQTIt7zuuq8DvwG
         dC4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,335,1520924400";
   d="scan'208";a="50427759"
Date: Fri, 27 Apr 2018 14:30:32 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: driver-api: fix device_connection.rst
 kernel-doc error
Message-ID: <20180427113032.GB31265@kuha.fi.intel.com>
References: <4dcdb5c8-1365-9a0a-81be-893b0d1ea731@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dcdb5c8-1365-9a0a-81be-893b0d1ea731@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598860916051196881?=
X-GMAIL-MSGID: =?utf-8?q?1598898712270544249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 06:29:41PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Using incorrect :functions: syntax (extra space) causes an odd kernel-doc
> warning, so fix that.
> 
> Documentation/driver-api/device_connection.rst:42: ERROR: Error in "kernel-doc" directive:
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  Documentation/driver-api/device_connection.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20180426.orig/Documentation/driver-api/device_connection.rst
> +++ linux-next-20180426/Documentation/driver-api/device_connection.rst
> @@ -40,4 +40,4 @@ API
>  ---
>  
>  .. kernel-doc:: drivers/base/devcon.c
> -   : functions: device_connection_find_match device_connection_find device_connection_add device_connection_remove
> +   :functions: device_connection_find_match device_connection_find device_connection_add device_connection_remove
> 

Thanks,

-- 
heikki
